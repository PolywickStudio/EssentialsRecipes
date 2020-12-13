object frmInvoiceForm: TfrmInvoiceForm
  Left = 0
  Top = 0
  Caption = 'Invoices'
  ClientHeight = 427
  ClientWidth = 973
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object spSplitter: TSplitter
    Left = 425
    Top = 0
    Height = 427
    ExplicitLeft = 424
    ExplicitTop = 208
    ExplicitHeight = 100
  end
  object gdInvoices: TDBGrid
    Left = 0
    Top = 0
    Width = 425
    Height = 427
    Align = alLeft
    DataSource = dsTable
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'encodedate'
        Title.Caption = 'Encode Date'
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'transactdate'
        Title.Caption = 'Transaction Date'
        Width = 106
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'customername'
        Title.Caption = 'Customer'
        Width = 137
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'amount'
        Title.Caption = 'Amount'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'billingaddress'
        Visible = False
      end>
  end
  object pnlDetails: TPanel
    Left = 428
    Top = 0
    Width = 545
    Height = 427
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlDetails'
    ShowCaption = False
    TabOrder = 1
    object EsLabel1: TEsLabel
      Left = 24
      Top = 49
      Width = 105
      Height = 17
      Appearance = apNone
      Caption = 'Transaction Date'
      ColorScheme = csCustom
      CustomSettings.HighlightDepth = 0
      CustomSettings.HighlightDirection = sdNone
      CustomSettings.ShadowDepth = 0
      CustomSettings.ShadowDirection = sdNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object EsLabel2: TEsLabel
      Left = 294
      Top = 49
      Width = 85
      Height = 17
      Appearance = apNone
      Caption = 'Encode Date'
      ColorScheme = csCustom
      CustomSettings.HighlightDepth = 0
      CustomSettings.HighlightDirection = sdNone
      CustomSettings.ShadowDepth = 0
      CustomSettings.ShadowDirection = sdNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object EsLabel3: TEsLabel
      Left = 24
      Top = 89
      Width = 105
      Height = 17
      Appearance = apNone
      Caption = 'Customer Name'
      ColorScheme = csCustom
      CustomSettings.HighlightDepth = 0
      CustomSettings.HighlightDirection = sdNone
      CustomSettings.ShadowDepth = 0
      CustomSettings.ShadowDirection = sdNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object EsLabel4: TEsLabel
      Left = 24
      Top = 129
      Width = 105
      Height = 17
      Appearance = apNone
      Caption = 'Billing Address'
      ColorScheme = csCustom
      CustomSettings.HighlightDepth = 0
      CustomSettings.HighlightDirection = sdNone
      CustomSettings.ShadowDepth = 0
      CustomSettings.ShadowDirection = sdNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object EsLabel5: TEsLabel
      Left = 24
      Top = 172
      Width = 105
      Height = 17
      Appearance = apNone
      Caption = 'Amount'
      ColorScheme = csCustom
      CustomSettings.HighlightDepth = 0
      CustomSettings.HighlightDirection = sdNone
      CustomSettings.ShadowDepth = 0
      CustomSettings.ShadowDirection = sdNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtTransactDate: TEsDateEdit
      Left = 135
      Top = 46
      Width = 137
      Height = 23
      Epoch = 2000
      EsLabelInfo.OffsetX = 0
      EsLabelInfo.OffsetY = 0
      EsLabelInfo.Visible = False
      PopupCalColors.ActiveDay = clRed
      PopupCalColors.ColorScheme = csWindows
      PopupCalColors.DayNames = clMaroon
      PopupCalColors.Days = clBlack
      PopupCalColors.InactiveDays = clGray
      PopupCalColors.MonthAndYear = clBlue
      PopupCalColors.Weekend = clRed
      PopupCalFont.Charset = DEFAULT_CHARSET
      PopupCalFont.Color = clWindowText
      PopupCalFont.Height = -11
      PopupCalFont.Name = 'Tahoma'
      PopupCalFont.Style = []
      ReadOnly = True
      RequiredFields = [rfMonth, rfDay]
      TabOrder = 0
      TodayString = 'Tod'
      OnGetDate = edtTransactDateGetDate
    end
    object edtEncodeDate: TEsDateEdit
      Left = 384
      Top = 46
      Width = 137
      Height = 23
      Epoch = 2000
      EsLabelInfo.OffsetX = 0
      EsLabelInfo.OffsetY = 0
      EsLabelInfo.Visible = False
      PopupCalColors.ActiveDay = clRed
      PopupCalColors.ColorScheme = csWindows
      PopupCalColors.DayNames = clMaroon
      PopupCalColors.Days = clBlack
      PopupCalColors.InactiveDays = clGray
      PopupCalColors.MonthAndYear = clBlue
      PopupCalColors.Weekend = clRed
      PopupCalFont.Charset = DEFAULT_CHARSET
      PopupCalFont.Color = clWindowText
      PopupCalFont.Height = -11
      PopupCalFont.Name = 'Tahoma'
      PopupCalFont.Style = []
      ReadOnly = True
      RequiredFields = [rfMonth, rfDay]
      TabOrder = 1
      TodayString = '/'
    end
    object edtAddress: TEdit
      Left = 135
      Top = 126
      Width = 386
      Height = 23
      ReadOnly = True
      TabOrder = 3
    end
    object edtCustomer: TEdit
      Left = 135
      Top = 86
      Width = 386
      Height = 23
      ReadOnly = True
      TabOrder = 2
    end
    object edtAmount: TEsNumberEdit
      Left = 135
      Top = 169
      Width = 137
      Height = 23
      EsLabelInfo.OffsetX = 0
      EsLabelInfo.OffsetY = 0
      EsLabelInfo.Visible = False
      PopupCalcColors.ColorScheme = csWindows
      PopupCalcColors.DisabledMemoryButtons = clGray
      PopupCalcColors.Display = clWindow
      PopupCalcColors.DisplayText = clWindowText
      PopupCalcColors.EditButtons = clMaroon
      PopupCalcColors.FunctionButtons = clNavy
      PopupCalcColors.MemoryButtons = clRed
      PopupCalcColors.NumberButtons = clBlue
      PopupCalcColors.OperatorButtons = clRed
      PopupCalcFont.Charset = DEFAULT_CHARSET
      PopupCalcFont.Color = clWindowText
      PopupCalcFont.Height = -12
      PopupCalcFont.Name = 'Segoe UI'
      PopupCalcFont.Style = []
      PopupCalcHeight = 200
      PopupCalcWidth = 250
      ReadOnly = True
      TabOrder = 4
      OnKeyPress = edtAmountKeyPress
    end
    object pnlBottom: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 389
      Width = 539
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 5
      object btnAdd: TButton
        AlignWithMargins = True
        Left = 330
        Top = 3
        Width = 100
        Height = 29
        Align = alRight
        Caption = '&New'
        TabOrder = 2
        OnClick = btnAddClick
      end
      object btnCancel: TButton
        AlignWithMargins = True
        Left = 118
        Top = 3
        Width = 100
        Height = 29
        Align = alRight
        Caption = '&Cancel'
        TabOrder = 0
        Visible = False
        OnClick = btnCancelClick
      end
      object btnPost: TButton
        AlignWithMargins = True
        Left = 224
        Top = 3
        Width = 100
        Height = 29
        Align = alRight
        Caption = '&Post'
        TabOrder = 1
        Visible = False
        OnClick = btnPostClick
      end
      object btnEdit: TButton
        AlignWithMargins = True
        Left = 436
        Top = 3
        Width = 100
        Height = 29
        Align = alRight
        Caption = '&Edit'
        TabOrder = 3
        OnClick = btnEditClick
      end
    end
  end
  object dbTable: TFDTable
    AfterScroll = dbTableAfterScroll
    OnNewRecord = dbTableNewRecord
    IndexFieldNames = 'id'
    Connection = conn
    UpdateOptions.UpdateTableName = 'invoice'
    TableName = 'invoice'
    Left = 40
    Top = 368
    object dbTableid: TStringField
      FieldName = 'id'
      Origin = 'id'
      Required = True
      Size = 36
    end
    object dbTableencodedate: TSQLTimeStampField
      FieldName = 'encodedate'
      Origin = 'encodedate'
      Required = True
    end
    object dbTabletransactdate: TDateTimeField
      FieldName = 'transactdate'
      Origin = 'transactdate'
      Required = True
    end
    object dbTableamount: TCurrencyField
      FieldName = 'amount'
      Origin = 'amount'
    end
    object dbTablecustomername: TStringField
      FieldName = 'customername'
      Origin = 'customername'
      Size = 255
    end
    object dbTablebillingaddress: TStringField
      FieldName = 'billingaddress'
      Origin = 'billingaddress'
      Size = 255
    end
  end
  object dsTable: TDataSource
    DataSet = dbTable
    OnStateChange = dsTableStateChange
    Left = 104
    Top = 368
  end
  object conn: TFDConnection
    Params.Strings = (
      
        'Database=c:\Users\Public\Delphi\embarcadero\essentials\Win32\Deb' +
        'ug\sample.db'
      'DriverID=SQLite')
    Left = 168
    Top = 368
  end
end
