unit Unit1;

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
  IdContext;

type
  TForm1 = class(TForm)
    server: TIdHTTPServer;
    procedure serverCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.serverCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo);
var
  data:TStringStream;
begin
  if (ARequestInfo.Command = 'GET') and Assigned(ARequestInfo.PostStream) then
  begin
    data:=TStringStream.Create;
    try
      try
        data.LoadFromStream(ARequestInfo.PostStream);
        ShowMessage(data.DataString);
      except
        on E:Exception do
        begin
          AResponseInfo.ResponseNo:=501;
          AResponseInfo.ResponseText:='You gay';
          AResponseInfo.ContentText:=E.Message;
        end;
      end;
    finally
      data.Free;
    end;
  end;
  ShowMessage(ARequestInfo.Document);
end;

end.
