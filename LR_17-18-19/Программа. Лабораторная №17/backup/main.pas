unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TFmain }

  TFmain = class(TForm)
    Fmain: TLabel;
    lClock: TLabel;
    Timer2: TTimer;
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure lClockClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Fmain: TFmain;

implementation

{$R *.lfm}

{ TFmain }

procedure TFmain.lClockClick(Sender: TObject);
begin

end;

procedure TFmain.FormKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #27 then Close;
end;

procedure TFmain.Timer1Timer(Sender: TObject);
var i:byte;
begin
  lClock.Caption:= TimeToStr(Now);
  i:= Random(4);
  case i of
    0: lClock.Left:= lClock.Left + 50;
    1: lClock.Left:= lClock.Left - 50;
    2: lClock.Top:= lClock.Top + 50;
    3: lClock.Top:= lClock.Top - 50;
  end;
  if lClock.Left < 0 then lClock.Left:= 0;
  if lClock.Top < 0 then lClock.Top:= 0;
  if (lClock.Left + lClock.Width) < lClock.Width then
    lClock.Left:= lClock.Height - lClock.Height;
  if (lClock.Top + lClock.Width) < lClock.Width then
    lClock.Top:= lClock.Height - lClock.Height;
end;

end.

