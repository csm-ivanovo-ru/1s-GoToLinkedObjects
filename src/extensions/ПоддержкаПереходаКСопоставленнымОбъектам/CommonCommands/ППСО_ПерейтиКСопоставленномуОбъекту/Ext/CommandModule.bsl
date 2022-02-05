﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	НавигационнаяСсылкаПриемника = ПолучитьНавигационнуюСсылкуСопоставленногоОбъекта(ПараметрКоманды);
	ПерейтиПоНавигационнойСсылке(НавигационнаяСсылкаПриемника);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьНавигационнуюСсылкуСопоставленногоОбъекта(ОбъектСсылка)
	Контекст = "ППСО_ПерейтиКСопоставленномуОбъекту.ПолучитьНавигационнуюСсылкуСопоставленногоОбъекта";
	
	УзелИнформационнойБазы = ПолучитьУзелИнформационнойБазы();
	РеквизитыПодключения = ПолучитьРеквизитыПодключенияКУзлуИнформационнойБазы(УзелИнформационнойБазы);
	НавигационнаяСсылкаПриемника = ПолучитьНавигационнуюСсылкуСопоставленногоОбъектаДляИБ(
			ОбъектСсылка, УзелИнформационнойБазы, РеквизитыПодключения);
	Возврат НавигационнаяСсылкаПриемника;

КонецФункции

&НаСервере
Функция ПолучитьУзелИнформационнойБазы()
	Контекст = "ППСО_ПерейтиКСопоставленномуОбъекту.ПолучитьУзелИнформационнойБазы";

	Выборка = ПланыОбмена.ОбменБГУ2ЕМП.Выбрать();
	Пока Выборка.Следующий() Цикл
		Если Выборка.Ссылка = ПланыОбмена.ОбменБГУ2ЕМП.ЭтотУзел() Тогда
			Продолжить;
		Иначе
			ПланОбменаСсылка = Выборка.Ссылка;
			Возврат ПланОбменаСсылка;
		КонецЕсли;
	КонецЦикла;
	
	ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Не обнаружен план обмена типа ОбменБГУ2ЕМП.
			|Переход к сопоставленному объекту невозможен.
			|
			|Контекст ""%1""'",
			ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
		Контекст);
	ЗаписьЖурналаРегистрации("Переход к сопоставленному объекту. Поиск плана обмена",
		УровеньЖурналаРегистрации.Ошибка, , ,
		ТекстСообщения);
	ВызватьИсключение ТекстСообщения;
КонецФункции

&НаСервере
Функция ПолучитьРеквизитыПодключенияКУзлуИнформационнойБазы(УзелИнформационнойБазы)
	Контекст = "ППСО_ПерейтиКСопоставленномуОбъекту.ПолучитьРеквизитыПодключенияКУзлуИнформационнойБазы";

	// Запрос для получения реквизитов подключения к узлу информационной базы
	ЗапросРеквизитовПодключения = Новый Запрос;
	ЗапросРеквизитовПодключения.Текст = "
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	НастройкиТранспортаОбменаДанными.COMИмяСервера1СПредприятия КАК ИмяСервера,
		|	НастройкиТранспортаОбменаДанными.COMИмяИнформационнойБазыНаСервере1СПредприятия КАК ИмяИнформационнойБазы
		|ИЗ
		|	РегистрСведений.НастройкиТранспортаОбменаДанными КАК НастройкиТранспортаОбменаДанными
		|ГДЕ
		|	НастройкиТранспортаОбменаДанными.Корреспондент = &УзелИнформационнойБазы
		|";
	//

	ЗапросРеквизитовПодключения.УстановитьПараметр("УзелИнформационнойБазы", УзелИнформационнойБазы);
	РезультатЗапроса = ЗапросРеквизитовПодключения.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Не обнаружены реквизиты подключения к узлу информационной базы ""%2"".
				|(в регистре НастройкиТранспортаОбмена).
				|Переход к сопоставленному объекту невозможен.
				|
				|Контекст ""%1""'",
				ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			Контекст,
			Строка(УзелИнформационнойБазы.Наименование));
		ЗаписьЖурналаРегистрации("Переход к сопоставленному объекту. Поиск реквизитов подключения к ИБ",
			УровеньЖурналаРегистрации.Ошибка,
			Метаданные.НайтиПоТипу(ТипЗнч(УзелИнформационнойБазы)), УзелИнформационнойБазы,
			ТекстСообщения);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;

	РеквзитыПодключения = ОбщегоНазначения.СтрокаТаблицыЗначенийВСтруктуру(РезультатЗапроса.Выгрузить()[0]);
	Возврат РеквзитыПодключения;
	
КонецФункции

&НаСервере
Функция ПолучитьНавигационнуюСсылкуСопоставленногоОбъектаДляИБ(ОбъектСсылка, УзелИнформационнойБазы, РеквизитыПодключения)

	Контекст = "ППСО_ПерейтиКСопоставленномуОбъекту.ПолучитьНавигационнуюСсылкуСопоставленногоОбъектаДляИБ";

	УникальныйИдентификаторИсточника = ОбъектСсылка.УникальныйИдентификатор();
	ТипИсточника = Метаданные.НайтиПоТипу(ТипЗнч(ОбъектСсылка)).ПолноеИмя();

	// Запрос для определения информации о сопоставлении объектов для подмены ссылки источника, на ссылку приемника.
	ЗапросСоответствияОбъектовИнформационныхБаз = Новый Запрос;
	ЗапросСоответствияОбъектовИнформационныхБаз.Текст = "
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	СоответствияОбъектовИнформационныхБаз.УникальныйИдентификаторПриемника КАК УникальныйИдентификаторПриемника,
		|	СоответствияОбъектовИнформационныхБаз.ТипПриемника КАК ТипПриемника
		|ИЗ
		|	РегистрСведений.СоответствияОбъектовИнформационныхБаз КАК СоответствияОбъектовИнформационныхБаз
		|ГДЕ
		|	  СоответствияОбъектовИнформационныхБаз.УзелИнформационнойБазы           = &УзелИнформационнойБазы
		|	И СоответствияОбъектовИнформационныхБаз.УникальныйИдентификаторИсточника = &УникальныйИдентификаторИсточника
		|";
	//

	ЗапросСоответствияОбъектовИнформационныхБаз.УстановитьПараметр("УзелИнформационнойБазы", УзелИнформационнойБазы);
	ЗапросСоответствияОбъектовИнформационныхБаз.УстановитьПараметр("УникальныйИдентификаторИсточника", ОбъектСсылка);

	РезультатЗапроса = ЗапросСоответствияОбъектовИнформационныхБаз.Выполнить();

	Если РезультатЗапроса.Пустой() Тогда
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В регистре СоответствияОбъектовИнформационныхБаз
				|не найдены сведения для объекта ""%2"" (тип %3, уникальный идентификатор %4)).
				|Переход к сопоставленному объекту невозможен.
				|
				|Контекст ""%1""'",
				ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			Контекст,
			Строка(ОбъектСсылка), ТипИсточника, УникальныйИдентификаторИсточника);
		ЗаписьЖурналаРегистрации("Переход к сопоставленному объекту. Сведения о сопоставлении не найдены",
			УровеньЖурналаРегистрации.Ошибка,
			Метаданные.НайтиПоТипу(ТипЗнч(ОбъектСсылка)), ОбъектСсылка,
			ТекстСообщения);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
		
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	УникальныйИдентификаторПриемника = Выборка.УникальныйИдентификаторПриемника;
	ТипПриемника = Выборка.ТипПриемника;
	НаименованиеТипаОбъектаПриемника = СтрЗаменить(ТипПриемника, "Ссылка.", ".");

	ПрефиксНавигационнойСсылки = "e1c://server/"
		+ РеквизитыПодключения.ИмяСервера + "/" + РеквизитыПодключения.ИмяИнформационнойБазы;

	ПараметрНавигационнойСсылкиНаОбъектПриемника =
		Сред(УникальныйИдентификаторПриемника, 20, 4)
		+ Сред(УникальныйИдентификаторПриемника, 25, 12)
		+ Сред(УникальныйИдентификаторПриемника, 15, 4)
		+ Сред(УникальныйИдентификаторПриемника, 10, 4)
		+ Лев(УникальныйИдентификаторПриемника, 8);

	НавигационнаяСсылкаПриемника = ПрефиксНавигационнойСсылки
		+ "#e1cib/data/" + НаименованиеТипаОбъектаПриемника
		+ "?ref=" + ПараметрНавигационнойСсылкиНаОбъектПриемника;

	ЗаписьЖурналаРегистрации("Переход к сопоставленному объекту",
		УровеньЖурналаРегистрации.Примечание,
		Метаданные.НайтиПоТипу(ТипЗнч(ОбъектСсылка)), ОбъектСсылка,
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В регистре СоответствияОбъектовИнформационныхБаз
				|найдены сведения для объекта ""%2"" (тип %3, уникальный идентификатор %4):
				|сопоставлен объект с уникальным идентификатором %6 (тип %5).
				|
				|Навигационная ссылка сопоставленного объекта:
				|%7
				|
				|Контекст ""%1""'",
				ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			Контекст,
			Строка(ОбъектСсылка), ТипИсточника, УникальныйИдентификаторИсточника,
			ТипПриемника, УникальныйИдентификаторПриемника,
			НавигационнаяСсылкаПриемника));

	Возврат НавигационнаяСсылкаПриемника;

КонецФункции

#КонецОбласти
