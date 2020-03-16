unit Unit4;

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
  Vcl.StdCtrls,
  IniFiles,
  Synautil,
  httpsend,
  msxml,
  xmldom,
  XMLIntf,
  msxmldom,
  XMLDoc;

type
  TForm4 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Save: TButton;
    Send: TButton;
    Ping: TButton;
    Memo1: TMemo;
    procedure SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure PingClick(Sender: TObject);
    procedure SendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  ini: TIniFile;

implementation

{$R *.dfm}


procedure TForm4.Edit1Change(Sender: TObject);
begin
  Edit3.Text := Edit1.Text + ':' + Edit2.Text;
end;

procedure TForm4.Edit2Change(Sender: TObject);
begin
  Edit3.Text := Edit1.Text + ':' + Edit2.Text;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0))+'Config.ini');
  try
    Edit1.Text := ini.ReadString('DATA', 'EDIT1', '127.0.0.1');
    Edit2.Text := ini.ReadString('DATA', 'EDIT2', '7000');
    Edit3.Text := Edit1.Text + ':' + Edit2.Text;
  finally
    //ini.Free;
  end;
end;

procedure TForm4.PingClick(Sender: TObject);
var
  http:Thttpsend;
  url:string;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0))+'Config.ini');
  http:=Thttpsend.Create;
  url:='http://' +  ini.ReadString('HTTP', 'IP', '127.0.0.1') + ':' + ini.ReadString('HTTP', 'PORT', '7000');
  if http.HTTPMethod('GET', url) then
    begin
      ShowMessage('Все ок!');
    end
  else
    begin
      ShowMessage('Нет ответа от сервера.');
    end;
  http.Free;
end;

procedure TForm4.SaveClick(Sender: TObject);
begin
  //ini := TIniFile.Create(extractfilepath(paramstr(0))+'Config.ini');
  try
    ini.WriteString('HTTP', 'IP', '127.0.0.1');
    ini.WriteString('HTTP', 'PORT', '7000');
    ini.WriteString('DATA', 'EDIT1', Edit1.Text);
    ini.WriteString('DATA', 'EDIT2', Edit2.Text);
    ini.WriteString('DATA', 'EDIT3', Edit3.Text);
  finally
    //ini.Free;
  end;

end;

procedure TForm4.SendClick(Sender: TObject);
var
  filexml, res: TXMLDocument;
  S, Sres: TStringStream;
  Http: THTTPSend;
  i: Integer;
  url: string;
begin
  filexml:= TXMLDocument.Create(Form4);
  S := TStringStream.Create;
  with filexml do
  begin
    Active := True;
    Version := '1.0';
    Encoding := 'UTF-8';
    with AddChild('Items') do
    begin
      with AddChild('Item') do
      begin
        Attributes['name'] := 'one';
        Attributes['value'] := Edit1.Text;
      end;
      with AddChild('Item') do
      begin
        Attributes['name'] := 'two';
        Attributes['value'] := Edit2.Text;
      end;
      with AddChild('Item') do
      begin
        Attributes['name'] := 'three';
        Attributes['value'] := Edit3.Text;
      end;
    end;
    SaveToStream(S);
  end;
  try
    Http := THTTPSend.Create;
    Http.Document.LoadFromStream(S);
    url := 'http://' +  ini.ReadString('HTTP', 'IP', '127.0.0.1') + ':' + ini.ReadString('HTTP', 'PORT', '7000');
    filexml.Active := False;
    if Http.HTTPMethod('POST', url) then
    begin
      Memo1.Lines.Clear;
      res := TXMLDocument.Create(Form4);
      Sres := TStringStream.Create;
      Http.Document.SaveToStream(Sres);
      res.LoadFromStream(Sres);
      res.Active := True;
      for i := 0 to res.DocumentElement.ChildNodes.Count-1 do
      begin
        //data.DocumentElement.ChildNodes[i].Attributes['value'] := AnsiReverseString(Memo1.Lines[i]);
        Memo1.Lines.Add(res.DocumentElement.ChildNodes[i].Attributes['value']);
      end;
    end
    else
    begin
      Memo1.Lines.Clear;
      Memo1.Lines.Add('Сервер не отвечает');
    end;
  finally
    filexml.Free;
    http.Free;
    S.Destroy;
  end;
end;
end.
