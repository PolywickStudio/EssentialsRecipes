unit frmAbout;

interface

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  ExtCtrls,
  EsRollUp,
  EsLabel,
  EsTile,
  EsMarque, Vcl.Samples.Spin;

type
  TfrmAboutBox = class(TForm)
    btnClose: TButton;
    btnCollapse: TButton;
    esRollUp1: TEsRollUp;
    pnlBottom: TPanel;
    pnlTop: TPanel;
    pnlLeft: TPanel;
    ProgramIcon: TImage;
    pnlClient: TPanel;
    lblProductName: TEsScrollingMarquee;
    lblVersion: TEsLabel;
    lblOS: TEsLabel;
    lblCopyright: TEsLabel;
    pnlMem: TPanel;
    lblMem: TEsLabel;
    lblPhysMem: TEsLabel;
    pnlSettings: TPanel;
    Bevel1: TBevel;
    EsLabel1: TEsLabel;
    lblNone: TEsLabel;
    cbActive: TCheckBox;
    lblAppearance: TLabel;
    cbAppearance: TComboBox;
    lblTextColor: TLabel;
    lblShadowDir1: TLabel;
    cbShadowDir: TComboBox;
    lblShadowDepth1: TLabel;
    spShadowDepth: TSpinEdit;
    lblShadowColor1: TLabel;
    cbShadowColor: TColorBox;
    lblShadowStyle: TLabel;
    cbShadowStyle: TComboBox;
    lblHighlightDir1: TLabel;
    cbHighlightDir: TComboBox;
    lblHighlightDepth1: TLabel;
    spHighlightDepth: TSpinEdit;
    lblHighlightColor1: TLabel;
    cbHighlightColor: TColorBox;
    lblHighlightStyle: TLabel;
    cbHighlightStyle: TComboBox;
    cbTextColor: TColorBox;
    Panel1: TPanel;
    lblURL: TEsLabel;
    Panel2: TPanel;
    lblEMAIL: TEsLabel;
    lblURL1: TEsLabel;
    lblEMAIL1: TEsLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure btnCollapseClick(Sender: TObject);
    procedure lblEMAILClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblURLClick(Sender: TObject);
    procedure cbAppearanceChange(Sender: TObject);
    procedure cbActiveClick(Sender: TObject);
    procedure CustomChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure esRollUp1RollUp(Sender: TObject);
  private
    bProgramModifying: boolean;
    function Regkey(Key: HKEY; Subkey: string;
      var Data: string): Longint;
    procedure GetOSInfo;
    procedure SaveSettings;
    procedure LoadSettings;
    procedure UpdateTextStyles;
    procedure UpdateMaqueeStyle;
    procedure InitializeCaptions;
  public
    class procedure Execute;
  end;

implementation

uses
  ShellAPI,
  INIFiles;

{$R *.DFM}

function GetShadeStyle(AStr: string): TEsShadeStyle;
begin
  Result := ssPlain;
  if AStr = 'Extrude' then begin
    Result := ssExtrude;
  end;
  if AStr = 'Graduated' then begin
    Result := ssGraduated;
  end;
end;

function GetAppearance(AStr: string): TEsAppearance;
begin
  Result := apNone;
  if AStr = 'None' then begin
    Result := apNone;
  end;
  if AStr = 'Raised' then begin
    Result := apRaised;
  end;
  if AStr = 'Flying' then begin
    Result := apFlying;
  end;
  if AStr = 'Shadow' then begin
    Result := apShadow;
  end;
  if AStr = 'Sunken' then begin
    Result := apSunken;
  end;
  if AStr = 'Custom' then begin
    Result := apCustom;
  end;
end;

function GetShadowDirection(AVal: String): TEsShadeDirection;
begin
  Result := sdNone;
  if (AVal = 'None') then begin
    Result := sdNone;
  end;
  if (AVal = 'Down') then begin
    Result := sdDown;
  end;
  if (AVal = 'Down Left') then begin
    Result := sdDownLeft;
  end;
  if (AVal = 'Down Right') then begin
    Result := sdDownRight;
  end;
  if (AVal = 'Left') then begin
    Result := sdLeft;
  end;
  if (AVal = 'Right') then begin
    Result := sdRight;
  end;
  if (AVal = 'Up') then begin
    Result := sdUp;
  end;
  if (AVal = 'Up Left') then begin
    Result := sdUpLeft;
  end;
  if (AVal = 'Up Right') then begin
    Result := sdUpRight;
  end;
end;

function GetColorScheme(AStr: string): TEsColorScheme;
begin
  Result := csText;
  if AStr = 'Text' then begin
    Result := csText;
  end;
  if AStr = 'Embossed' then begin
    Result := csEmbossed;
  end;
  if AStr = 'Gold' then begin
    Result := csGold;
  end;
  if AStr = 'Steel' then begin
    Result := csSteel;
  end;
  if AStr = 'Windows' then begin
    Result := csWindows;
  end;
  if AStr = 'Custom' then begin
    Result := csCustom;
  end;
end;

function GetAppVersionStr: string;
var
  Exe: string;
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;
begin
  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
  if Size = 0 then
    RaiseLastOSError;
  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;
  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;
  Result := Format('%d.%d.%d.%d',
    [LongRec(FixedPtr.dwFileVersionMS).Hi, //major
      LongRec(FixedPtr.dwFileVersionMS).Lo, //minor
      LongRec(FixedPtr.dwFileVersionLS).Hi, //release
      LongRec(FixedPtr.dwFileVersionLS).Lo]) //build
end;

class procedure TfrmAboutBox.Execute;
var
  frm: TfrmAboutBox;
begin
  frm := TfrmAboutBox.Create(nil);
  frm.ShowModal;
  frm.Free;
end;

procedure TfrmAboutBox.FormCreate(Sender: TObject);
begin
  bProgramModifying := false;
  esRollUp1.MinHeight := pnlTop.Height + pnlBottom.Height + 6;
  InitializeCaptions;
end;

procedure TfrmAboutBox.SaveSettings;
var
  sINI: TIniFile;
begin
  sINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.ini');
  if (cbActive.Checked) then begin
    sINI.WriteString('TextSettings', 'ActiveMarquee', 'True');
  end else begin
    sINI.WriteString('TextSettings', 'ActiveMarquee', 'False');
  end;
  sINI.WriteString('TextSettings', 'TextAppearance', cbAppearance.Text);
  sINI.WriteString('TextSettings', 'TextColor', ColorToString(cbTextColor.Selected));
  sINI.WriteString('TextSettings', 'TextShadowColor', ColorToString(cbShadowColor.Selected));
  sINI.WriteString('TextSettings', 'TextHighlightColor', ColorToString(cbHighlightColor.Selected));
  sINI.WriteString('TextSettings', 'TextShadowDir', cbShadowDir.Text);
  sINI.WriteString('TextSettings', 'TextHighlightDir', cbHighlightDir.Text);
  sINI.WriteString('TextSettings', 'TextShadowStyle', cbShadowStyle.Text);
  sINI.WriteString('TextSettings', 'TextHighlightStyle', cbHighlightStyle.Text);
  sINI.WriteString('TextSettings', 'TextShadowDepth', spShadowDepth.Text);
  sINI.WriteString('TextSettings', 'TextHighlightDepth', spHighlightDepth.Text);
  sINI.Free;
end;

procedure TfrmAboutBox.LoadSettings;
var
  sINI: TIniFile;
  sVal: string;
begin
  bProgramModifying := true;
  sINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.ini');
  sVal := sINI.ReadString('TextSettings', 'ActiveMarquee', 'False');
  cbActive.Checked := StrToBool(sVal);
  //cbAppearance.Text := sINI.ReadString('TextSettings', 'TextAppearance', 'None');
  cbAppearance.ItemIndex := cbAppearance.Items.IndexOf(sINI.ReadString('TextSettings', 'TextAppearance', 'None'));
  cbTextColor.Selected := StringToColor(sINI.ReadString('TextSettings', 'TextColor', 'clBlack'));
  cbShadowColor.Selected := StringToColor(sINI.ReadString('TextSettings', 'TextShadowColor', 'clGray'));
  cbHighlightColor.Selected := StringToColor(sINI.ReadString('TextSettings', 'TextHighlightColor', 'clWhite'));
  cbShadowDir.ItemIndex := cbShadowDir.Items.IndexOf(sINI.ReadString('TextSettings', 'TextShadowDir', 'None'));
  cbHighlightDir.ItemIndex := cbHighlightDir.Items.IndexOf(sINI.ReadString('TextSettings', 'TextHighlightDir', 'None'));
  cbShadowStyle.ItemIndex := cbShadowStyle.Items.IndexOf(sINI.ReadString('TextSettings', 'TextShadowStyle', 'Plain'));
  cbHighlightStyle.ItemIndex := cbHighlightStyle.Items.IndexOf(sINI.ReadString('TextSettings', 'TextHighlightStyle', 'Plain'));
  spShadowDepth.Text := sINI.ReadString('TextSettings', 'TextShadowDepth', '0');
  spHighlightDepth.Text := sINI.ReadString('TextSettings', 'TextHighlightDepth', '0');
  UpdateTextStyles;
  sINI.Free;
  bProgramModifying := false;
end;

function TfrmAboutBox.RegKey(Key: HKEY; Subkey: string; var Data: string): Longint;
var
  H: HKEY;
  tData: array[0..259] of Char;
  dSize: Integer;
begin
  Result := RegOpenKeyEx(Key, PChar(Subkey), 0, KEY_QUERY_VALUE, H);
  if Result = ERROR_SUCCESS then begin
    dSize := Sizeof(tData);
    RegQueryValue(H, nil, tData, dSize);
    Data := StrPas(tData);
    RegCloseKey(H);
  end;
end;

procedure TfrmAboutBox.GetOSInfo;
var
  Platform: string;
  BuildNumber: Integer;
begin
  case Win32Platform of
    VER_PLATFORM_WIN32_WINDOWS: begin
        Platform := 'Windows 95';
        BuildNumber := Win32BuildNumber and $0000FFFF;
      end;
    VER_PLATFORM_WIN32_NT: begin
        Platform := 'Windows NT';
        BuildNumber := Win32BuildNumber;
      end;
  else begin
      Platform := 'Windows';
      BuildNumber := 0;
    end;
  end;
  if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) or
    (Win32Platform = VER_PLATFORM_WIN32_NT) then begin
    if Win32CSDVersion = '' then begin
      lblOS.Caption := Format('%s %d.%d (Build %d)', [Platform, Win32MajorVersion,
          Win32MinorVersion, BuildNumber])
    end else begin
      lblOS.Caption := Format('%s %d.%d (Build %d: %s)', [Platform, Win32MajorVersion,
          Win32MinorVersion, BuildNumber, Win32CSDVersion]);
    end;
  end else begin
    lblOS.Caption := Format('%s %d.%d', [Platform, Win32MajorVersion,
        Win32MinorVersion])
  end;
end;

procedure TfrmAboutBox.InitializeCaptions;
var
  ms: TMemoryStatus;
const
  sURL = 'https://github.com/TurboPack/Essentials/';
  sEmail = 'support@turbopower.com';
begin
  GetOSInfo;
  ms.dwLength := Sizeof(TMemoryStatus);
  GlobalMemoryStatus(ms);
  lblPhysMem.Caption := FormatFloat('#,###" KB"', ms.dwTotalPhys div 1024);
  lblVersion.Caption := 'Version: ' + GetAppVersionStr;
  lblEmail.Caption := sEmail;
  lblURL.Caption := sURl;
  esRollUp1.RolledUp := true;
end;

procedure TfrmAboutBox.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then begin
    Key := 0;
    Close;
  end;
end;

procedure TfrmAboutBox.FormShow(Sender: TObject);
begin
  LoadSettings;
end;

procedure TfrmAboutBox.btnCloseClick(Sender: TObject);
begin
  SaveSettings;
  Close;
end;

procedure TfrmAboutBox.btnCollapseClick(Sender: TObject);
begin
  esRollUp1.RolledUp := not esRollUp1.RolledUp;
end;

procedure TfrmAboutBox.cbActiveClick(Sender: TObject);
begin
  UpdateMaqueeStyle;
end;

procedure TfrmAboutBox.cbAppearanceChange(Sender: TObject);

  function GetColorSchemeName(AColorScheme: TEsColorScheme): string;
  begin
    Result := 'Text';
    if AColorScheme = csCustom then begin
      Result := 'Custom';
    end;
    if AColorScheme = csText then begin
      Result := 'Text';
    end;
    if AColorScheme = csWindows then begin
      Result := 'Windows';
    end;
    if AColorScheme = csEmbossed then begin
      Result := 'Embossed';
    end;
    if AColorScheme = csGold then begin
      Result := 'Gold';
    end;
    if AColorScheme = csSteel then begin
      Result := 'Steel';
    end;
  end;

  function GetShadeDirName(Direction: TEsShadeDirection): string;
  begin
    Result := 'None';
    if Direction = sdUp then begin
      Result := 'Up';
    end;
    if Direction = sdUp then begin
      Result := 'Up';
    end;
    if Direction = sdUpRight then begin
      Result := 'Up Right';
    end;
    if Direction = sdRight then begin
      Result := 'Right';
    end;
    if Direction = sdDownRight then begin
      Result := 'Down Right';
    end;
    if Direction = sdDown then begin
      Result := 'Down';
    end;
    if Direction = sdDownLeft then begin
      Result := 'Down Left';
    end;
    if Direction = sdLeft then begin
      Result := 'Left';
    end;
    if Direction = sdUpLeft then begin
      Result := 'Up Left';
    end;
  end;

  function GetShadeStyleName(AStr: TEsShadeStyle): string;
  begin
    Result := 'Plain';
    if (AStr = TEsShadeStyle.ssExtrude) then begin
      Result := 'Extrude';
    end;
    if (AStr = TEsShadeStyle.ssGraduated) then begin
      Result := 'Graduated';
    end;
  end;

begin
  if bProgramModifying = false then begin
    lblNone.Appearance := GetAppearance(cbAppearance.Text);
    cbShadowDir.Text := GetShadeDirName(lblNone.CustomSettings.ShadowDirection);
    cbShadowStyle.Text := GetShadeStyleName(lblNone.CustomSettings.ShadowStyle);
    spShadowDepth.Value := lblNone.CustomSettings.ShadowDepth;
    cbShadowColor.Selected := lblNone.CustomSettings.ShadowColor;
    cbHighlightDir.Text := GetShadeDirName(lblNone.CustomSettings.HighlightDirection);
    cbHighlightStyle.Text := GetShadeStyleName(lblNone.CustomSettings.HighlightStyle);
    spHighlightDepth.Value := lblNone.CustomSettings.HighlightDepth;
    cbHighlightColor.Selected := lblNone.CustomSettings.HighlightColor;
  end;
  UpdateTextStyles;
end;

procedure TfrmAboutBox.CustomChange(Sender: TObject);
begin
  UpdateTextStyles;
end;

procedure TfrmAboutBox.esRollUp1RollUp(Sender: TObject);
var
  bTab: boolean;
begin
  bTab := not esRollUp1.RolledUp;
  cbActive.TabStop := bTab;
  cbAppearance.TabStop := bTab;
  cbTextColor.TabStop := bTab;
  cbShadowColor.TabStop := bTab;
  cbShadowDir.TabStop := bTab;
  cbShadowStyle.TabStop := bTab;
  spShadowDepth.TabStop := bTab;
  cbHighlightColor.TabStop := bTab;
  cbHighlightDir.TabStop := bTab;
  cbHighlightStyle.TabStop := bTab;
  spHighlightDepth.TabStop := bTab;
end;

procedure TfrmAboutBox.lblEMAILClick(Sender: TObject);
var
  sEmail: string;
begin
  sEmail := lblEMAIL.Caption;
  if sEmail.StartsWith('Email: ', true) then begin
    sEmail := sEmail.Replace('Email: ', '', []);
  end;
  if ShellExecute(0, nil, PChar('mailto:' + sEmail), nil, nil, SW_NORMAL) < 32 then begin
    ShowMessage('Couldn''t launch default email app');
  end;
end;

procedure TfrmAboutBox.lblURLClick(Sender: TObject);
var
  P: Integer;
  Key: string;
  sOpen: string;
  sURL: string;
begin
  if Regkey(HKEY_CLASSES_ROOT, '.htm', Key) = ERROR_SUCCESS then begin
    //Key := Key + '\shell\open\command';
    if Regkey(HKEY_CLASSES_ROOT, Key, Key) = ERROR_SUCCESS then begin
      P := Pos('"%1"', Key);
      if P = 0 then
        P := Pos('%1', Key);
      if P <> 0 then
        setlength(Key, P - 1);
      sOpen := 'open';
      sURL := lblURL.Caption;
      if sURL.StartsWith('URL: ', true) then begin
        sURL := sURL.Replace('URL: ', '', []);
      end;
      Key := sURL;
      if ShellExecute(0, PChar(sOpen), PChar(Key), '', '', SW_NORMAL) <= 32 then begin
        ShowMessage('Couldn''t launch default browser');
      end;
    end;
  end;
end;

procedure TfrmAboutBox.UpdateTextStyles;
var
  vAppearance: TEsAppearance;
  //vColorScheme: TEsColorScheme;
  vShadeDir: TEsShadeDirection;
  vShadeStyle: TEsShadeStyle;
begin
  // APPEARANCE
  vAppearance := GetAppearance(cbAppearance.Text);
  lblVersion.Appearance := vAppearance;
  lblCopyright.Appearance := vAppearance;
  lblURL.Appearance := vAppearance;
  lblEMAIL.Appearance := vAppearance;
  lblURL1.Appearance := vAppearance;
  lblEMAIL1.Appearance := vAppearance;
  lblOS.Appearance := vAppearance;
  lblMem.Appearance := vAppearance;
  lblPhysMem.Appearance := vAppearance;
  lblProductName.Appearance := vAppearance;

  // TEXT COLOR
  lblVersion.Font.Color := cbTextColor.Selected;
  lblCopyright.Font.Color := cbTextColor.Selected;
  lblURL.Font.Color := cbTextColor.Selected;
  lblEMAIL.Font.Color := cbTextColor.Selected;
  lblURL1.Font.Color := cbTextColor.Selected;
  lblEMAIL1.Font.Color := cbTextColor.Selected;
  lblOS.Font.Color := cbTextColor.Selected;
  lblMem.Font.Color := cbTextColor.Selected;
  lblPhysMem.Font.Color := cbTextColor.Selected;
  lblProductName.Font.Color := cbTextColor.Selected;

  {// COLOR SCHEME
  vColorScheme := GetColorScheme(cbColorScheme.Text);
  lblVersion.ColorScheme := vColorScheme;
  lblCopyright.ColorScheme := vColorScheme;
  lblURL.ColorScheme := vColorScheme;
  lblEMAIL.ColorScheme := vColorScheme;
  lblURL1.ColorScheme := vColorScheme;
  lblEMAIL1.ColorScheme := vColorScheme;
  lblOS.ColorScheme := vColorScheme;
  lblMem.ColorScheme := vColorScheme;
  lblPhysMem.ColorScheme := vColorScheme;
  lblProductName.ColorScheme := vColorScheme;
  }
  // SHADOW
  vShadeDir := GetShadowDirection(cbShadowDir.Text);
  lblVersion.CustomSettings.ShadowDirection := vShadeDir;
  lblCopyright.CustomSettings.ShadowDirection := vShadeDir;
  lblURL.CustomSettings.ShadowDirection := vShadeDir;
  lblEMAIL.CustomSettings.ShadowDirection := vShadeDir;
  lblURL1.CustomSettings.ShadowDirection := vShadeDir;
  lblEMAIL1.CustomSettings.ShadowDirection := vShadeDir;
  lblOS.CustomSettings.ShadowDirection := vShadeDir;
  lblMem.CustomSettings.ShadowDirection := vShadeDir;
  lblPhysMem.CustomSettings.ShadowDirection := vShadeDir;
  lblProductName.CustomSettings.ShadowDirection := vShadeDir;
  //
  vShadeStyle := GetShadeStyle(cbShadowStyle.Text);
  lblVersion.CustomSettings.ShadowStyle := vShadeStyle;
  lblCopyright.CustomSettings.ShadowStyle := vShadeStyle;
  lblURL.CustomSettings.ShadowStyle := vShadeStyle;
  lblEMAIL.CustomSettings.ShadowStyle := vShadeStyle;
  lblURL1.CustomSettings.ShadowStyle := vShadeStyle;
  lblEMAIL1.CustomSettings.ShadowStyle := vShadeStyle;
  lblOS.CustomSettings.ShadowStyle := vShadeStyle;
  lblMem.CustomSettings.ShadowStyle := vShadeStyle;
  lblPhysMem.CustomSettings.ShadowStyle := vShadeStyle;
  lblProductName.CustomSettings.ShadowStyle := vShadeStyle;
  //
  lblVersion.CustomSettings.ShadowDepth := spShadowDepth.Value;
  lblCopyright.CustomSettings.ShadowDepth := spShadowDepth.Value;
  lblURL.CustomSettings.ShadowDepth := spShadowDepth.Value;
  lblEMAIL.CustomSettings.ShadowDepth := spShadowDepth.Value;
  lblURL1.CustomSettings.ShadowDepth := spShadowDepth.Value;
  lblEMAIL1.CustomSettings.ShadowDepth := spShadowDepth.Value;
  lblOS.CustomSettings.ShadowDepth := spShadowDepth.Value;
  lblMem.CustomSettings.ShadowDepth := spShadowDepth.Value;
  lblPhysMem.CustomSettings.ShadowDepth := spShadowDepth.Value;
  lblProductName.CustomSettings.ShadowDepth := spShadowDepth.Value;
  //
  lblVersion.CustomSettings.ShadowColor := cbShadowColor.Selected;
  lblCopyright.CustomSettings.ShadowColor := cbShadowColor.Selected;
  lblURL.CustomSettings.ShadowColor := cbShadowColor.Selected;
  lblEMAIL.CustomSettings.ShadowColor := cbShadowColor.Selected;
  lblURL1.CustomSettings.ShadowColor := cbShadowColor.Selected;
  lblEMAIL1.CustomSettings.ShadowColor := cbShadowColor.Selected;
  lblOS.CustomSettings.ShadowColor := cbShadowColor.Selected;
  lblMem.CustomSettings.ShadowColor := cbShadowColor.Selected;
  lblPhysMem.CustomSettings.ShadowColor := cbShadowColor.Selected;
  lblProductName.CustomSettings.ShadowColor := cbShadowColor.Selected;

  // HIGHLIGHT
  vShadeDir := GetShadowDirection(cbHighlightDir.Text);
  lblVersion.CustomSettings.HighlightDirection := vShadeDir;
  lblCopyright.CustomSettings.HighlightDirection := vShadeDir;
  lblURL.CustomSettings.HighlightDirection := vShadeDir;
  lblEMAIL.CustomSettings.HighlightDirection := vShadeDir;
  lblURL1.CustomSettings.HighlightDirection := vShadeDir;
  lblEMAIL1.CustomSettings.HighlightDirection := vShadeDir;
  lblOS.CustomSettings.HighlightDirection := vShadeDir;
  lblMem.CustomSettings.HighlightDirection := vShadeDir;
  lblPhysMem.CustomSettings.HighlightDirection := vShadeDir;
  lblProductName.CustomSettings.HighlightDirection := vShadeDir;
  //
  vShadeStyle := GetShadeStyle(cbHighlightStyle.Text);
  lblVersion.CustomSettings.HighlightStyle := vShadeStyle;
  lblCopyright.CustomSettings.HighlightStyle := vShadeStyle;
  lblURL.CustomSettings.HighlightStyle := vShadeStyle;
  lblEMAIL.CustomSettings.HighlightStyle := vShadeStyle;
  lblURL1.CustomSettings.HighlightStyle := vShadeStyle;
  lblEMAIL1.CustomSettings.HighlightStyle := vShadeStyle;
  lblOS.CustomSettings.HighlightStyle := vShadeStyle;
  lblMem.CustomSettings.HighlightStyle := vShadeStyle;
  lblPhysMem.CustomSettings.HighlightStyle := vShadeStyle;
  lblProductName.CustomSettings.HighlightStyle := vShadeStyle;
  //
  lblVersion.CustomSettings.HighlightDepth := spHighlightDepth.Value;
  lblCopyright.CustomSettings.HighlightDepth := spHighlightDepth.Value;
  lblURL.CustomSettings.HighlightDepth := spHighlightDepth.Value;
  lblEMAIL.CustomSettings.HighlightDepth := spHighlightDepth.Value;
  lblURL1.CustomSettings.HighlightDepth := spHighlightDepth.Value;
  lblEMAIL1.CustomSettings.HighlightDepth := spHighlightDepth.Value;
  lblOS.CustomSettings.HighlightDepth := spHighlightDepth.Value;
  lblMem.CustomSettings.HighlightDepth := spHighlightDepth.Value;
  lblPhysMem.CustomSettings.HighlightDepth := spHighlightDepth.Value;
  lblProductName.CustomSettings.HighlightDepth := spHighlightDepth.Value;
  //
  lblVersion.CustomSettings.HighlightColor := cbHighlightColor.Selected;
  lblCopyright.CustomSettings.HighlightColor := cbHighlightColor.Selected;
  lblURL.CustomSettings.HighlightColor := cbHighlightColor.Selected;
  lblEMAIL.CustomSettings.HighlightColor := cbHighlightColor.Selected;
  lblURL1.CustomSettings.HighlightColor := cbHighlightColor.Selected;
  lblEMAIL1.CustomSettings.HighlightColor := cbHighlightColor.Selected;
  lblOS.CustomSettings.HighlightColor := cbHighlightColor.Selected;
  lblMem.CustomSettings.HighlightColor := cbHighlightColor.Selected;
  lblPhysMem.CustomSettings.HighlightColor := cbHighlightColor.Selected;
  lblProductName.CustomSettings.HighlightColor := cbHighlightColor.Selected;
  //
  UpdateMaqueeStyle;
end;

procedure TfrmAboutBox.UpdateMaqueeStyle;
begin
  lblProductName.Active := cbActive.Checked;
end;

end.

