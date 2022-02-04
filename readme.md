# Поддержка быстрого перехода к сопоставленным объектам

[![GitHub release](https://img.shields.io/github/v/release/csm-ivanovo-ru/1s-GoToLinkedObjects.svg?sort=semver&logo=github)](https://github.com/csm-ivanovo-ru/1s-GoToLinkedObjects/releases)

[![Semantic Versioning](https://img.shields.io/static/v1?label=Semantic%20Versioning&message=v2.0.0&color=green&logo=semver)](https://semver.org/lang/ru/spec/v2.0.0.html)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-v1.0.0-yellow.svg?logo=git)](https://conventionalcommits.org)

Данный репозиторий содержит расширение конфигураций 1С:Предприятие 8.3
для управляемых форм, предоставляющее общую команду для перехода
к сопоставленным объектам в синхронизируемых информационных базах.

## О подготовке рабочего места

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
