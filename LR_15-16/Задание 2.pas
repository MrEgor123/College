program Z_2; // связный список

type
  PNode = ^Node; 
  Node = record   
    _Word: string; 
    Counter: integer; 
    Next: PNode; 
  end;

var
  Head, NewNode, q: PNode; 
  Counter: integer; 
  w: string; // слово из файла
  f: text;  // работа с текст. файлом

function GetWord(f: text): string; // получение слова из файла
var
  c: char;
begin
  Result := '';
  c := ' ';
  while not (EOF(f)) and (c <= ' ') do // пока не достигнут конец файла
    Read(f, c);
  while not (EOF(f)) and (c >  ' ') do
  begin
    Result := Result + c; // добавление символа к слову
    Read(f, c);
  end;
end;

function Find(Head: PNode; NewWord: string): PNode; // поиск слова в списке
var
  q: PNode; // проход по списку
begin
  q := Head; // начало списка
  while (q <> nil) and (q^._Word <> NewWord) do // не достигнут конец списка
    q := q^.Next; // Переход к следующему узлу списка
  Result := q; // Возвращение найденного узла или nil
end;

function CreateNode(NewWord: string): PNode; // создание нового узла списка
var
  NewNode: PNode; 
begin
  New(NewNode); // Выделение памяти 
  NewNode^._Word := NewWord; 
  NewNode^.Counter := 1; 
  NewNode^.Next := nil; 
  Result := NewNode; 
end;

function FindPlace(Head: PNode; NewWord: string): PNode; // поиск места вставки нового узла
var
  q: PNode; 
begin
  q := Head; 
  while (q <> nil) and (NewWord > q^._Word) do // сравн. нового слова с текущим в списке
    q := q^.Next; 
  Result := q; 
end;

procedure AddFirst(var Head: PNode; NewNode: PNode); // добавление нового узла в начало списка
begin
  NewNode^.Next := Head; 
  Head := NewNode; 
end;

procedure AddAfter(p, NewNode: PNode); // добавление нового узла после указанного узла
begin
  NewNode^.Next := p^.Next; 
  p^.Next := NewNode; 
end;

procedure AddBefore(var Head: PNode; p, NewNode: PNode); // добавление нового узла перед указанным узлом
var
  q: PNode;
begin
  q := Head; // начало списка 
  if (p = Head) then // Если указанный узел равен началу 
    AddFirst(Head, NewNode) // Добавление нового узла в начало списка
  else begin
    while (q <> nil) and (q^.Next <> p) do 
      q := q^.Next; 
    if (q <> nil) then 
      AddAfter(q, NewNode); 
  end;
end;

begin
  Head := nil; 
  Assign(f, 'Z.txt'); 
  Reset(f); 
  
  while not eof(f) do 
  begin
    w := GetWord(f); // Получение слова из файла
    if (w = '') then 
      break; 
    q := Find(Head, w); // Поиск слова в списке
    if (q <> nil) then // Если слово найдено
      Inc(q^.Counter) // Увеличение счетчика слова
    else begin 
      NewNode := CreateNode(w); // Создание нового узла с данным словом
      q := FindPlace(Head, w); // Поиск места для вставки нового узла
      AddBefore(Head, q, NewNode); 
    end;
  end;
  
  Close(f); 
  Assign(f, 'V.txt'); 
  Rewrite(f); 
  q := Head; 
  Counter := 0; 
  
  while (q <> nil) do 
  begin
    Inc(Counter); // Увеличение счетчика уникальных слов
    Writeln(f, q^._Word, ': ', q^.Counter); // Запись слова и его счетчика в файл
    q := q^.Next; // Переход к следующему узлу списка
  end;
  
  Writeln(f, Counter, ' уникальных слова ');
  Writeln(Counter, ' уникальных слова '); 
  Close(f); 
end.
