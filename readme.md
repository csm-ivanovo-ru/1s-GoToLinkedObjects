# Поддержка быстрого перехода к сопоставленным объектам

[![GitHub release](https://img.shields.io/github/v/release/csm-ivanovo-ru/1s-GoToLinkedObjects.svg?sort=semver&logo=github)](https://github.com/csm-ivanovo-ru/1s-GoToLinkedObjects/releases)

[![Semantic Versioning](https://img.shields.io/static/v1?label=Semantic%20Versioning&message=v2.0.0&color=green&logo=semver)](https://semver.org/lang/ru/spec/v2.0.0.html)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-v1.0.0-yellow.svg?logo=git)](https://conventionalcommits.org)

Данный репозиторий содержит расширение конфигураций 1С:Предприятие 8.3
для управляемых форм, предоставляющее общую команду для перехода
к сопоставленным объектам в синхронизируемых информационных базах.

## Назначение расширения

Данное расширение конфигурации предназначено для использования в
1С:Бухгалтерия государственного учреждения редакции 2.0
при использовании интеграции с Единой метрологической платформой
(далее - ЕМП).

### Команда "Перейти в..."

Расширение добавляет общую команду `ППСО_ПерейтиКСопоставленномуОбъекту`
(в интерфейсе - "Перейти в ЕМП") в командную панель формы "Синхронизация данных".

![Команда перехода к сопоставленному объекту](/assets/images/goto-linked-object-command.png)

Команда доступна в формах объектов всех синхронизируемых объектов.

Также данное расширение предназначено для диагностики возможных проблем синхронизации
объектов в информационных базах.

### Команда "Сопоставленные объекты"

Расширение поставляет общую команду `ППСО_СопоставленныеОбъекты`,
выполняющую переход из формы синхронизируемых объектов
в специализированную форму списка регистра `СоответствияОбъектовИнформационныхБаз`
с отбором по текущему объекту
(доступна администраторам системы).

![Команда перехода к форме регистра соответствия объектов](/assets/images/registry-list-form.png)

### Команда "Предупреждения синхронизации"

Также расширение поставляет общую команду `ППСО_ПредупрежденияСинхронизации`,
выполняющую переход из формы синхронизируемых объектов
в форму списка регистра `РезультатыОбменаДанными` с отбором по текущему объекту
(доступна администраторам системы).

## Диагностируемые проблемы синхронизации и методы их решения

### Дублирование объектов при синхронизации

#### Описание проблемы

Одной из основных проблем при синхронизации информационных баз является
дублирование объектов при синхронизации.

Одной из причин возникновения проблемы являются множественные записи
в регистре `СоответствияОбъектовИнформационныхБаз` для одного
объекта текущего узла (информационной базы) и выбранной синхронизируемой
информационной базы (измерение `УзелИнформационнойБазы` в указанном
регистре). В указанном регистре не должно быть более одной записи
для одного объекта текущей базы (измерение `УникальныйИдентификаторИсточника`),
синхронизируемой базы (измерение `УзелИнформационнойБазы`).

В том случае, если описанных выше записей несколько, при синхронизации
изменений из текущей информационной базы в синхронизируемой базе будет
создан дубликат объекта.

#### Возможные причины возникновения проблемы

Одна из возможных причин возникновения подобных проблем - использование обработки
"Поиск и удаление дублей".

К сожалению, указанная обработка некорректно обрабатывает записи в регистре
`СоответствияОбъектовИнформационныхБаз`, при замене ссылок на удаляемый дубликат
объекте не удаляя записи для него в указанном регистре,
а заменяя в нём ссылки на дубликат ссылками на оригинал (основной объект).
В итоге - получаем в регистре множественные записи.

#### Методы решения проблемы

Метод решения - выяснить, какая из записей содержит действительные
сведения о сопоставленном объекте в синхронизируемой информационной базе,
и удалить остальные.
Для этих целей из формы объекта, с синхронизацией которого возникли описанные
выше проблемы, переходим с использованием поставляемой данным расширением команды
в форму списка регистра `СоответствияОбъектовИнформационныхБаз`. Записи
в указанном регистре будут отобраны по текущему объекту, из формы которого
осуществлён переход.
Непосредственно из формы списка регистра проверяем возможность перехода
к сопоставленным объекта в синхронизируемых информационных базах.
Удаляем записи, содержащие недействительные
сведения о сопоставленных объектах в синхронизируемых информационных базах.

## Подготовка к работе

Для использования расширения его необходимо подключить.
При подключении следует отключить параметры "Безопасный режим",
"Защита от опасных действий". Причина - расширение добавляет
собственную роль **"Использование перехода к сопоставленным объектам"**,
и предоставляет этой роли право чтения планов обмена и
регистров `НастройкиТранспортаОбменаДанными`,
`СоответствияОбъектовИнформационныхБаз`.

![Подключение расширения](/assets/images/extension-settings.png
"Подключение расширения")

Таким образом, пользователи, которым Вы назначите роль
"Использование перехода к сопоставленным объектам", получат
так же доступ на чтение к указанным объектам конфигурации.

Возможность использования предоставляемой расширением общей команды
получат пользователи, которым назначена хотя бы одна из ролей:

- Использование перехода к сопоставленным объектам
  (поставляется расширением)
- Выполнение синхронизации данных
  (поставляется расширяемой конфигурацией)

Для назначения пользователям указанной роли достаточно
скопировать профиль доступа после подключения расширения
и добавить в него указанную роль, после чего назначить
созданный профиль доступа необходимым пользователям.

![Создание профиля доступа](/assets/images/access-rights.png)

Для работы расширения необходимы параметры подключения к базе ЕМП:

- FQDN сервера (имя сервера)
- имя базы данных на сервере 1С:Предприятия

Эти параметры следует указать в настройках синхронизации (в настройках подключения).
Указанные параметры сохраняются в реквизитах регистра
`НастройкиТранспортаОбменаДанными`.
Эти настройки необходимо указать, даже если синхронизация данных
выполняется через обмен файлами.

![Вызов формы параметров подключения к базе](/assets/images/connection-settings-command.png)
![Параметры подключения к базе](/assets/images/connection-settings.png)

## О подготовке рабочего места разработчика

Подготовка рабочего места заключается в исполнении (с правами администратора)
файла `install\install.cmd`.
**Текущим должен быть корневой каталог репозитория!**
Потребуется несколько перезагрузок.
Выполнять вплоть до отсутствия ошибок при выполнении.

Будут установлены:

- [chocolatey][] (менеджер пакетов)
- [git][]
- [VSCode][]
- [OneScript][]
- ряд пакетов под OneScript
- и git precommit hook в репозиторий проекта

## Внесение изменений в расширения

Используем [precommit1c][].
Порядок действий по фиксации изменений в расширениях следующий:

- пишем новую версию расширения в каталог extensions
- добавляем расширение в индекс git: `git add extensions/\*.cfe`,
  или же указываем конкретный файл
- собственно, commit: `git commit`.
  При этом precommit1c разберёт добавленные в индекс расширения конфигурации,
  добавит в индекс "исходные" файлы расширений, а сами файлы расширений из индекса
  уберёт.

Безусловно, удобнее выполнять эти действия с использованием [VSCode][].

Репозиторий проекта размещён по адресу
[github.com/csm-ivanovo-ru/1s-GoToLinkedObjects](https://github.com/csm-ivanovo-ru/1s-GoToLinkedObjects).
Стратегия ветвления - Git Flow.

При необходимости внесения изменений в сам проект предложите Pull Request в основной
репозиторий в ветку `develop`.

### Полезные ссылки

- https://infostart.ru/public/864097/
- https://infostart.ru/public/721600/
- https://github.com/alexpetrov/xdd-bootstrap-1C

[chocolatey]: https://chocolatey.org
[Git]: https://github.com/git-guides/install-git#install-git-on-windows "Install Git on Windows"
[VSCode]: https://code.visualstudio.com "Visual Studio Code"
[OneScript]: http://oscript.io
[precommit1c]: https://github.com/xDrivenDevelopment/precommit1c
