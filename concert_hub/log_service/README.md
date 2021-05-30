# Log Service

Log Service представляет собой журнал входа/выхода посетителей, который возвращает список событий входа/выхода, позволяет искать и фильтровать записи по всем полям.

После сборки и запуска контейнеров сервис доступен по адресу http://localhost:8180/.  
Доступ из одного сервиса в другой из контейнера по адресу http://log:8180/.

## Описание Api

<table>
    <thead>
        <tr>
            <th>Метод</th>
            <th>Параметры</th>
            <th>Примеры запросов</th>
            <th>Примеры ответов</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>GET <code>/entries</code> -<hr>
            получение всех событий входа/выхода с возможностью фильтрации
            <hr>
            метод доступен только администратору (см. раздел авторизации ниже)
            </td>
            <td>Необязательные параметры:<br><br>
            <code>page</code> - номер страницы (целое число; по умолчанию - <code>0</code>)<br><br>
            <code>per_page</code>- количество записей на странице (целое число; по умолчанию - <code>20</code>)<br><br>
            <code>fio</code>- имя посетителя, вошедшего по билету (строка)<br><br>
            <code>entry_type</code>- тип события (<code>entry</code> или <code>exit</code>)<br><br>
            <code>status</code>- статус события (<code>true</code> или <code>false</code>)
            </td>
            <td>
                GET <code>/entries</code><br><br>
                GET <code>/entries?page=1&per_page=3</code><br><br>
                GET <code>/entries?fio=User</code><br><br>
                GET <code>/entries?status=true&entry_type=exit</code><br><br>
                GET <code>/entries?<br>fio=User&<br>status=true&<br>entry_type=entry&<br>page=1&<br>per_page=3</code>
            </td>
            <td>Status: <code>200 Ok</code>
<pre>[
  {
    "ticket_id": 1,
    "fio": "User",
    "date_time": "2021-04-12T09:38:48.659Z",
    "entry_type": "entry",
    "status": true
  },
  {
    "ticket_id": 1,
    "fio": "User",
    "date_time": "2021-04-12T10:13:38.362Z",
    "entry_type": "exit",
    "status": true
  },
    "ticket_id": 1,
    "fio": "User",
    "date_time": "2021-04-12T10:13:40.363Z",
    "entry_type": "exit",
    "status": false
  }
]</pre>
        </td>
        </tr>
        <tr>
            <td>GET <code>/check?ticket_id={ticket_id}</code> -<hr>
            получение последнего типа события (вход или выход) по номеру билета
            </td>
            <td>Обязательный параметр:<br><br>
            <code>ticket_id</code> - номер билета, по которому нужно получить последнее событие (целое число)</td>
            <td>GET <code>/check?ticket_id=1</code></td>
            <td>Status: <code>200 Ok</code>
<pre>{
  "entry_type": "entry"
}</pre>
<pre>{
  "entry_type": "exit"
}</pre>
            </td>
        </tr>
        <tr>
            <td>POST <code>/entries</code><hr>
            создание события входа/выхода
            </td>
            <td></td>
            <td>
            POST <code>/entries</code>
<pre>{
  "ticket_id": 1,
  "fio": "User",
  "entry_type": "entry",
  "status": true
}</pre>
            </td>
             <td>Status: <code>201 Created</code>
<pre>{
  "ticket_id": 1,
  "fio": "User",
  "date_time": "2021-04-14T09:52:12.250Z",
  "entry_type": "entry",
  "status": true
}</pre>
            </td>
        </tr>
    </tbody>
</table>

## Авторизация

Получать список всех событий входа/выхода с возможностью фильтрации может только администратор.  
Вход в панель администратора: логин - `admin`, пароль - `admin` 

<table>
    <thead>
        <tr>
            <th>Метод</th>
            <th>Описание</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>GET <code>/login</code></td>
            <td>Просмотр логина текущего пользователя</td>
        </tr>
        <tr>
            <td>POST <code>/login</code>
<pre>{
  login={login}
  password={password}
}</pre>
            </td>
            <td>Вход в панель администратора</td>
        </tr>
        <tr>
            <td>DELETE <code>/login</code></td>
            <td>Выход из панели администратора</td>
        </tr>
    </tbody>
</table>

## Ответы при возникновении ошибок     

<table>
    <thead>
        <tr>
            <th>Метод</th>
            <th>Причина ошибки</th>
            <th>Статус ответа</th>
            <th>Тело ответа</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>GET <code>/entries</code></td>
            <td>В текущей сессии нет логина администратора</td>
            <td><code>401 Unauthorized</code></td>
            <td>
<pre>{
  "error": "You don't have enough rights to perform this operation"
}</pre>
        </td>
        <tr>
            <td>GET <code>/check?ticket_id={ticket_id}</code></td>
            <td>Указан номер билета, по которому не найдено ни одно событие входа/выхода</td>
            <td><code>404 Not Found</code></td>
            <td>
<pre>{
  "error": "Entries for ticket 56 not found"
}</pre>
        </td>
        </tr>
        <tr>
            <td>POST <code>/entries</code></td>
            <td>Ошибка валидации данных события (номер события, тип события, значение статуса)</td>
            <td><code>406 Not Acceptable</code></td>
            <td>
<pre>{
  "error": "Entry is invalid",
  "details": {
    "ticket_id": [
      "can't be blank",
      "is not a number"
    ]
  }
}</pre>
            </td>
        </tr>    
        <tr>
            <td>/POST <code>/login</code></td>
            <td>Неверный логин или пароль администратора</td>
            <td><code>302 Found</code>
            (перенаправление на эту же страницу для повторного ввода данных)</td>
            <td>The username or password is incorrect</td>
        </tr>
    </tbody>
</table>

## Структура таблицы `entries`
Имя        |Описание                         | Тип
-----------|---------------------------------|--------
ticket_id  |номер билета                     | integer
fio        |ФИО посетителя                   | string
entry_type |тип события (0 - entry, 1 - exit)| integer
status     |статус события                   | boolean
created_at |дата и время события             | datetime