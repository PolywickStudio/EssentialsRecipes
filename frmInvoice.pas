unit frmInvoice;

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
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  EsLabel,
  EsEdCalc,
  EsEdPop,
  EsEdCal,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TfrmInvoiceForm = class(TForm)
    dbTable: TFDTable;
    gdInvoices: TDBGrid;
    spSplitter: TSplitter;
    dsTable: TDataSource;
    pnlDetails: TPanel;
    edtTransactDate: TEsDateEdit;
    EsLabel1: TEsLabel;
    conn: TFDConnection;
    dbTableid: TStringField;
    dbTableencodedate: TSQLTimeStampField;
    dbTabletransactdate: TDateTimeField;
    dbTableamount: TCurrencyField;
    dbTablecustomername: TStringField;
    dbTablebillingaddress: TStringField;
    EsLabel2: TEsLabel;
    edtEncodeDate: TEsDateEdit;
    EsLabel3: TEsLabel;
    EsLabel4: TEsLabel;
    edtAddress: TEdit;
    edtCustomer: TEdit;
    EsLabel5: TEsLabel;
    edtAmount: TEsNumberEdit;
    pnlBottom: TPanel;
    btnAdd: TButton;
    btnCancel: TButton;
    btnPost: TButton;
    btnEdit: TButton;
    procedure dbTableAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure dbTableNewRecord(DataSet: TDataSet);
    procedure btnAddClick(Sender: TObject);
    procedure dsTableStateChange(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEditClick(Sender: TObject);
    procedure edtTransactDateGetDate(Sender: TObject; var Value: string);
    procedure edtAmountKeyPress(Sender: TObject; var Key: Char);
  private
    bProgramModifying: boolean;
    procedure LoadData;
  public
    { Public declarations }
  end;

var
  frmInvoiceForm: TfrmInvoiceForm;

implementation

{$R *.dfm}

procedure TfrmInvoiceForm.FormCreate(Sender: TObject);
begin
  bProgramModifying := false;
  LoadData;
end;

procedure TfrmInvoiceForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmInvoiceForm.dbTableNewRecord(DataSet: TDataSet);
var
  guid: TGUID;
begin
  CreateGUID(guid);
  dbTableid.AsString := GUIDToString(guid);
  dbTableencodedate.AsDateTime := Now;
end;

procedure TfrmInvoiceForm.dsTableStateChange(Sender: TObject);
begin
  if dbTable.State in [dsEdit, dsInsert] then begin
    btnAdd.Visible := false;
    btnEdit.Visible := false;
    btnCancel.Visible := true;
    btnPost.Visible := true;
    //
    edtTransactDate.ReadOnly := false;
    edtCustomer.ReadOnly := false;
    edtAddress.ReadOnly := false;
    edtAmount.ReadOnly := false;
    edtEncodeDate.ReadOnly := false;
  end else begin
    btnAdd.Visible := true;
    btnEdit.Visible := true;
    btnCancel.Visible := false;
    btnPost.Visible := false;
    //
    edtTransactDate.ReadOnly := true;
    edtCustomer.ReadOnly := true;
    edtAddress.ReadOnly := true;
    edtAmount.ReadOnly := true;
    edtEncodeDate.ReadOnly := true;
  end;
end;

procedure TfrmInvoiceForm.edtAmountKeyPress(Sender: TObject; var Key: Char);
var
  ftValue: Currency;
begin
  if TryStrToCurr(edtAmount.Text + Key, ftValue) = false then begin
    Key := #0;
  end;
end;

procedure TfrmInvoiceForm.edtTransactDateGetDate(Sender: TObject;
  var Value: string);
var
  dtValue: TDateTime;
begin
  if TryStrToDate(Value, dtValue) = false then begin
    ShowMessage('Invalid Date value!');
    edtTransactDate.SetFocus;
  end;
end;

procedure TfrmInvoiceForm.btnAddClick(Sender: TObject);
begin
  dbTable.Insert;
end;

procedure TfrmInvoiceForm.btnCancelClick(Sender: TObject);
begin
  if dbTable.State in [dsEdit, dsInsert] then begin
    if MessageDlg('Are you sure you want to discard changes?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      dbTable.Cancel;
    end;
  end;
end;

procedure TfrmInvoiceForm.btnEditClick(Sender: TObject);
begin
  dbTable.Edit;
end;

procedure TfrmInvoiceForm.btnPostClick(Sender: TObject);
begin
  if dbTable.State in [dsEdit, dsInsert] then begin
    try
      dbTabletransactdate.AsDateTime := edtTransactDate.Date;
      dbTablecustomername.AsString := edtCustomer.Text;
      dbTablebillingaddress.AsString := edtAddress.Text;
      dbTableamount.AsCurrency := edtAmount.AsFloat;
      dbTable.Post;
    except
      on E: Exception do begin
        ShowMessage(E.Message);
        //dbTable.Cancel;
      end;
    end;
  end;
end;

procedure TfrmInvoiceForm.dbTableAfterScroll(DataSet: TDataSet);
begin
  if bProgramModifying then begin
    Exit;
  end;
  edtEncodeDate.Date := dbTableencodedate.AsDateTime;
  edtTransactDate.Date := dbTabletransactdate.AsDateTime;
  edtCustomer.Text := dbTablecustomername.AsString;
  edtAddress.Text := dbTablebillingaddress.AsString;
  edtAmount.AsFloat := dbTableamount.AsCurrency;
end;

procedure TfrmInvoiceForm.LoadData;
begin
  var sData := ExtractFilePath(ParamStr(0)) + 'sample.db';
  if FileExists(sData) then begin
    conn.Params.Database := sData;
    bProgramModifying := true;
    conn.Connected := true;
    dbTable.Active := true;
    bProgramModifying := false;
    dbTableAfterScroll(dbTable);
  end else begin
    ShowMessage('Sample database not found!');
  end;
end;

end.

