program Z_1;

var
  i: Integer;
  i_ptr: ^Integer;

begin
  i := 2;
  i_ptr := @i; // Присваиваем указателю адрес 
  writeln(i_ptr);
end.

