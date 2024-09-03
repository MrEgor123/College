program Z_3;

const
  MAX_SIZE = 10; // Максимальный размер стека и списка

type
  Stack = record
    data: array [1..MAX_SIZE] of integer; // Массив для хранения данных стека
    top: integer; // Индекс вершины стека
  end;

// Процедура инициализации стека
procedure initializeStack(var S: Stack);
begin
  S.top := 0; // Устанавливаем индекс вершины стека в 0
end;

// Функция проверки пустоты стека
function isEmpty(S: Stack): boolean;
begin
  isEmpty := (S.top = 0); // Возвращает true, если индекс вершины стека равен 0
end;

// Процедура добавления элемента в стек
procedure push(var S: Stack; item: integer);
begin
  if S.top < MAX_SIZE then // Проверяем, не превышен ли максимальный размер стека
  begin
    S.top := S.top + 1; // Увеличиваем индекс вершины стека
    S.data[S.top] := item; // Добавляем новый элемент в стек
  end
  else
    writeln('Стек переполнен'); // Выводим сообщение о переполнении стека
end;

// Функция извлечения элемента из стека
function pop(var S: Stack): integer;
begin
  if not isEmpty(S) then // Проверяем, не является ли стек пустым
  begin
    pop := S.data[S.top]; // Возвращаем значение верхнего элемента стека
    S.top := S.top - 1; // Уменьшаем индекс вершины стека
  end
  else
  begin
    writeln('Стек пуст'); // Выводим сообщение о пустом стеке
    pop := -1; // Возвращаем значение 
  end;
end;

// Процедура вывода содержимого стека
procedure printStack(S: Stack);
var
  i: integer;
begin
  writeln('Четные числа:');
  for i := 1 to S.top do
    write(S.data[i], ' '); // Выводим содержимое стека
  writeln;
end;

var
  i: integer;
  myStack: Stack;

begin
  Randomize; // Инициализация генератора случайных чисел

  // Заполнение списка случайными числами и добавление четных чисел в стек
  initializeStack(myStack);
  writeln('Список случайных чисел:');
  for i := 1 to MAX_SIZE do
  begin
    // Генерация случайного числа от 1 до 100
    myStack.data[i] := Random(100) + 1;
    write(myStack.data[i], ' ');

    // Если число четное, добавляем его в стек
    if myStack.data[i] mod 2 = 0 then
      push(myStack, myStack.data[i]);
  end;
  writeln;

  // Вывод четных чисел из стека
  printStack(myStack);

  readln;
end.
