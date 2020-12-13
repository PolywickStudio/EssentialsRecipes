program essentialsapp;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  essentials1 in 'essentials1.pas' {frmMainForm},
  frmAbout in 'frmAbout.pas' {frmAboutBox},
  frmSettings in 'frmSettings.pas' {frmSettingsForm},
  frmInvoice in 'frmInvoice.pas' {frmInvoiceForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainForm, frmMainForm);
  Application.Run;
end.
