object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 340
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 32
    Width = 257
    Height = 21
    TabOrder = 0
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 8
    Top = 67
    Width = 257
    Height = 21
    TabOrder = 1
    OnChange = Edit2Change
  end
  object Edit3: TEdit
    Left = 8
    Top = 111
    Width = 257
    Height = 21
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 8
    Top = 152
    Width = 257
    Height = 89
    ReadOnly = True
    TabOrder = 3
  end
  object Save: TButton
    Left = 8
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = SaveClick
  end
  object Send: TButton
    Left = 97
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 5
    OnClick = SendClick
  end
  object Ping: TButton
    Left = 190
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Ping'
    TabOrder = 6
    OnClick = PingClick
  end
end
