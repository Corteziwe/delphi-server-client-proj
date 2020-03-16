object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 281
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 8
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 8
    Top = 62
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit3'
  end
  object TMemo
    Left = 8
    Top = 89
    Width = 185
    Height = 89
    ReadOnly = True
    TabOrder = 3
  end
  object Save: TButton
    Left = 8
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
  end
  object Send: TButton
    Left = 118
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 5
  end
  object Ping: TButton
    Left = 232
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Ping'
    TabOrder = 6
  end
end
