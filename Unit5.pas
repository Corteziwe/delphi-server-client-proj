unit Unit5;

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
  IdBaseComponent,
  IdComponent,
  IdCustomTCPServer,
  IdCustomHTTPServer,
  IdHTTPServer,
  IdContext,
  Synautil,
  httpsend,
  msxml,
  xmldom,
  XMLIntf,
  msxmldom,
  XMLDoc,
  ActiveX,
  StrUtils,
  Vcl.StdCtrls,
  IniFiles;

type
  TForm5 = class(TForm)
    Server: TIdHTTPServer;
    Memo1: TMemo;
    procedure ServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure FormCreate(Sender: TObject);
    //procedure LogIt();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  ini: TIniFile;

implementation

{$R *.dfm}

procedure TForm5.FormCreate(Sender: TObject);
begin
  Memo1.Visible := False;
  Server.Active := False;
  if not FileExists(extractfilepath(paramstr(0))+'Server.ini') then
  begin
    ini := TIniFile.Create(extractfilepath(paramstr(0))+'Server.ini');
    ini.WriteString('SERVER', 'PORT', '7000');
    Server.DefaultPort := StrToInt(ini.ReadString('SERVER', 'PORT', '7000'));
    Server.Active := True;
  end
  else
  begin
    ini := TIniFile.Create(extractfilepath(paramstr(0))+'Server.ini');
    Server.DefaultPort := StrToInt(ini.ReadString('SERVER', 'PORT', '7000'));
    Server.Active := True;
  end;
end;
{
procedure TForm5.LogIt;
var
  log: TextFile;
  i: integer;
begin
  AssignFile(log, extractfilepath(paramstr(0))+'log.txt');
  Rewrite(log, extractfilepath(paramstr(0))+'log.txt');
  Writeln(log, 'Date: ' + DateToStr(Now) + ' Time: ' + TimeToStr(Now));
  for i := 0 to Memo1.Lines.Count -1 do
  begin
    Writeln(log, Memo1.Lines[i]);
  end;
  CloseFile(log);
end;
}
procedure TForm5.ServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo);
var
  data: TXMLDocument;
  res: TXMLDocument;
  s: TStringStream;
  i: Integer;
  log: TIniFile;
begin

  CoInitialize(nil);
  log := TIniFile.Create(extractfilepath(paramstr(0))+'log.txt');
  if (ARequestInfo.Command = 'POST') and Assigned(ARequestInfo.PostStream) then
  begin
    data := TXMLDocument.Create(Form5);
    Memo1.Lines.Clear;
    try
      try
        data.LoadFromStream(ARequestInfo.PostStream);
        data.Active := True;
        for i := 0 to data.DocumentElement.ChildNodes.Count-1 do
        begin
          Memo1.Lines.Add(data.DocumentElement.ChildNodes[i].Attributes['value']);
        end;
        res := TXMLDocument.Create(Form5);
        s := TStringStream.Create;
        with res do
        begin
          Active := True;
          Version := '1.0';
          Encoding := 'UTF-8';
          with AddChild('Items') do
          begin
            with AddChild('Item') do
            begin
              Attributes['name'] := 'one';
              Attributes['value'] := AnsiReverseString(Memo1.Lines[0]);
            end;
            with AddChild('Item') do
            begin
              Attributes['name'] := 'two';
              Attributes['value'] := AnsiReverseString(Memo1.Lines[1]);
            end;
            with AddChild('Item') do
            begin
              Attributes['name'] := 'three';
              Attributes['value'] := AnsiReverseString(Memo1.Lines[2]);
            end;
        end;
        SaveToStream(s);
      end;
      AResponseInfo.ContentStream := s;
      for i := 0 to Memo1.Lines.Count -1 do
      begin
        log.WriteString(DateToStr(Now), TimeToStr(Now), Memo1.Lines[i]);
      end;
      except
        on E:Exception do
        begin
          AResponseInfo.ResponseText:='Ошибочка!';
          AResponseInfo.ContentText:=E.Message;
        end;
      end;
    finally
      data.Free;
      res.Free;
    end;
  end;

  if (ARequestInfo.Command = 'GET') then
  begin
    Memo1.Clear;
    Memo1.Lines.Add('К серверу пытались подключиться.');
    for i := 0 to Memo1.Lines.Count -1 do
    begin
      log.WriteString(DateToStr(Now), TimeToStr(Now), Memo1.Lines[i]);
    end;
  end;
end;
end.
