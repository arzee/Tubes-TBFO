unit uGeneral;

interface
const NMax = 100;



type tombol=record
        TombolSatu  :string;
        TombolDua   :string;
        TombolTiga  :string;
        TombolEmpat :string;
        Uang        :longint;
        NoState     :integer;
    end;
    

type dbState = record
    status : tombol;
    Neff   : integer;
end;

var
    State : array[1..20] of dbState;



procedure LoadFile;
{*Procedure untuk load file ke internal*}

procedure CopyFile;
{* procedure untuk me-load data dari File external DaftarState.txt 
   dan dimasukkan kedalam variable internal
I.S : variable DaftarState internal kosong, DaftarState.txt sudah ada
F.S : DaftarState.txt sudah masuk ke File Internal, DaftarState *}


procedure TranslateInput(deret:string);
{*procedure yang menampilkan input dalam bentuk uang
I.S. Semua input benar
F.S. Keluaran uang tergantung input*}

function CekMasukan(input:string):boolean;
{*procedure yang menghasilkan true/false ketika ada input masuk
I.S. Input uang masuk
F.S. State berubah/tetap tergantung input*}

procedure HitungUang(input:string;var jumlah:longint;var tukar:boolean);
{* Bisa juga disebut sebagai prosedur yang menghitung uang berdasarkan input
I.S. Input uang masuk
F.S. diberikan jumlah uang sebesar jumlah, dan boolean apabila 1 input bisa ditukar*}

procedure BisaBeli(jumlah:longint;Var NoState:integer;var tukar:boolean);
{* Menghasilkan state tergantung jumlah uang yang ada
I.S. Jumlah terdefinisi
F.S. Keluar state akhir.*}

procedure IsOnOff(OnOff:integer);
{*Procedure yang 'menggambarkan' tombol apa saja yang on atau off*}

procedure PesanMinum(NoState:integer);
{*procedure yang mengeluarkan minuman berdasarkan state*}


implementation

uses sysutils;


procedure LoadFile;
Begin
    CopyFile;
End;



procedure CopyFile;

Var
    dstate      :text;
    f           :ansistring;
    posc,l,i,j  :integer;

    
Begin
    j:=1;
    assign(dstate,'DaftarState.txt');
    reset(dstate);
    while not(EOF(dstate)) do
    begin
        readln(dstate,f);
        begin
            for i:=1 to 6 do
            begin
                posc:=pos('|',f);
                l:=length(copy(f,1,posc+1));
                case i of
                    1:State[j].status.TombolSatu                   :=copy(f,1,posc-2);
                    2:State[j].status.TombolDua                    :=copy(f,1,posc-2);
                    3:State[j].status.TombolTiga                   :=copy(f,1,posc-2);
                    4:State[j].status.TombolEmpat                  :=copy(f,1,posc-2);
                    5:val(copy(f,1,posc-2),State[j].status.Uang);
                    6:val(copy(f,1,posc-2),State[j].status.NoState);
                end;
                delete(f,1,l);
            end;
        end;
    j:=j+1;
    end;
    //State[j].Neff:=j-1;
    close(dstate);

    
End;

procedure TranslateInput(deret:string);

Var
    DeretT  : string ;
    i       : integer;
    
Begin
    for i=1 to length(deret) do
    Begin
        DeretT:=copy(deret,i,1);
        if DeretT=a
End;


function CekMasukan(input:string):boolean;

Var
    i,x     : integer;
    cc      : ansistring;
    found   : boolean;
    
Begin
    found:=false;
    x:=length(input);
    i:=1;
    while (i<=x) and not(found) do
    begin
        cc:=copy(input,i,1);
        if not(cc='a') and not(cc='b') and not(cc='c') and not(cc='d')  then
            found:=true;
        i:=i+1;
    end;
    if (found=true) then
        CekMasukan:=False
    else
        CekMasukan:=True;

End;

procedure HitungUang(input:string;var jumlah:longint;var tukar:boolean);

Var
    Uang    : string;
    i       : integer;
    kurang  : boolean;
    x       : longint;
    uangm   : string;
    
Begin
    uangm:=copy(input,1,length(input));
    tukar:=false;
    i:=1;
    kurang := true;
    while (i<=length(uangm)) do
    Begin
        Uang:=copy(uangm,i,1);
        if (uang='a') then
            jumlah:=jumlah+1000
        else if (uang='b') then
            jumlah:=jumlah+2000
        else if (uang='c') then
            jumlah:=jumlah+5000
        else if (uang='d') then
            jumlah:=jumlah+10000;
        if (jumlah>10000) then
            kurang:=false;
        i:=i+1;
    End;
    if (kurang=false) then
    Begin
        Writeln('>Saldo masukan uang lebih dari 10000, yaitu: ',jumlah);
        Writeln('>Uang yang paling terakhir dimasukkan dikembalikan');
        Write('>Uang yang dikembalikan adalah ');
        if (uang='a') then
        Begin
            x:=1000;
            writeln(x);
        End
        else if (uang='b') then
        Begin
            x:=2000;
            writeln(x);
        End
        else if (uang='c') then
         Begin
            x:=5000;
            writeln(x);
        End
        else if (uang='d') then
        Begin
            x:=10000;
            writeln(x);
        End;
        writeln;
        jumlah:=0;
        
        HitungUang(copy(uangm,1,i-2),jumlah,tukar);
        
    End
    else {Kurang = True}
    Begin    
        Write('>Saldo di dalam mesin adalah ');
        Writeln(jumlah);
        if not(copy(uangm,1,1)='a') then
            if length(uangm)=1 then
                tukar:=true
            else
                tukar:=false
        else
            tukar:=false;
    End;
    
End;

procedure BisaBeli(jumlah:longint;var NoState:integer;var tukar:boolean);
Var
    
    i       : integer;
    found   : boolean;
    
Begin
    if (tukar=false) then
    Begin
        i:=1;
        found:=false;
        while (i<=10) and (found=false) do
        Begin
            if jumlah=State[i].status.Uang then
                found:=true
            else
                i:=i+1;
        End;
    End
    else {if tukar=true}
    Begin
        i:=12;
        while (i<=13) and (found=false) do
        Begin
            if jumlah=State[i].status.Uang then
                found:=true
            else
                i:=i+1;
        End;
    End;
    IsOnOff(i);
        
End;

procedure IsOnOff(OnOff:integer);

var
    a,b,c,d:String;
    
Begin
    if State[OnOff].status.TombolSatu='ON' then
        a:='O N'
    else
        a:='OFF';
    if State[OnOff].status.TombolDua='ON' then
        b:='O N'
    else
        b:='OFF';
    if State[OnOff].status.TombolTiga='ON' then
        c:='O N'
    else
        c:='OFF';
    if State[OnOff].status.TombolEmpat='ON' then
        d:='O N'
    else
        d:='OFF';
    writeln;
    writeln;
    writeln('>3000     >4000     >6000     Tukar');
    writeln('[',a,']     [',b,']     [',c,']     [',d,']');
    
End;

procedure PesanMinum(NoState:integer);
Begin
    
End;
    
End.