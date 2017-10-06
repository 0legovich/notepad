# Блокнот

#### Идея приложения
Приложение предназначено для создания собственных записей,
аналогичных записям в блокноте. Предусмотрены 3 типа записей:
* Task (задача) - если у Вас есть задача и вам надо ее выполнить в определенный срок, то это то, что Вам необходимо.
* Memo (Заметка) - желаете поджелиться мыслями за прошедший день? 
* Link (Ссылка) - Оставьте ссылку на важную встречу и Вы всегда быстро найдете ее в своем блокноте.

#### Параметры запуска
Для запуска необходим [интерпретатор ruby](https://ru.wikipedia.org/wiki/Ruby). Рекомендуемая версия `ruby >= 2.4.0`

Перед начало использования программы необходимо создать базу данных. Приложение использует [базу данных SQLite](https://ru.wikipedia.org/wiki/SQLite). Для настройки БД выполните следующие действия:
* установите gem [sqlite3](https://rubygems.org/gems/sqlite3/versions/1.3.11)
* запустите команду `ruby <путь к исполняемому файлу>/create_db.rb`. Успешным завершением команды является появление файла `notepad.sqlite3` в директории приложения.

Для создания новой записи необходимо запустить команду `ruby <путь к исполняемому файлу>/new_post.rb`.

Для просмотра всех записей необходимо запустить команду `ruby <путь к исполняемому файлу>/read.rb`.

**Важно!** Все команды запускать в [командой строке](https://ru.wikipedia.org/wiki/Cmd.exe) (на Windows) или [в терминале](https://ru.wikipedia.org/wiki/Командная_оболочка_UNIX) (на ОС семейства Unix).

###### Опции запуска
Для просмотра всех записей в блокноне предусмотрены следующие опции:
* --type - отобразит все записи с отпределенным типом. Например: `--type Memo`
* --id - отобразит одну запись с указанным id. Например: `--id 1`
* --limit - отобразит последние *n* записей. Например: `--limit 10`

P.S. Приложение является учебным. Приследуемая цель: применение наследования классов, работа с БД.