unit frmSettings;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  EsClrCbx,
  EsLabel,
  Vcl.ExtDlgs,
  EsGrad,
  EsTile;

type
  TfrmSettingsForm = class(TForm)
    btnOK: TButton;
    cbColorGradient1: TEsColorComboBox;
    cbColorGradient2: TEsColorComboBox;
    cbColorOne: TEsColorComboBox;
    edtImage: TButtonedEdit;
    EsLabel1: TEsLabel;
    pnlBottom: TPanel;
    rbColorGradient: TRadioButton;
    rbColorOne: TRadioButton;
    rbImage: TRadioButton;
    EsLabel2: TEsLabel;
    EsLabel3: TEsLabel;
    btnImageOpen: TButton;
    dlgImageOpen: TOpenPictureDialog;
    cbDirection: TComboBox;
    EsLabel4: TEsLabel;
    bkImage: TEsTile;
    bkGradient: TEsGradient;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rbClick(Sender: TObject);
    procedure btnImageOpenClick(Sender: TObject);
    procedure cbColorChange(Sender: TObject);
    procedure cbDirectionChange(Sender: TObject);
  private
    procedure FormInit;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure FFormResize;
    procedure SetFontStyle(CB: TEsColorComboBox);
  public
    class function Execute: boolean;
  end;

implementation

uses
  System.IniFiles,
  pngimage,
  jpeg;

{$R *.dfm}

class function TfrmSettingsForm.Execute: boolean;
var
  frm: TfrmSettingsForm;
begin
  frm := TfrmSettingsForm.Create(nil);
  frm.FormInit;
  frm.ShowModal;
  Result := true;
  frm.Free;
end;

procedure TfrmSettingsForm.FormInit;
var
  sBkg: string;
  sVal1: string;
  sINI: TIniFile;
begin
  sINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.ini');
  sBkg := LowerCase(sINI.ReadString('Settings', 'Background', 'Single'));
  sVal1 := sINI.ReadString('Settings', 'ColorSingle', 'clBtnFace');
  cbColorOne.SelectedColor := StringToColor(sVal1);
  sVal1 := sINI.ReadString('Settings', 'ColorGradient1', 'clNavy');
  cbColorGradient1.SelectedColor := StringToColor(sVal1);
  sVal1 := sINI.ReadString('Settings', 'ColorGradient2', 'clBlue');
  cbColorGradient2.SelectedColor := StringToColor(sVal1);
  edtImage.Text := sINI.ReadString('Settings', 'BackgroundImage', '');

  sVal1 := sINI.ReadString('Settings', 'ColorGradientDirection', 'vertical');
  if LowerCase(sVal1) = 'horizontal' then begin
    cbDirection.ItemIndex := 0;
  end else begin
    cbDirection.ItemIndex := 1;
  end;

  if (sBkg = 'single') then begin
    rbColorOne.Checked := true;
  end else if (sBkg = 'gradient') then begin
    rbColorGradient.Checked := true;
  end else begin
    rbImage.Checked := true;
  end;
  sINI.Free;
  rbClick(nil);
  //
  LoadSettings;
end;

procedure TfrmSettingsForm.FFormResize;
begin
  Width := bkGradient.Left + bkGradient.Width + 15;
  Height := bkGradient.Top + bkGradient.Height + 83;
  if bkImage.Visible then begin
    if (bkImage.Width < bkGradient.Width) then
    begin
      bkImage.Width := bkGradient.Width
    end;
    if (bkImage.Height < bkGradient.Height) then
    begin
      bkImage.Height := bkGradient.Height;
    end;
    //
    if (bkImage.Width > bkGradient.Width) then
    begin
      Width := bkImage.Left + bkImage.Width + 15;
    end;
    if (bkImage.Height > bkGradient.Height) then
    begin
      Height := bkImage.Top + bkImage.Height + 83;
    end;
  end;
end;

procedure TfrmSettingsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then begin
    Key := 0;
    Close;
  end;
end;

procedure TfrmSettingsForm.rbClick(Sender: TObject);
begin
  edtImage.Enabled := rbImage.Checked;
  cbColorOne.Enabled := rbColorOne.Checked;
  cbColorGradient1.Enabled := rbColorGradient.Checked;
  cbColorGradient2.Enabled := rbColorGradient.Checked;
  cbDirection.Enabled := rbColorGradient.Checked;
  //
  SetFontStyle(cbColorOne);
  SetFontStyle(cbColorGradient1);
  SetFontStyle(cbColorGradient2);
  LoadSettings;
end;

procedure TfrmSettingsForm.cbColorChange(Sender: TObject);
begin
  LoadSettings;
end;

procedure TfrmSettingsForm.cbDirectionChange(Sender: TObject);
begin
  LoadSettings;
end;

procedure TfrmSettingsForm.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSettingsForm.btnOKClick(Sender: TObject);
begin
  SaveSettings;
  Close;
end;

procedure TfrmSettingsForm.btnImageOpenClick(Sender: TObject);
begin
  if dlgImageOpen.Execute(Handle) then begin
    edtImage.Text := dlgImageOpen.FileName;
    LoadSettings;
  end;
end;

procedure TfrmSettingsForm.SetFontStyle(CB: TEsColorComboBox);
begin
  if CB.Enabled then begin
    CB.Font.Color := clBtnText;
  end else begin
    CB.Font.Color := clGray;
  end;
end;

procedure TfrmSettingsForm.SaveSettings;
var
  sINI: TIniFile;
begin
  sINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.ini');
  if (rbColorOne.Checked) then begin
    sINI.WriteString('Settings', 'Background', 'Single');
  end else if (rbColorGradient.Checked) then begin
    sINI.WriteString('Settings', 'Background', 'Gradient');
  end else begin
    sINI.WriteString('Settings', 'Background', 'Image');
  end;
  sINI.WriteString('Settings', 'ColorSingle', ColorToString(cbColorOne.SelectedColor));
  sINI.WriteString('Settings', 'ColorGradient1', ColorToString(cbColorGradient1.SelectedColor));
  sINI.WriteString('Settings', 'ColorGradient2', ColorToString(cbColorGradient2.SelectedColor));
  if (cbDirection.ItemIndex = 0) then begin
    sINI.WriteString('Settings', 'ColorGradientDirection', 'horizontal');
  end else begin
    sINI.WriteString('Settings', 'ColorGradientDirection', 'vertical');
  end;
  sINI.WriteString('Settings', 'BackgroundImage', edtImage.Text);
  sINI.Free;
end;

procedure TfrmSettingsForm.LoadSettings;
var
  sImg: string;
  sColor1, sColor2: string;
begin
  Self.Invalidate;
  bkImage.Visible := false;
  bkGradient.Visible := false;
  if (rbColorOne.Checked) then begin
    sColor1 := ColorToString(cbColorOne.SelectedColor);
    if (sColor1 = '') then begin
      sColor1 := 'clBtnFace';
    end;

    bkGradient.FromColor := StringToColor(sColor1);
    bkGradient.ToColor := bkGradient.FromColor;
    bkGradient.Visible := true;
  end else if (rbColorGradient.Checked) then begin
    sColor1 := ColorToString(cbColorGradient1.SelectedColor);
    sColor2 := ColorToString(cbColorGradient2.SelectedColor);
    if (sColor1 = '') then begin
      sColor1 := 'clBtnFace';
    end;
    if (sColor2 = '') then begin
      sColor2 := 'clBtnFace';
    end;
    if (cbDirection.ItemIndex = 0) then begin
      bkGradient.Direction := dHorizontal;
    end else begin
      bkGradient.Direction := dVertical;
    end;

    bkGradient.FromColor := StringToColor(sColor1);
    bkGradient.ToColor := StringToColor(sColor2);
    bkGradient.Visible := true;
  end else begin
    sImg := edtImage.Text;
    if FileExists(sImg) then begin
      if (ExtractFileExt(sImg) = '.bmp') then begin
        var bmpImage := TBitmap.Create;
        try
          bmpImage.LoadFromFile(sImg);
          bkImage.Bitmap.Assign(bmpImage);
          //
          bkGradient.Visible := false;
          bkImage.Visible := true;
          bkImage.Width := bmpImage.Width;
          bkImage.Height := bmpImage.Height;
        except
          ShowMessage('Cannot load this file. File type might be invalid or is corrupted.');
        end;
        bmpImage.Free;
      end else begin
        var Stream := TMemoryStream.Create;
        try
          Stream.LoadFromFile(sImg);
          Stream.Position := 0;
          var PNGImg := TPngImage.Create;
          PNGImg.LoadFromStream(Stream);
          bkImage.Bitmap.Assign(PNGImg);
          //
          bkGradient.Visible := false;
          bkImage.Visible := true;
          bkImage.Width := PNGImg.Width;
          bkImage.Height := PNGImg.Height;
          PNGImg.Free;
        except
          ShowMessage('Cannot load this file. File type might be invalid or is corrupted.');
        end;
        Stream.Free;
      end;
    end;
  end;
  FFormResize;
  Self.Invalidate;
end;

end.
