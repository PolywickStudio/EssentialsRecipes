object frmSettingsForm: TfrmSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 534
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  DesignSize = (
    387
    534)
  PixelsPerInch = 96
  TextHeight = 17
  object EsLabel2: TEsLabel
    AlignWithMargins = True
    Left = 96
    Top = 119
    Width = 46
    Height = 24
    Appearance = apCustom
    Caption = 'From'
    ColorScheme = csText
    CustomSettings.HighlightDepth = 0
    CustomSettings.HighlightDirection = sdNone
    CustomSettings.ShadowColor = clGray
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
    AlignWithMargins = True
    Left = 96
    Top = 147
    Width = 46
    Height = 24
    Appearance = apCustom
    Caption = 'To'
    ColorScheme = csText
    CustomSettings.HighlightDepth = 0
    CustomSettings.HighlightDirection = sdNone
    CustomSettings.ShadowColor = clGray
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
    AlignWithMargins = True
    Left = 90
    Top = 175
    Width = 55
    Height = 24
    Appearance = apCustom
    Caption = 'Direction'
    ColorScheme = csText
    CustomSettings.HighlightDepth = 0
    CustomSettings.HighlightDirection = sdNone
    CustomSettings.ShadowColor = clGray
    CustomSettings.ShadowDepth = 0
    CustomSettings.ShadowDirection = sdNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object EsLabel1: TEsLabel
    AlignWithMargins = True
    Left = 11
    Top = 14
    Width = 645
    Height = 35
    Margins.Left = 10
    Appearance = apNone
    Caption = 'Select Background'
    Color = clBtnFace
    ColorScheme = csCustom
    CustomSettings.HighlightDepth = 0
    CustomSettings.HighlightDirection = sdNone
    CustomSettings.ShadowColor = clGray
    CustomSettings.ShadowDepth = 0
    CustomSettings.ShadowDirection = sdNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object bkGradient: TEsGradient
    Left = 8
    Top = 263
    Width = 368
    Height = 217
    FromColor = clBtnFace
    ToColor = clGray
  end
  object bkImage: TEsTile
    Left = 8
    Top = 263
    Width = 328
    Height = 186
  end
  object pnlBottom: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 496
    Width = 371
    Height = 35
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 9
    object btnOK: TButton
      AlignWithMargins = True
      Left = 268
      Top = 3
      Width = 100
      Height = 29
      Align = alRight
      Caption = '&OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
  end
  object rbColorOne: TRadioButton
    AlignWithMargins = True
    Left = 10
    Top = 46
    Width = 393
    Height = 17
    Margins.Left = 20
    Margins.Top = 5
    Margins.Right = 10
    Caption = 'Single Color'
    Checked = True
    TabOrder = 0
    TabStop = True
    OnClick = rbClick
  end
  object rbColorGradient: TRadioButton
    AlignWithMargins = True
    Left = 10
    Top = 91
    Width = 393
    Height = 17
    Margins.Left = 20
    Margins.Top = 25
    Margins.Right = 10
    Caption = 'Gradient'
    TabOrder = 2
    OnClick = rbClick
  end
  object rbImage: TRadioButton
    AlignWithMargins = True
    Left = 11
    Top = 213
    Width = 393
    Height = 17
    Margins.Left = 20
    Margins.Top = 90
    Margins.Right = 10
    Caption = 'Image'
    TabOrder = 6
    OnClick = rbClick
  end
  object cbColorOne: TEsColorComboBox
    Left = 148
    Top = 69
    Width = 229
    Height = 22
    Enabled = False
    EsLabelInfo.OffsetX = 0
    EsLabelInfo.OffsetY = 0
    EsLabelInfo.Visible = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 1
    OnChange = cbColorChange
  end
  object cbColorGradient1: TEsColorComboBox
    Left = 148
    Top = 114
    Width = 229
    Height = 22
    Enabled = False
    EsLabelInfo.OffsetX = 0
    EsLabelInfo.OffsetY = 0
    EsLabelInfo.Visible = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 3
    OnChange = cbColorChange
  end
  object cbColorGradient2: TEsColorComboBox
    Left = 148
    Top = 142
    Width = 229
    Height = 22
    Enabled = False
    EsLabelInfo.OffsetX = 0
    EsLabelInfo.OffsetY = 0
    EsLabelInfo.Visible = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 4
    OnChange = cbColorChange
  end
  object edtImage: TButtonedEdit
    Left = 148
    Top = 232
    Width = 185
    Height = 25
    Enabled = False
    RightButton.Visible = True
    TabOrder = 7
    Text = 'edtImage'
  end
  object btnImageOpen: TButton
    AlignWithMargins = True
    Left = 342
    Top = 232
    Width = 35
    Height = 25
    Caption = '...'
    TabOrder = 8
    OnClick = btnImageOpenClick
  end
  object cbDirection: TComboBox
    Left = 148
    Top = 170
    Width = 229
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 5
    Text = 'Horizontal'
    OnChange = cbDirectionChange
    Items.Strings = (
      'Horizontal'
      'Vertical')
  end
  object dlgImageOpen: TOpenPictureDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 272
    Top = 448
  end
end
