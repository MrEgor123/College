unit System;

interface // создание интрефейса

uses GraphABC;

procedure Draw(x1, y1, x2, y2, depth: integer);

implementation // реализация модуля

procedure Draw(x1, y1, x2, y2, depth: integer); 
begin
  if depth = 0 then // выделение базы рекурсии
    Line(x1, y1, x2, y2)
  else
  begin
    // координаты середины отрезка
    var midX := (x1 + x2) div 2 + (y2 - y1) div 2;
    var midY := (y1 + y2) div 2 - (x2 - x1) div 2;
    
    // Декомпозиция
    Draw(x1, y1, midX, midY, depth - 1); // от (x1, y1) до середины (midX, midY),
    Draw(x2, y2, midX, midY, depth - 1); // от (x2, y2) до середины (midX, midY)
  end;
end;

end.
