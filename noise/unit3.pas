Unit unit3;

Interface

{$R-}
{$Q-}

Const
  _B = $100;
  BM = $ff;

  N = $1000;

Type
    TPerlinNoise = Class
    Private
        P : Array[0..(_B+_B+2)-1] Of Integer;
        G1: Array[0..(_B+_B+2)-1] Of Double;
    Public
        Constructor Create(Seed: Integer);

        Procedure InitNoise(Seed: Integer);
        Function Noise1d(x: Double): Double;
        Function Noise2d(x,y: Double): Double;
        Function Noise3d(x,y,z: Double): Double;

        Function PerlinNoise1d(x: Double;
                               Persistence: Single = 0.25;
                               Frequency: Single = 1;
                               Octaves: Integer = 4): Double;
        Function PerlinNoise2d(x,y: Double;
                               Persistence: Single = 0.25;
                               Frequency: Single = 1;
                               Octaves: Integer = 4): Double;
        Function PerlinNoise3d(x,y,z: Double;
                               Persistence: Single = 0.25;
                               Frequency: Single = 1;
                               Octaves: Integer = 4): Double;
    End;

Implementation

Uses
    SysUtils;

Function TPerlinNoise.Noise1d(x: Double): Double;
Var
  bx0,bx1: Integer;
  rx0,sx,t,u,v: Double;
Begin
  t := x+N;
  bx0 := Trunc(t) And BM;
  bx1 := (bx0+1) And BM;
  rx0 := t-Trunc(t);

  sx := (rx0*rx0*(3.0-2.0*rx0));

  u := G1[P[bx0]];
  v := G1[P[bx1]];

  Result := u+sx*(v-u);
End;

Function TPerlinNoise.Noise2d(x,y: Double): Double;
Var
  bx0,bx1,by0,by1: Integer;
  i,j: Integer;
  rx0,ry0: Double;
  sx,sy: Double;
  a,b,t,u,v: Double;
Begin
  t := x+N;
  bx0 := Trunc(t) And BM;
  bx1 := (bx0+1) And BM;
  rx0 := t-Trunc(t);

  t := y+N;
  by0 := Trunc(t) And BM;
  by1 := (by0+1) And BM;
  ry0 := t-Trunc(t);

  i := P[bx0];
  j := P[bx1];

  sx := (rx0*rx0*(3.0-2.0*rx0));
  sy := (ry0*ry0*(3.0-2.0*ry0));

  u := G1[P[i+by0]];
  v := G1[P[j+by0]];
  a := u+sx*(v-u);

  u := G1[P[i+by1]];
  v := G1[P[j+by1]];
  b := u+sx*(v-u);

  Result := a+sy*(b-a);
End;

Function TPerlinNoise.Noise3d(x,y,z: Double): Double;
Var
  bx0,bx1,by0,by1,bz0,bz1: Integer;
  i,j,k,l: Integer;
  rx0,ry0,rz0: Double;
  sx,sy,sz: Double;
  a,b,c,d,t,u,v: Double;
Begin
  t := x+N;
  bx0 := Trunc(t) And BM;
  bx1 := (bx0+1) And BM;
  rx0 := t-Trunc(t);

  t := y+N;
  by0 := Trunc(t) And BM;
  by1 := (by0+1) And BM;
  ry0 := t-Trunc(t);

  t := z+N;
  bz0 := Trunc(t) And BM;
  bz1 := (bz0+1) And BM;
  rz0 := t-Trunc(t);

  i := P[bx0];
  j := P[bx1];

  k := P[i+by0];
  l := P[j+by0];
  i := P[i+by1];
  j := P[j+by1];

  sx := (rx0*rx0*(3.0-2.0*rx0));
  sy := (ry0*ry0*(3.0-2.0*ry0));
  sz := (rz0*rz0*(3.0-2.0*rz0));

  u := G1[P[k+bz0]];
  v := G1[P[l+bz0]];
  a := u+sx*(v-u);

  u := G1[P[i+bz0]];
  v := G1[P[j+bz0]];
  b := u+sx*(v-u);

  c := a+sy*(b-a);

  u := G1[P[k+bz1]];
  v := G1[P[l+bz1]];
  a := u+sx*(v-u);

  u := G1[P[i+bz1]];
  v := G1[P[j+bz1]];
  b := u+sx*(v-u);

  d := a+sy*(b-a);

  Result := c+sz*(d-c);
End;

constructor TPerlinNoise.Create(Seed: Integer);
Begin
  inherited Create;

  InitNoise(Seed);
End;

procedure TPerlinNoise.InitNoise(Seed: Integer);
Var
  i,j: Integer;
Begin
  RandSeed := Seed;

  For i := 0 to _B - 1 Do
  Begin
    P[i] := i;
    G1[i] := 2*Random-1;
  End;

  For i := 0 to _B - 1 Do
  Begin
    j := Random(_B);
    P[i] := P[i] xor P[j];
    P[j] := P[j] xor P[i];
    P[i] := P[i] xor P[j];
  End;

  For i := 0 to _B+2 - 1 Do
  Begin
    P[_B+i] := P[i];
    G1[_B+i] := G1[i];
  End
End;

Function TPerlinNoise.PerlinNoise1d(x: Double;
                                    Persistence: Single = 0.25;
                                    Frequency: Single = 1;
                                    Octaves: Integer = 4): Double;
Var
    i: Integer;
    p,s: Double;
Begin
    Result := 0;
    s := Frequency;
    p := 1;
    For i := 0 to Octaves - 1 Do
    Begin
        Result := Result + p * Noise1d(x * s);
        s := s * 2;
        p := p * Persistence;
    End;
End;

Function TPerlinNoise.PerlinNoise2d(x,y: Double;
                                    Persistence: Single = 0.25;
                                    Frequency: Single = 1;
                                    Octaves: Integer = 4): Double;
Var
    i: Integer;
    p,s: Double;
Begin
    Result := 0;
    s := Frequency;
    p := 1;
    For i := 0 to Octaves - 1 Do
    Begin
        Result := Result + p * Noise2d(x * s,y * s);
        s := s * 2;
        p := p * Persistence;
    End;
End;

Function TPerlinNoise.PerlinNoise3d(x,y,z: Double;
                                    Persistence: Single = 0.25;
                                    Frequency: Single = 1;
                                    Octaves: Integer = 4): Double;
Var
    i: Integer;
    p,s: Double;
Begin
    Result := 0;
    s := Frequency;
    p := 1;
    For i := 0 to Octaves - 1 Do
    Begin
        Result := Result + p * Noise3d(x * s,y * s,z * s);
        s := s * 2;
        p := p * Persistence;
    End;
End;

End.
