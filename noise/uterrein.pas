unit uterrein;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, math,graphutil,unit3, system.Math.vectors;

type
tTerrein = class
bmp:tbitmap;
noise:tperlinnoise;
seed, freq, octaves:integer;
zoom,persistance,xo,yo:double;
liquid:integer;
liquidlevel:double;
snowy:boolean;
monoc:tcolor;


l1,l2,l3,l4,l5:tcolor;
f1,f2,f3,f4,f5:double;


function GenBmp(w,h:integer):tbitmap;
procedure mono(cl:tcolor);
constructor Create();


end;


implementation

{ tTerrein }

constructor tTerrein.Create;
begin
noise := tperlinnoise.Create(1);
bmp := tbitmap.Create;
seed := 0;
zoom := 0.01;
persistance := 0.4;
freq := 1;
octaves := 4;

liquid := 0;
liquidlevel := 0.3;
snowy := false;
monoc:=clblack;

l1 := rgb(0,0,255);
l2 := rgb(255,255,0);
l3 := rgb(0,255,0);
l4 := rgb(80,50,50);
l5 := rgb(255,255,255);

//f1 := 0.3;
f2 := 0.3;
f3 := 0.5;
f4 := 0.7;
f5 := 0.9;


xo:=0;
yo:=0;

end;

function tTerrein.GenBmp(w,h:integer): tbitmap;
var
b:tbitmap;
x,y:integer;
mac, mic,diff,c:double;
col:tcolor;

begin
//1.61
//-0.7


bmp := tbitmap.Create;
noise.InitNoise(seed);

bmp.Width :=  w;
bmp.Height := h;
mac :=0;
mic:=0;

for x := 0 to bmp.Width-1 do
for y  := 0 to bmp.Height-1 do
begin

//perlin noise vars
c := noise.perlinnoise2d(
(x+xo)*zoom,
(y+yo)*zoom,
persistance,
freq,octaves);

if liquid <> 0 then
begin
f2 := liquidlevel;
case liquid of
1: l1 := clblue;
2: l1 := clred;
3: l1 := cllime;
end;
end;




//getting the c value
 c:= c/2+ 0.5;
if c > 1 then c := 1;
if c < 0 then c := 0;



col := l1;

if snowy = true then begin
l4 := clgray;
l5 := clwhite;
end;

if c > f2 then col :=l2;
if c > f3 then col := l3;
if c > f4 then col := l4;
if c > f5 then col := l5;

mono(monoc);



bmp.Canvas.Pixels[x,y] := col;
end;


result := bmp;

end;



procedure tTerrein.mono(cl: tcolor);
var
H, S, L: Word;
begin
ColorRGBToHLS(cl, H, L, S);
l1 := ColorHLSToRGB(H, 80, S);
l2 := ColorHLSToRGB(H, 90, S);
l3 := ColorHLSToRGB(H, 100, S);
l4 := ColorHLSToRGB(H, 110, S);
l5 := ColorHLSToRGB(H, 130, S);
end;

end.
