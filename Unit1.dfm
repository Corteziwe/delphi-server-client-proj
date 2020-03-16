object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Awesome app'
  ClientHeight = 419
  ClientWidth = 658
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object server: TIdHTTPServer
    Active = True
    Bindings = <>
    DefaultPort = 7000
    OnCommandGet = serverCommandGet
    Left = 16
    Top = 16
  end
end
