program Z_5;

const
  MAX_SIZE = 1000;

type
  NodePtr = ^Node;  // указатель на узел списка
  Node = record      // структура узла
    Data: Integer;  
    Next: NodePtr;  // след. узел списка
  end;

  Stack = record
    top: NodePtr;
  end;

var
  inputFile, outputFile: TextFile;
  myStack: Stack; 
  num: integer;

function isEmpty(s: Stack): boolean;
begin
  isEmpty := (s.top = nil); // проверка на наличие элементов
end;

procedure push(var s: Stack; element: integer); 
var
  newNode: NodePtr;
begin
  New(newNode); // создаем новый узел
  newNode^.Data := element; // заполняем данными
  newNode^.Next := s.top; // указываем на следующий узел
  s.top := newNode; // делаем его вершиной стека
end;

function pop(var s: Stack): integer; // удаление элемента из стека
var
  tempNode: NodePtr;
begin
  if not isEmpty(s) then // до тех пор пока стек не пустой
  begin
    tempNode := s.top; // сохраняем текущий верхний узел
    pop := tempNode^.Data; // получаем данные верхнего узла
    s.top := tempNode^.Next; // делаем следующий узел новым верхним
    Dispose(tempNode); // освобождаем память, занятую предыдущим верхним узлом
  end;
end;

procedure ReverseListInFile(inputFileName, outputFileName: string); // перепис.
var
  num: integer;
begin
  AssignFile(inputFile, inputFileName); // чтение из файлов
  Reset(inputFile);
  AssignFile(outputFile, outputFileName);
  Rewrite(outputFile);

  myStack.top := nil; // Инициализация стека

  // Чтение чисел из файла и добавление их в стек
  while not EOF(inputFile) do
  begin
    if not SeekEOF(inputFile) then // Проверяем, не достигнут ли конец файла
    begin
      Read(inputFile, num);
      push(myStack, num);
    end;
  end;

  // Запись чисел из стека в обратном порядке в выходной файл
  while not isEmpty(myStack) do
  begin
    num := pop(myStack);
    Write(outputFile, num, ' '); // добавляем пробел между числами
  end;

  CloseFile(inputFile);
  CloseFile(outputFile);
end;

begin
  ReverseListInFile('input.txt', 'output.txt');
end.
