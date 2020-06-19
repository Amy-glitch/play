unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, math,graphutil,unit3, uterrein;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  t:tterrein;

implementation

{$R *.dfm}



procedure TForm1.Button1Click(Sender: TObject);
begin
randomize;
t.seed := randomrange(0,1000);

image1.Stretch := true;

t.liquid := randomrange(0,4);
t.snowy := false;
t.monoc := rgb(randomrange(0,255), randomrange(0,255), randomrange(0,255));
image1.Picture.Bitmap := t.GenBmp(image1.Width, image1.Height );

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
t.xo := t.xo -10;
image1.Picture.Bitmap := t.GenBmp(image1.Width, image1.Height );

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
t.xo := t.xo +10;
image1.Picture.Bitmap := t.GenBmp(image1.Width, image1.Height );
end;



procedure TForm1.Button5Click(Sender: TObject);
begin
t.yo := t.yo -10;
image1.Picture.Bitmap := t.GenBmp(image1.Width, image1.Height );
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
t.yo := t.yo +10;
image1.Picture.Bitmap := t.GenBmp(image1.Width, image1.Height );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
t := tterrein.Create;
t.liquid := 1;
t.snowy := true;
t.monoc := clgreen;
end;

end.
