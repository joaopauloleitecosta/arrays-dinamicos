unit frmPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    edtAluno: TEdit;
    edtPrimeiraNota: TEdit;
    edtSegundaNota: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mmoRegistro: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure LimpaCampos;

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type rgAluno = record
  nome: String[35];
  nota1: Double;
  nota2: Double;
end;

var aluno: array of rgAluno;
  n: integer = 0;   //Tamanho do vetor
  x: rgAluno;

{ TForm1 }

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  { Garante que todos os campos serão informados }
  if ((edtAluno.Text <> '') and (edtPrimeiraNota.Text <> '') and (edtSegundaNota.Text <> '')) then
  begin
    x.nome  := edtAluno.Text;
    x.nota1 := StrtoFloat(edtPrimeiraNota.Text);
    x.nota2 := StrtoFloat(edtSegundaNota.Text);
    inc(n); // Redimensiona o vetor aluno aumentando uma posição
            // Para adicionar um novo aluno no final do conjunto
    SetLength(aluno, n);
    aluno[n-1] := x;
    mmoRegistro.Lines.Add(x.nome + ', gravado com sucesso.');
    LimpaCampos;
  end
  else
  begin
    ShowMessage('Campo(s) não informado');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var nreg,i: integer;
  media: real;
begin
  mmoRegistro.Lines.Add('');
  nreg := 0;
  for i:= 0 to n-1 do
  begin
    x := aluno[i];
    nreg := nreg + 1;

    { Processando e exibindo os dados recuperados }
    media := (x.nota1 + x.nota2)/2;
    mmoRegistro.Lines.Add('Registro Nro.: ' + IntToStr(nreg));
    mmoRegistro.Lines.Add('Nome do Aluno: ' + x.nome);
    mmoRegistro.Lines.Add('1a. Nota.....: ' + Format('%.2f', [x.nota1]));
    mmoRegistro.Lines.Add('2a. Nota.....: ' + Format('%.2f', [x.nota2]));
    mmoRegistro.Lines.Add('Média........: ' + Format('%.2f', [media]));

    if (media >= 6.0) then
      mmoRegistro.Lines.Add('Situação.....: Aprovado')
    else
      mmoRegistro.Lines.Add('Situação.....: Reprovado');

    mmoRegistro.Lines.Add('=============================');
  end;
end;

procedure TForm1.LimpaCampos;
begin
  edtAluno.Clear;
  edtAluno.SetFocus;
  edtPrimeiraNota.Clear;
  edtSegundaNota.Clear;
end;

end.

