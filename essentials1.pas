unit essentials1;
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
  Vcl.Menus, EsGrad;

type
  TfrmMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Examples1: TMenuItem;
    InvoiceSample1: TMenuItem;
    Background1: TMenuItem;
    About1: TMenuItem;
    bkGradient: TEsGradient;
    procedure btnAboutClick(Sender: TObject);
    procedure btnBackgroundClick(Sender: TObject);
    procedure btnInvoiceClick(Sender: TObject);
  private
  public
  end;

var
  frmMainForm: TfrmMainForm;

implementation
uses
  frmAbout,
  frmInvoice,
  frmSettings,
  INIFiles;

{$R *.dfm}

procedure TfrmMainForm.btnAboutClick(Sender: TObject);
begin
  TfrmAboutBox.Execute;
end;

procedure TfrmMainForm.btnBackgroundClick(Sender: TObject);
var
  ini: TIniFile;
begin
  TfrmSettingsForm.Execute;
  ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.ini');
  try
    bkGradient.Visible := false;
    var sVal := ini.ReadString('Settings', 'ColorGradientDirection', 'vertical');
    if LowerCase(sVal) = 'horizontal' then begin
      bkGradient.Direction := dHorizontal;
    end else begin
      bkGradient.Direction := dVertical;
    end;
  finally
    ini.Free;
  end;
end;

procedure TfrmMainForm.btnInvoiceClick(Sender: TObject);
var
  iNo: Integer;
  bFound: boolean;
begin
  bFound := false;
  for iNo := 0 to (MDIChildCount - 1) do begin
    if (MDIChildren[iNo].ClassName = TfrmInvoiceForm.ClassName) then begin
      bFound := true;
      MDIChildren[iNo].BringToFront;
    end;
  end;
  if (bFound = false) then begin
    var frm := TfrmInvoiceForm.Create(Self);
    frm.Show;
  end;
end;

end.

