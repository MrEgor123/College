unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    num1: TButton;
    minus: TButton;
    proizv: TButton;
    delenie: TButton;
    num0: TButton;
    zapytaia: TButton;
    plus: TButton;
    result: TButton;
    del: TButton;
    sqrt: TButton;
    sqrtx: TButton;
    num2: TButton;
    c: TButton;
    ce: TButton;
    del_las_number: TButton;
    num3: TButton;
    num4: TButton;
    num5: TButton;
    num6: TButton;
    num7: TButton;
    num8: TButton;
    num9: TButton;
    result_field: TEdit;
    procedure resultClick(Sender: TObject);
    procedure delClick(Sender: TObject);
    procedure sqrtClick(Sender: TObject);
    procedure sqrtxClick(Sender: TObject);
    procedure cClick(Sender: TObject);
    procedure ceClick(Sender: TObject);
    procedure del_las_numberClick(Sender: TObject);
    procedure ClickBut(Sender: TObject);
    procedure ClickZnak(Sender: TObject);
  private
    a, b, c: Real;
    znak: String;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.ClickZnak(Sender: TObject);
begin
  a := StrToFloatDef(result_field.Text, 0);
  if a = 0 then
  begin
    ShowMessage('Сначала введите число, затем оператор.');
    Exit;
  end;

  result_field.Clear;
  znak := (Sender as TButton).Caption;
end;

procedure TForm1.ClickBut(Sender: TObject);
var
  ButtonCaption: String;
begin
  ButtonCaption := (Sender as TButton).Caption;

  if ButtonCaption = '.' then
  begin
    if Pos('.', result_field.Text) = 0 then
      result_field.Text := result_field.Text + '.';
  end
  else
  begin
    result_field.Text := result_field.Text + StringReplace(ButtonCaption, ',', '.', [rfReplaceAll]);
  end;
end;

procedure TForm1.del_las_numberClick(Sender: TObject);
var
  str: String;
begin
  str := result_field.Text;
  if str <> '' then
    Delete(str, Length(str), 1);
  result_field.Text := str;
end;

procedure TForm1.ceClick(Sender: TObject);
begin
  result_field.Clear;
end;

procedure TForm1.resultClick(Sender: TObject);
begin
  b := StrToFloatDef(result_field.Text, 0);
  if b = 0 then
  begin
    ShowMessage('Сначала введите число, затем оператор.');
    Exit;
  end;

  result_field.Clear;

  case znak of
    '+': c := a + b;
    '-': c := a - b;
    '*': c := a * b;
    '/': begin
           if b <> 0 then
             c := a / b
           else
           begin
             ShowMessage('Деление на ноль невозможно.');
             Exit;
           end;
         end;
  end;

  result_field.Text := FloatToStr(c);
end;

procedure TForm1.delClick(Sender: TObject);
begin
  a := StrToFloatDef(result_field.Text, 0);
  a := 1 / a;
  result_field.Text := FloatToStr(a);
end;

procedure TForm1.sqrtClick(Sender: TObject);
begin
  a := StrToFloatDef(result_field.Text, 0);
  a := sqr(a);
  result_field.Text := FloatToStr(a);
end;

procedure TForm1.sqrtxClick(Sender: TObject);
begin
  a := StrToFloatDef(result_field.Text, 0);
  a := sqrt(a);
  result_field.Text := FloatToStr(a);
end;

procedure TForm1.cClick(Sender: TObject);
begin
  result_field.Clear;
  a := 0;
  b := 0;
  c := 0;
end;

end.

