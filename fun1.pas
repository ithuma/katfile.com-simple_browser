unit fun1;

interface

uses
  SysUtils, Classes, StrUtils;


function katnrid(txt: string): string;
function ilecalosc(txt: string): string;
function ExtractUrlFileName(const AUrl: string): string;
function b2kb2mb2gb(inputdata: string; ilosc : integer): string;
{function kreski2(txt: string): integer;
function rgid(txt: string): string;
function token(txt: string): string;  // "url":"
function iloscplikow(txt: string): string;
function wielkoscplikow(txt: string): string;
function katalogwyzej(txt: string): string;
function kataloglink(txt: string): string;
function katalogilosc(txt: string): string;
function sesjajest (txt: string): boolean;
function url(txt: string): string;
function katalog(txt: string): string;
function pliknazwa(txt: string): string;
function plikrozmiar(txt: string): string;

function tylkonumerkatalogu(txt: string): string;
function nazwazlinku(txt,tkn: string): string;
function chromepoprawka(txt: string): string;

function folderwykaz(txt: string): string;
function foldernazwa(txt: string): string;
function foldernowanazwa(txt: string): string;  // folder_id: + 2 znaki

function ilezostaloGB (txt: string): string;
function czypremium (txt: string): string;

function status404(txt: string): boolean;
function sukces(txt: string): boolean;
function czypremium(txt: string): boolean;
function nazwapliku(txt: string): string;
function wielkoscpliku(txt: string): string;
function wielkoscpliku2(txt: string): string;
function kodpliku(txt: string): string;
function dlugoscnazwypliku(txt: string; j : integer): string;
function nrtoken(txt: string): string;
function nrid(txt: string): integer;
function numerek(txt: string): string;
function tytul(txt: string): string;

function slash(txt: string): integer;
function bezh(txt: string): string;

function metanrid(txt: string): string;
function uptofilename(txt: string): string;
function uploadynrid(txt: string): string;
function uptoboxid1(txt: string): string;
function rapidcloudnrid(txt: string): string;
function uptoboxnrid(txt: string): string;
function wplikfileinfo(txt: string): string;
function katfileinfo(txt: string): string;
function wrzucajnrid(txt: string): string;
function dlsize(txt: string): string;
function gen1(liczba: integer): string;
function gen2(liczba: integer): string;
function dllink(txt: string): string;


function FormatSize(Size: Int64): String;
function FormatSpeed(Speed: LongInt): String;
function SecToHourAndMin(const ASec: LongInt): String;}

var
  i : integer;
implementation

function katnrid(txt: string): string;
var
  i, k:integer;
begin
k:=0;
i :=posEx( '.html',txt ) + 5;
result:='';

for k :=0 to i do result:=result+txt[i];

end;

function ExtractUrlFileName(const AUrl: string): string;
var
  I: Integer;
begin
  I := LastDelimiter('\:/', AUrl);
  Result := Copy(AUrl, I + 1, MaxInt-5 );
end;



function ilecalosc(txt: string): string;
var
  i:integer;
begin            // results_total":

result := '';
i := posEx( 'results_total', txt ) + 15 ;
repeat
  result:=result+txt[i];
  i:=i+1;
  until txt[i]=',';

end;


function b2kb2mb2gb(inputdata: string; ilosc : integer): string;

// _______________________________________________________________________
//   PL info
//
//   Automatyczny konwerter jednostki: bajtów na kilo, mega i giga bajty.
//   W funkcji podaje się zmienną (inpudata: string) liczbę w bajtach
//   oraz (ilosc: integer) ilość miejsc po przecinku,
//   którą chce się uzyskać 0, 1, 2
//   inne wartości zostaną zmienione na 0 - wynik pozyskuje się jako zmienną
//   STRING
//
// _______________________________________________________________________
//   ENG info
//   Automathic converter bytes to kilo, mega and giga bytes.
//   Input data is bytes (string) with information how many digits after dot
//   should be presented as a result (0,1 or 2, other will be change to 0)
//   result is STRING
// _______________________________________________________________________
//   Example code
//   add this function to your *.pas file after { TForm1 }
//
//   add edit1 (input, bytes) and edit2 (result) to your form1
//
//   for edit1.OnChange add this code:
//   edit2.text:=b2kb2mb2gb(edit1.text,2);
//
//   that's all :) your converter is ready
//
//   input data is: 44684628285, result you get: 41,62 GB
// _______________________________________________________________________
//   Author: internet

var
  wsad,patatajpatataj:string;
begin

//check if input value is integer ;)
try
//wsad:=inttostr(inputdata);
wsad:=(inputdata);

// check number digits after dot, must be 0 or 1 or 2 else I set to 0
if ((ilosc<0)and(ilosc>2)) then ilosc:=0;
// transform to kB
if ((length(wsad)>3)and(length(wsad)<7)) then
  begin
  // change to MB size with proper formatting
  patatajpatataj:=floattostrf(strtofloat(wsad)/1024,ffFixed ,ilosc+2,ilosc);
  result:=patatajpatataj+' kB';
  end;

// to MB
if ((length(wsad)>6)and(length(wsad)<10)) then
  begin
  patatajpatataj:=floattostrf(strtofloat(wsad)/1048576,ffFixed ,ilosc+2,ilosc);
  result:=patatajpatataj+' MB';
  end;

// to GB
if ((length(wsad)>9)and(length(wsad)<13)) then
  begin
  patatajpatataj:=FloatToStrF((strtofloat(wsad)/1073741824),ffFixed ,ilosc+2,ilosc);
  result:=patatajpatataj+' GB';
  end;

// too small filesize

if (length(wsad)<4) then result:='~0MB';

if ((length(wsad)>12)and(length(wsad)<16)) then
  begin
  patatajpatataj:=FloatToStrF((strtofloat(wsad)/1099511627776),ffGeneral  ,ilosc+2,ilosc);
  result:=patatajpatataj+' TB';
  end

except // if input is not integer then this :)
//showmessage('Please use integer values to get good result');
result:='0';
end;

end;

{
function rgid(txt: string): string;
var
  i:integer;
begin

i:=PosEx('/rapidgator.net/file/',txt)+21;

repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='/';

end;

function chromepoprawka(txt: string): string;
var
  i:integer;
begin
result :='';                     // 'name':'copy2'
i:=PosEx('name',txt)+7;
//i :=0;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]=' ';

end;


function nazwazlinku(txt,tkn: string): string;
var
  i:integer;
begin
result := '';
i:=PosEx(tkn,txt)+1+length(tkn);
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;

function token(txt: string): string;
var
  i, k:integer;
begin
result := '';
i:=PosEx('"token":"',txt)+9;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;

function tylkonumerkatalogu(txt: string): string;
var
  i:integer;
begin
result := '';
i:=PosEx('(',txt)+1;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]=')';

end;

function iloscplikow(txt: string): string;
var
  i, k:integer;
begin
result := '';
i:=PosEx('"nb_files":',txt)+11;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]=',';

end;

function wielkoscplikow(txt: string): string;
var
  i, k:integer;
begin
result := '';
i:=PosEx('"size_files":',txt)+13;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]=',';

end;

function katalogwyzej(txt: string): string;
var
  i, k:integer;
begin
result := '';
i:=PosEx('parent_folder_id":"',txt)+19;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;

function katalogilosc(txt: string): string;
var
  i, k:integer;
begin
result := '';
i:=PosEx('"nb_folders":',txt)+13;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]=',';

end;

function kataloglink(txt: string): string;
var
  i, k:integer;
begin
result := '';
i:=PosEx('"url":"',txt)+7;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;

function sesjajest(txt: string): boolean;
begin
result := false;
if PosEx('Error. Session doesn',txt)=0 then result := false else
result := true
end;

function folderwykaz(txt: string): string;
var
  i, k:integer;
begin
result := '';
i:=PosEx('folders_ids[',txt)+12;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]=']';

end;

function foldernazwa(txt: string): string;
var
  i, k:integer;
begin
result := '';   // 'name':'
i:=PosEx('"name":"',txt)+8;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i+1]='';  }
{end;

function foldernowanazwa(txt: string): string;  // folder_id: + 2 znaki

var
  i, k:integer;
begin
result := '';   // 'name':'
i:=PosEx('"name":"',txt)+8;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i+1]='"';

end;
function url(txt: string): string;
var
  i, k:integer;
begin
result := '';
i:=PosEx('"url":"',txt)+7;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;


function katalog (txt: string): string;
var
  i, k:integer;
begin
result := '';   // "folder_id":"
i:=PosEx('folder_id":"',txt)+12;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;

function plikrozmiar (txt: string): string;
var
  i, k:integer;
begin
result := '';
i:=PosEx('"size":',txt)+7;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;

function pliknazwa (txt: string): string;
var
  i, k:integer;
begin
result := '';
i:=PosEx('"name":"',txt)+8;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;

function czypremium (txt: string): string;
var
  i:integer;
begin
result := '';
i:=PosEx('is_premium":',txt)+12;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]=',';
if result = 'true' then result :='premium' else result:= 'non premium';

end;

function ilezostaloGB (txt: string): string;
var
  i:integer;
begin
result :='';
i:=PosEx('"left":',txt)+7;
repeat
  result:=result+txt[i];
  i:=i+1
//  until txt[i]='';
//if result = 'true' then result :='premium' else result:= 'non premium';

end;


end;
{
function status404(txt: string): boolean;

begin

result := false;
for i:=0 to (length(txt)-5) do
  if txt[i]+txt[i+1]+txt[i+2]+txt[i+3]=':404'  then result := true;

end;

function uptoboxid1(txt: string): string;
var
  i : integer;
begin
i:=PosEx('uptobox.com/',txt)+12;
result :='';
  repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='/';
end;

function uptofilename(txt: string): string;
var
  i, k:integer;
begin

result:='';
for i:=0 to length ( txt ) do if txt[i]='/' then k:=i;
i:=k;
repeat
  result:=result+txt[i+1];
  i:=i+1
  until i= (length (txt)-k );

end;

function nazwapliku(txt: string): string;
var
  i:integer;
begin

result:='';
i:=PosEx('"name":"',txt)+8;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;

function wielkoscpliku(txt: string): string;
var
  i:integer;
begin

result:='';
i:=PosEx('"size":',txt)+7;
repeat
  result:=result+txt[i];
  i:=i+1                                         // tu byl na koncu nawias okragly
  until ( (txt[i]='"') or (txt[i]=',') or (txt[i]='') );

//end;

function wielkoscpliku2(txt: string): string;
var
  i:integer;
begin

result:='';
i:=PosEx('"size":',txt)+7;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;


function kodpliku(txt: string): string;
var
  i:integer;
begin

result:='';
i:=PosEx('"file_code":"',txt)+13;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;

function dlugoscnazwypliku(txt: string; j : integer): string;
var
  i:integer;
begin

result:='';
for i := 1 to j do
   result := result + txt[i];

end;



function FormatSize(Size: Int64): String;
const
  KB = 1024;
  MB = 1024 * KB;
  GB = 1024 * MB;
begin
  if Size < KB then
    Result := FormatFloat('#,##0 Bytes', Size)
  else if Size < MB then
    Result := FormatFloat('#,##0.0 KB', Size / KB)
  else if Size < GB then
    Result := FormatFloat('#,##0.0 MB', Size / MB)
  else
    Result := FormatFloat('#,##0.0 GB', Size / GB);
end;

function FormatSpeed(Speed: LongInt): String;
const
  KB = 1024;
  MB = 1024 * KB;
  GB = 1024 * MB;
begin
  if Speed < KB then
    Result := FormatFloat('#,##0 bits/s', Speed)
  else if Speed < MB then
    Result := FormatFloat('#,##0.0 kB/s', Speed / KB)
  else if Speed < GB then
    Result := FormatFloat('#,##0.0 MB/s', Speed / MB)
  else
    Result := FormatFloat('#,##0.0 GB/s', Speed / GB);
end;

function SecToHourAndMin(const ASec: LongInt): String;
var
  Hour, Min, Sec: LongInt;
begin
   Hour := Trunc(ASec/3600);
   Min  := Trunc((ASec - Hour*3600)/60);
   Sec  := ASec - Hour*3600 - 60*Min;
   Result := IntToStr(Hour) + 'h: ' + IntToStr(Min) + 'm: ' + IntToStr(Sec) + 's';
end;


function wplikfileinfo(txt: string): string;
begin

AUrl1 := 'http://www.wplik.com/api/file/info?key=1&file_code='+txt;
AHTTPClient1 := TFPHTTPClient.Create(nil);
try
  AHTTPClient1.AllowRedirect := True;
    APostValues1 := TStringList.Create;
     try
      AResult1 := AHTTPClient1.SimpleGet(AUrl1);
      memoTemp.AddStrings(AResult1);
      except
      on E: exception do ; //ShowMessage(E.Message);
      end;
      finally
      APostValues1.Free;
      AHTTPClient1.Free;
      end;}

// http://www.wplik.com/api/file/info?key=xzouz&file_code=dgncmb52fvv4
//TFPHTTPClient.AllowRedirect := true;
{memoTemp.AddStrings( TFPHTTPClient.SimpleGet('http://www.wplik.com/api/file/info?key=file_code='+txt) );

     result := memoTemp.Text;
     // J:=GetJSON(memoTemp.Text);
     // result := J.FindPath('result.status').AsString ;

end;



function slash(txt: string): integer;
var i : integer;
begin
result := 0;
for i := 0 to ( length ( txt ) -1 ) do
   if txt[i] = '/' then result := result +1;
end;

function gen2(liczba: integer): string;
var
  znaki : string;
  i : integer;
begin
znaki :='abcdefghijklmnoprqstuvwq0987654321'; // 34 znaki
result := '';
for i:=0 to liczba do result := result + znaki[random(34)];

end;

function gen1(liczba: integer): string;
var
  znaki : string;
  i : integer;
begin
znaki :='abcdefghijklmnoprqstuvwq0987654321'; // 34 znaki
result := '';
for i:=0 to liczba do result := result + znaki[random(34)];

end;

function katfileinfo(txt: string): string;
begin

{AUrl1 := 'https://katfile.com/api/file/info?key='+txt;
 AHTTPClient1 := TFPHTTPClient.Create(nil);
 try
   AHTTPClient1.AllowRedirect := True;
     APostValues1 := TStringList.Create;
      try
       AResult1 := AHTTPClient1.SimpleGet(AUrl1);
       memoTemp.AddStrings(AResult1);
       except
       on E: exception do result := E.Message;
       end;
       finally
       APostValues1.Free;
       AHTTPClient1.Free;
       end;           }
memoTemp.AddStrings( TFPHTTPClient.SimpleGet('https://katfile.com/api/file/info?key='+txt) );

     J:=GetJSON(memoTemp.Text);
//     result := memoTemp.Text ;
     result := J.FindPath('result.status').AsString ;

end;

function czypremium(txt: string): boolean;
begin

result := false;
if PosEx( 'premium_expire', txt)<>0 then result := true;

end;

function sukces(txt: string): boolean;
begin

result := false;
if PosEx( 'success', txt)<>0 then result := true;

end;

function nrtoken(txt: string): string;
var
  i:integer;
begin

result:='';
i:=PosEx('token":"',txt)+8;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;

function tytul(txt: string): string;
var
  i, j, g:integer;
begin       // 22/1\ 5 znaków + id wplik + 3 znaki + * tytuł
i := length ( txt ) ;
j := posEx ('*',txt) +1 ;
result := '';
for g := j to i do result := result + txt[g];

end;

function numerek(txt: string): string;
var
  i, j, g:integer;
begin       // 22/1\ 5 znaków + id wplik + 3 znaki + * tytuł
i := posex ('\',txt) + 7 ;
j := posEx ('*',txt) - 5 ;
result := '';
for g := i to j do result := result + txt[g];

end;

function bezh(txt: string): string;
var
  i:integer;
begin

i := length ( txt );
result := '';
repeat
 result := result + txt[i];
until i = ( length ( txt ) - 4 ) ;

end;


function nrid(txt: string): integer;
var
  i:integer;
  szuk : string;
begin

szuk := '';
repeat
 szuk := szuk + txt[i];
until txt[i] = '/' ;

result := strtoint( szuk );

end;

function uploadynrid(txt: string): string;
var
  i, k:integer;
  szuk : string;
begin

result:='';
k := 0;

for i:=0 to length(txt) do
  if txt[i]='/' then k := k+1;
          // uploady.io
i:=PosEx('rapidcloud.cc',txt)+13;

if k <5 then
Begin
  repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='/';
  end else
        repeat
        result:=result+txt[i];
         i:=i+1
        until i= length ( txt )+1 ;

end;

function rapidcloudnrid(txt: string): string;
var
  i:integer;
begin

result:='';

i:=PosEx('rapidcloud.cc',txt)+14;

repeat
 result := result + txt[i];
until txt[i] = '/' ;

end;

function metanrid(txt: string): string;
var
  i, k:integer;
  szuk : string;
begin

result:='';
k := 0;

for i:=0 to length(txt) do
  if txt[i]='/' then k := k+1;
          // metaraid.io
i:=PosEx('etaraid.io',txt)+10;

if k <5 then
Begin
  repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='/';
  end else
        repeat
        result:=result+txt[i];
         i:=i+1
        until i= length ( txt )+1 ;

end;

function uptoboxnrid(txt: string): string;
var
  i, k:integer;
  szuk : string;
begin

result:='';

i:=PosEx('uptobox.com',txt)+12;

    repeat
    result:=result+txt[i];
    i:=i+1
    until txt [i] = '/' ;

end;

function wpliknrid(txt: string): string;
var
  i, k:integer;
  szuk : string;
begin

i:=PosEx('wrzucajpliki.pl',txt)+16;

// test / czy jest, jesli jest krotki link to bedzie jeden /
if k < 5 then
Begin
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='/';

result:='';
k := 0;

for i:=0 to length(txt) do
  if txt[i]='/' then k := k+1;

i:=PosEx('wplik.com',txt)+10;

if k <5 then
Begin
  repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='/';
  end else
        repeat
        result:=result+txt[i];
         i:=i+1
        until i= length ( txt )+1 ;

end;

function wrzucajnrid(txt: string): string;
var
  i, k:integer;
  szuk : string;
begin
result:='';
k := 0;

for i:=0 to length(txt) do
  if txt[i]='/' then k := k+1;

i:=PosEx('wrzucajpliki.pl',txt)+16;

// test / czy jest, jesli jest krotki link to bedzie jeden /
if k < 5 then
Begin
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='/';
 end else
    repeat
    result:=result+txt[i];
    i:=i+1
    until i= length ( txt ) + 1 ;

end;

function dlsize(txt: string): string;
var
  i:integer;
begin

result:='';
i:=PosEx('                    (',txt)+21;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]=')';

end;

function dllink(txt: string): string;
var
  i:integer;
begin

result:='';
i:=PosEx('href="',txt)+6;
repeat
  result:=result+txt[i];
  i:=i+1
  until txt[i]='"';

end;


procedure Czesc;
begin
//
end;}

end}
end.

