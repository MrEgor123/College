﻿Program z_18;
Var a : integer;
begin
  writeln('Напишите количество дней в году'); // показывается текст на экран
  readln(a); // считывается переменная а, а именно кол-во дней в году
  if a = 365 then //если а равняется 365: то данный год не является високосным
    writeln('Данный год не является високосным')
  else if a = 366 then // иначе если а равняется 366, то данный год високосный
    writeln('Данный год високосный')
  else // если предыдущие два условия не совпали, то вы ввели некорректное количество дней в году
    writeln('Вы ввели некорректное количество дней в году'); // вывод текста на экран
end.
















