object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Awesome Server'
  ClientHeight = 313
  ClientWidth = 525
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
  object Memo1: TMemo
    Left = 264
    Top = 80
    Width = 185
    Height = 145
    Lines.Strings = (
      '')
    TabOrder = 0
  end
  object Server: TIdHTTPServer
    Active = True
    Bindings = <>
    DefaultPort = 7000
    OnCommandGet = ServerCommandGet
    Left = 8
    Top = 8
  end
end
