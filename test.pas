//Nama / Nim    : Aulia Ichsan Rifkyano / 13515100
//Nama file     : MainTucil.pas
//Deskripsi     : Main driver untuk program vending machine

Program Tucil;
uses uGeneral,sysUtils,crt;

var deret:string;
    jumlah:longint;
    NoState:integer;
    tukar:boolean;

begin
    clrscr;
    CopyFile;
    Write('>');
    readln(deret);
    while not(CekMasukan(deret)=True) do
    Begin
        writeln('>Masukan salah, ulangi!');
        writeln('>');
        readln(deret);
    End;
    TranslateInput(deret);
    HitungUang(deret,jumlah,tukar);
    BisaBeli(jumlah,NoState,tukar);
    if (NoState=4) or (NoState=5) or (NoState=7) then
        PesanMinum(NoState);
end.

