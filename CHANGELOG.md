# Журнал изменений

Формат этого файла базируется на рекомендациях
[Keep a Changelog](https://keepachangelog.com/ru/1.0.0/).

Этот проект придерживается
[![Semantic Versioning](https://img.shields.io/static/v1?label=Semantic%20Versioning&message=v2.0.0&color=green&logo=semver)](https://semver.org/lang/ru/spec/v2.0.0.html).

## [Unreleased] Неопубликованные изменения (не вошедшие в релиз)

## [1.0.1]

### Исправлено

- исправлена ошибка нарушения прав доступа при выполнении
  общей команды `ППСО_ПерейтиКСопоставленномуОбъекту`
  при отсутствии роли "Синхронизация данных"
  [#5](https://github.com/csm-ivanovo-ru/1s-GoToLinkedObjects/issues/5)

## [1.0.0]

### Добавлено

- добавлена общая команда `ППСО_ПерейтиКСопоставленномуОбъекту`,
  размещена в панели формы "Синхронизация данных".
  Команда осуществляет переход к сопоставленному объекту в ЕМП
  [#2](https://github.com/csm-ivanovo-ru/1s-GoToLinkedObjects/issues/2)
- реквизиты доступа к ЕМП загружаются из регистра `НастройкиТранспортаОбменаДанными`

[Unreleased]: https://github.com/csm-ivanovo-ru/1s-GoToLinkedObjects/compare/1.0.1...HEAD
[1.0.1]: https://github.com/csm-ivanovo-ru/1s-GoToLinkedObjects/compare/1.0.1...1.0.0
[1.0.0]: https://github.com/csm-ivanovo-ru/1s-GoToLinkedObjects/releases/tag/1.0.0
