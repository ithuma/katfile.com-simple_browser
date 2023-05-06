unit unit100;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Menus, opensslsockets, strutils, fphttpclient, jsonparser, ShellApi,
  fpjson, TypInfo, fun1, Clipbrd ;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonExport: TButton;
    ButtonSearch: TButton;
    CheckBoxOpenClick: TCheckBox;
    EditTemp: TEdit;
    EditSearch: TEdit;
    lb1: TListBox;
    MainMenu1: TMainMenu;
    MemoTemp3: TMemo;
    MemoTemp2: TMemo;
    MemoTemp: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Panel1: TPanel;
    pb1: TProgressBar;
    PopupList1: TPopupMenu;
    StatusBar1: TStatusBar;
    Timer1select: TTimer;
    procedure ButtonExportClick(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    procedure CheckBoxOpenClickChange(Sender: TObject);
    procedure EditSearchKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure lb1Click(Sender: TObject);
    procedure lb1DblClick(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure Timer1selectTimer(Sender: TObject);
    procedure Timer2extractTimer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  admin : boolean;
  searchword, s, newkey : string;

  AHTTPClient1: TFPHTTPClient;
  APostValues1: TStringList;
  AUrl1, AResult1: string;
  i, k: integer;
  J: TJSONData;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.lb1Click(Sender: TObject);
begin

if lb1.ItemIndex < 0 then showmessage('no file was choosen or file list is empty') else
if CheckBoxOpenClick.Checked = true then
  ShellExecute( 0, 'open', PChar( lb1.Items.Strings[ lb1.ItemIndex ] ), '', '', 0 ) else
         begin
         statusbar1.SimpleText:='link from list, double click to open or check option: open to click to open direct';
         //EditSearch.Text:= ExtractUrlFileName ( lb1.Items.Strings[ lb1.ItemIndex ] );
         end;
end;

procedure TForm1.lb1DblClick(Sender: TObject);
begin

if lb1.ItemIndex < 0 then showmessage('no file was choosen or file list is empty') else
  ShellExecute( 0, 'open', PChar( lb1.Items.Strings[ lb1.ItemIndex ] ), '', '', 0 ) ;

end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
if newkey = '' then
showmessage( ' enter new api key ' ) else
showmessage( ' basic account information ' );

if newkey <> '' then
   BEGIN
    memotemp.Clear;
    AUrl1 := 'https://katfile.com/api/account/info?key=' + newkey;
    AHTTPClient1 := TFPHTTPClient.Create(nil);
    try
           AHTTPClient1.AllowRedirect := True;
             APostValues1 := TStringList.Create;
              try
               AResult1 := AHTTPClient1.SimpleGet(AUrl1);
               memoTemp.Lines.AddStrings(AResult1);
               except
               //on E: exception do ShowMessage(E.Message);
               end;
               finally
               APostValues1.Free;
               AHTTPClient1.Free;
               end;
    if admin = true then memoTemp.lines.SaveToFile('01 all.txt');
    J:=GetJSON(memoTemp.Text);

   showmessage( 'Account storage: '+ b2kb2mb2gb(J.FindPath('result.storage_used').AsString, 2 ) + #13+
                'premium information, expire date: ' + J.FindPath('result.premium_expire').AsString) ;

   END;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin

showmessage( 'katfile file list 1.1 beta' +#13
             +'author:  internet user   ' );

end;

procedure TForm1.MenuItem5Click(Sender: TObject);
var
 pass1 : string;
begin
pass1 := '0123456789zxcvbnmasdfghjklqwertyuiop!@#$%^&*()[]{}'; // 50 znaków
//showmessage( 'future option, wait till update' );
randomize;

newkey := InputBox ( 'Enter new api key for katfile account', 'api key for katfile account', 'new key here');
if newkey <> 'new key here' then
          begin
          memotemp.Clear;
          for i:=0 to ( 10 * ( length(newkey)+5 )) do memoTemp.Lines.Add('');
          for i:=0 to ( 10* (length(newkey)+4 )) do
              begin
              for k:=0 to 44 do
              memotemp.Lines.Strings[i] := memotemp.Lines.Strings[i] + pass1[ random (50) ];
              end;
          memoTemp.Lines.Strings[0] :=  intToStr ( length ( newkey ) ) + 'l' + memoTemp.Lines.Strings[i];
          for i := 1 to ( length (newkey) + 1) do
          memoTemp.Lines.Strings[8*i] := newkey[i] + memoTemp.Lines.Strings[i];
          showmessage( ' key updated, thX ' );
          memoTemp.Lines.SaveToFile('account.dll');
          end;
if newkey <> '' then if buttonSearch.Visible = false then buttonSearch.Visible := true;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin

application.Terminate;

end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
lb1.SelectAll;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
lb1.ClearSelection;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
ButtonExport.Click;
end;

procedure TForm1.Timer1selectTimer(Sender: TObject);
begin

timer1select.Enabled := false;
statusbar1.SimpleText:=' please wait, searching files, wait for result ' ;
for i := 0 to ( memoTemp2.Lines.Count-2 ) do
  begin
  memoTemp3.Lines.Add( '' );
  for k := ( 5+ (strtoint(memotemp2.Lines.Strings[i]))) to (strtoint(memotemp2.Lines.Strings[i+1])) do
     begin
     memoTemp3.Lines.Strings[i] := memoTemp3.Lines.Strings[i] + s[k];
     pb1.Position := pb1.Position + 1;
     end;
  end;
pb1.Position := 0;

for i:=(memoTemp3.Lines.Count-1) downto 0 do
  if memoTemp3.Lines.Strings[i] <> '' then
     if PosEx ('https://katfile.com/', memoTemp3.Lines.Strings[i]) = 0 then memoTemp3.Lines.Delete(i);

lb1.Clear;
for i:=0 to ( memoTemp3.Lines.Count-1 ) do
  if memoTemp3.Lines.Strings[i]<>'' then
    begin
    EditTemp.Text := memoTemp3.Lines.Strings[i];
    k :=posEx( '.html', memoTemp3.Lines.Strings[i] ) + 4;
    pb1.Position := pb1.Position + 1;
    EditTemp.SelStart:=0;
    EditTemp.SelLength:=k;
    lb1.Items.Add( EditTemp.SelText ) ;
    end;
pb1.Position := 0;
statusbar1.SimpleText:='search files was done, there was: ' + intTostr ( lb1.Items.Count ) + ' files found' ;
end;

procedure TForm1.Timer2extractTimer(Sender: TObject);
begin

i :=posEx( '.html',EditSearch.Text ) + 4;
EditSearch.SelStart:=0;
EditSearch.SelLength:=i;
EditSearch.Text := EditSearch.SelText;

end;

procedure TForm1.ButtonSearchClick(Sender: TObject);
begin
lb1.Clear;
pb1.Position := 0;

searchword := EditSearch.Text;
searchword := StringReplace(searchword, ' ', '%', [rfReplaceAll, rfIgnoreCase]);
memoTemp.Clear;

AUrl1 := 'https://katfile.com/api/file/list?key='+newkey+'&name=' + searchword + '&per_page=555';
   AHTTPClient1 := TFPHTTPClient.Create(nil);
    try
           AHTTPClient1.AllowRedirect := True;
             APostValues1 := TStringList.Create;
              try
               AResult1 := AHTTPClient1.SimpleGet(AUrl1);
               memoTemp.Lines.AddStrings(AResult1);
               except
               //on E: exception do ShowMessage(E.Message);
               end;
               finally
               APostValues1.Free;
               AHTTPClient1.Free;
               end;
  if admin = true then memoTemp.lines.SaveToFile('01 all.txt');
  J:=GetJSON(memoTemp.Text);

s := '';
for i:=0 to (memoTemp.Lines.Count-1) do s := s+ memoTemp.Lines.Strings[i];

memoTemp2.Clear;
memoTemp2.Lines.Add( '0' );
memoTemp3.Clear;
for i:=0 to length ( s ) do
  if posEx( 'nk":', s[i]+s[i+1]+s[i+2]+s[i+3] ) > 0 then memoTemp2.Lines.Add( intToStr ( i) );
 memoTemp2.Lines.Add( intTostr ( length (s) -1) );

timer1select.Enabled := true;

end;

procedure TForm1.ButtonExportClick(Sender: TObject);
var
  ls : TStringList;
begin

ls := TStringList.Create;
if lb1.SelCount > 0 then
  begin
  for i:=0 to lb1.Items.Count-1 do
  if lb1.Selected[i] then ls.add(lb1.Items[i]);
  end else
   for i:=0 to lb1.Items.Count-1 do ls.add(lb1.Items[i]);
//showmessage( ls.Text );
Clipboard.AsText := ls.Text;
ls.Free;
end;

procedure TForm1.CheckBoxOpenClickChange(Sender: TObject);
begin

showmessage(' when checked then all links from list will open after single click ');

end;


procedure TForm1.EditSearchKeyPress(Sender: TObject; var Key: char);
begin

if key = #13 then ButtonSearch.Click;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  c : string;
begin
admin := false;

if fileexists('favicon.ico') then admin := true;

if admin = true then
  begin
  memoTemp.Visible := true ;
  memoTemp2.Visible := true ;
  memoTemp3.Visible := true ;
  memoTemp.Clear;
  memotemp.Lines.LoadFromFile( 'search-result.txt' );
  end;

memoTemp.Clear;
if fileexists('account.dll') then
  BEGIN
  memoTemp.Lines.LoadFromFile('account.dll');
  newkey := memoTemp.Lines.Strings[0];
  k := strToint ( newkey[1] + newkey[2] );
  //showmessage( intToStr( k ) );
  newkey := '';
  for i := 1 to k do
   begin
   c :=memoTemp.Lines.Strings[8*i];
   newkey := newkey + c[1];
   memoTemp3.Lines.Strings[0] := newkey;
   end;
  END else newkey := '';
//showmessage( newkey );
if newkey = '' then
   begin
   showmessage( ' enter new api key to make program works or close application'  );
   buttonSearch.Visible := false;
   end;
end;

end.

