unit Edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfEdit }

  TfEdit = class(TForm)
    bCancel: TBitBtn;
    bSave: TBitBtn;
    CBNote: TComboBox;
    eCountry: TEdit;
    eeColor: TLabel;
    eeCost: TLabel;
    eeSpeed: TLabel;
    eSpeed: TEdit;
    eName: TEdit;
    eColor: TEdit;
    eCost: TEdit;
    eeName: TLabel;
    eeCountry: TLabel;
    eeNote: TLabel;
    procedure eCostChange(Sender: TObject);
    procedure eSpeedChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

procedure TfEdit.FormShow(Sender: TObject);
begin
  eName.SetFocus;
end;

procedure TfEdit.eCostChange(Sender: TObject);
var
  i: Integer;
  NewText: String;
  DotCount: Integer;
begin
  // Инициализируем новую строку для хранения исправленного текста
  NewText := '';
  DotCount := 0;

  // Проверяем каждый символ введенной строки
  for i := 1 to Length(eCost.Text) do
  begin
    // Если символ является цифрой или точкой и количество точек меньше одной,
    // добавляем его в новую строку
    if (eCost.Text[i] in ['0'..'9']) or ((eCost.Text[i] = '.') and (DotCount < 1)) then
    begin
      if eCost.Text[i] = '.' then
        Inc(DotCount);
      NewText := NewText + eCost.Text[i];
    end;
  end;

  // Заменяем текст в поле ввода на исправленный
  eCost.Text := NewText;

  // Перемещаем курсор в конец текста
  eCost.SelStart := Length(eCost.Text);
end;

procedure TfEdit.eSpeedChange(Sender: TObject);
var
  i: Integer;
  NewText: String;
begin
  // Инициализируем новую строку для хранения исправленного текста
  NewText := '';

  // Проверяем каждый символ введенной строки
  for i := 1 to Length(eSpeed.Text) do
  begin
    // Если символ является цифрой, добавляем его в новую строку
    if eSpeed.Text[i] in ['0'..'9'] then
    begin
      NewText := NewText + eSpeed.Text[i];
    end;
  end;

  // Заменяем текст в поле ввода на исправленный
  eSpeed.Text := NewText;

  // Перемещаем курсор в конец текста
  eSpeed.SelStart := Length(eSpeed.Text);
end;


end.

