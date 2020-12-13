object frmMainForm: TfrmMainForm
  Left = 0
  Top = 0
  Caption = 'Essentials Recipes'
  ClientHeight = 585
  ClientWidth = 1101
  Color = clAppWorkSpace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object bkGradient: TEsGradient
    Left = 0
    Top = 0
    Width = 1101
    Height = 585
    Align = alClient
    FromColor = clAppWorkSpace
    ToColor = clAppWorkSpace
    ExplicitLeft = 8
    ExplicitTop = 263
    ExplicitWidth = 368
    ExplicitHeight = 217
  end
  object MainMenu1: TMainMenu
    Left = 1056
    Top = 16
    object Examples1: TMenuItem
      Caption = '&Examples'
      object InvoiceSample1: TMenuItem
        Caption = 'Invoice Sample'
        OnClick = btnInvoiceClick
      end
      object Background1: TMenuItem
        Caption = 'Background'
        OnClick = btnBackgroundClick
      end
      object About1: TMenuItem
        Caption = 'About'
        OnClick = btnAboutClick
      end
    end
  end
end
