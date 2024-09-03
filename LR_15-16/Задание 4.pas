program Z_4;

type
  NodePtr = ^Node;  // указатель на узел списка
  Node = record      // структура узла
    Data: Integer;  
    Next: NodePtr;  // след. узел списка
  end;

// Процедура для добавления нового элемента в начало списка
procedure Push(var top: NodePtr; value: Integer);
var
  newNode: NodePtr;  // временный указатель на новый узел списка
begin
  New(newNode);   // выделение памяти 
  newNode^.Data := value;  // присвоение значению нового узла переданного знач.
  newNode^.Next := top;    // установка указателя на следующий узел
  top := newNode;  // обновление верхушки списка
end;

// Функция для удаления и возврата значения верхнего элемента списка
function Pop(var top: NodePtr): Integer;
var
  temp: NodePtr;  // временный указатель 
begin
  if top <> nil then  // проверка, что список не пустой
  begin
    temp := top;  // указатель на верх. эл. списка
    Pop := top^.Data;  // Возврат значение верх. списка
    top := top^.Next;  // перемещение на нижний элемент
    Dispose(temp);  // освобождение памяти
  end
  else
    Pop := -1;  // если список пуст
end;

// Функция создания рандомного списка и нахожд. мин. и мак. значений
function Find(var head: NodePtr; var minValue, maxValue: Integer): Boolean;
var
  stack: NodePtr;        // стек 
  currentNode: NodePtr;  // текущий узел списка
begin
  stack := nil;        
  minValue := MaxInt;  
  maxValue := -MaxInt; 

  writeln('Случайные значения списка:'); 

  // Создание случайного списка
  Randomize;
  for var i := 1 to 10 do  
  begin
    var value := Random(100);  
    writeln(value);  
    Push(head, value);  
    if value < minValue then 
      minValue := value;       
    if value > maxValue then  
      maxValue := value;       
  end;

  currentNode := head;  // установка указателя на начало списка

  // Заполнение стека значениями списка
  while currentNode <> nil do
  begin
    Push(stack, currentNode^.Data);
    currentNode := currentNode^.Next;
  end;

  // Очистка стека
  while stack <> nil do
    Pop(stack);

  Find := head <> nil; // есть ли элементы в списке
end;

var
  head: NodePtr;
  minValue, maxValue: Integer;
  exists: Boolean;
begin
  head := nil;

  exists := Find(head, minValue, maxValue);
  if exists then
  begin
    writeln('Минимальное значение в списке: ', minValue);
    writeln('Максимальное значение в списке: ', maxValue);
  end
  else
    writeln('Список пуст.');

  while head <> nil do
  begin
    head := head^.Next;
    Dispose(head);
  end;
end.
