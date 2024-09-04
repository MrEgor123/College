program DKR_7;
uses GraphABC, System;

var
  scale: Real = 1.0; // параметризация
  depth: Integer = 6;
  offsetX: Real = 0.0;
  offsetY: Real = 0.0;

procedure Redraw; // для перерисовки окна
begin
  ClearWindow;
  Draw(Round(100*scale+offsetX), Round(400*scale+offsetY), Round(700*scale+offsetX), Round(400*scale+offsetY), depth);
end;

procedure Button(Key: Integer); // нажатие кнопок
begin
  case Key of
    VK_Down: begin 
      offsetY := offsetY - 30;
      Redraw;
    end;
    VK_Up: begin 
      offsetY := offsetY + 30;
      Redraw;
    end;
    VK_Right: begin 
      offsetX := offsetX - 30;
      Redraw;
    end;
    VK_Left: begin 
      offsetX := offsetX + 30;
      Redraw;
    end;
    VK_O: begin 
      scale := scale * 1.5;
      Redraw;
    end;
    VK_P: begin 
      scale := scale / 1.5;
      Redraw;
    end;
    VK_W: begin 
      depth := depth + 1;
      Redraw;
    end;
    VK_S: if depth > 0 then begin 
      depth := depth - 1;
      Redraw;
    end;
  end;
end;

begin
  SetWindowSize(600, 600);
  SetWindowCaption('Кривая Хартера-Хейтуэя');
  OnKeyDown := Button;
  Redraw;
end.
