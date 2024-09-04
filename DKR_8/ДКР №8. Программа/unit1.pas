unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, Process; // Подключаем модуль Process для запуска внешних приложений

type

  { TTTTTimer }

  TTTTTimer = class(TForm)
    Image1: TImage;
    Pause: TButton; // Кнопка паузы
    Exitt: TBitBtn; // Кнопка выхода
    Clear: TButton; // Кнопка сброса
    Start: TButton; // Кнопка старта
    Hour: TEdit; // Поле ввода часов
    Minutes: TEdit; // Поле ввода минут
    Seconds: TEdit; // Поле ввода секунд
    Clock: TLabel; // Метка для отображения времени
    HourL: TLabel; // Метка для часов
    MinutsL: TLabel; // Метка для минут
    SecondsL: TLabel; // Метка для секунд
    Timer1: TTimer; // Таймер
    procedure ExittClick(Sender: TObject); // Обработчик для кнопки выхода
    procedure ClearClick(Sender: TObject); // Обработчик для кнопки сброса
    procedure HourChange(Sender: TObject); // Обработчик изменения часов
    procedure MinutesChange(Sender: TObject); // Обработчик изменения минут
    procedure PauseClick(Sender: TObject); // Обработчик для кнопки паузы
    procedure SecondsChange(Sender: TObject); // Обработчик изменения секунд
    procedure StartClick(Sender: TObject); // Обработчик для кнопки старта
    procedure StopClick(Sender: TObject); // Обработчик для кнопки остановки
    procedure Timer1Timer(Sender: TObject); // Обработчик таймера
  private
    TimeCounter: Integer; // Переменная для отсчета времени
    PausedTimeCounter: Integer; // Время на паузе
    Paused: Boolean; // Флаг паузы
  public
  end;

var
  TTTTimer: TTTTTimer; // Объявление формы

implementation

{$R *.lfm}

{ TTTTTimer }

// Запуск таймера
procedure TTTTTimer.StartClick(Sender: TObject);
var
  Hours, Mins, Secs: Integer;
begin
  // Проверка, что введены целые числа
  if TryStrToInt(Hour.Text, Hours) and
     TryStrToInt(Minutes.Text, Mins) and
     TryStrToInt(Seconds.Text, Secs) then
  begin
    TimeCounter := Hours * 3600 + Mins * 60 + Secs; // Перевод времени в секунды
    PausedTimeCounter := TimeCounter; // Сохранение времени для паузы
    Timer1.Enabled := True; // Включение таймера
  end
  else
    ShowMessage('Пожалуйста, введите корректные значения времени'); // Сообщение об ошибке ввода
end;

// Сброс таймера
procedure TTTTTimer.ClearClick(Sender: TObject);
begin
  Timer1.Enabled := False; // Остановка таймера
  TimeCounter := 0; // Сброс времени
  PausedTimeCounter := 0;
  Clock.Caption := '00:00:00'; // Сброс отображаемого времени
  Hour.Text := '0'; // Сброс полей ввода
  Minutes.Text := '0';
  Seconds.Text := '0';
end;

// Проверка ввода часов
procedure TTTTTimer.HourChange(Sender: TObject);
var Hours: Integer;
begin
  if not TryStrToInt(Hour.Text, Hours) then
    Hour.Text := '0' // Установка значения по умолчанию
  else if Hours > 61 then
    Hour.Text := '61'; // Ограничение значения
end;

// Проверка ввода минут
procedure TTTTTimer.MinutesChange(Sender: TObject);
var Mins: Integer;
begin
  if not TryStrToInt(Minutes.Text, Mins) then
    Minutes.Text := '0'
  else if Mins > 61 then
    Minutes.Text := '61';
end;

// Проверка ввода секунд
procedure TTTTTimer.SecondsChange(Sender: TObject);
var Secs: Integer;
begin
  if not TryStrToInt(Seconds.Text, Secs) then
    Seconds.Text := '0'
  else if Secs > 61 then
    Seconds.Text := '61';
end;

// Пауза и возобновление таймера
procedure TTTTTimer.PauseClick(Sender: TObject);
begin
  Paused := not Paused; // Переключение состояния паузы
  if Paused then
  begin
    Timer1.Enabled := False; // Остановка таймера
    PausedTimeCounter := TimeCounter; // Сохранение времени
  end
  else
  begin
    Timer1.Enabled := True; // Возобновление таймера
    TimeCounter := PausedTimeCounter; // Восстановление времени
  end;
end;

// Закрытие программы
procedure TTTTTimer.ExittClick(Sender: TObject);
begin
  Close; // Закрытие формы
end;

// Остановка таймера
procedure TTTTTimer.StopClick(Sender: TObject);
begin
  Timer1.Enabled := False; // Остановка таймера
  PausedTimeCounter := TimeCounter; // Сохранение текущего времени
end;

// Обработчик события таймера
procedure TTTTTimer.Timer1Timer(Sender: TObject);
var
  Hours, Mins, Secs: Integer;
  AProcess: TProcess;
begin
  if not Paused then
  begin
    if TimeCounter > 0 then
    begin
      TimeCounter := TimeCounter - Timer1.Interval div 1000; // Уменьшение времени
      Hours := TimeCounter div 3600;
      Mins := (TimeCounter mod 3600) div 60;
      Secs := TimeCounter mod 60;
      Clock.Caption := Format('%2.2d:%2.2d:%2.2d', [Hours, Mins, Secs]); // Обновление метки времени
    end
    else
    begin
      Timer1.Enabled := False; // Остановка таймера, когда время вышло
      Clock.Caption := '00:00:00';
      AProcess := TProcess.Create(nil); // Запуск процесса воспроизведения звука
      try
        AProcess.Executable := '/usr/bin/afplay';
        AProcess.Parameters.Add('/Users/mvideomvideo/Desktop/Python/song.mp3');
        AProcess.Execute;
      finally
        AProcess.Free;
      end;
    end;
  end
  else
  begin
    Hours := PausedTimeCounter div 3600;
    Mins := (PausedTimeCounter mod 3600) div 60;
    Secs := PausedTimeCounter mod 60;
    Clock.Caption := Format('%2.2d:%2.2d:%2.2d', [Hours, Mins, Secs]); // Обновление метки времени на паузе
  end;
end;

end.

