﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПараметрыОтбора = Новый Структура("ПроблемныйОбъект", ПараметрКоманды);
	ПараметрыФормы = Новый Структура("Отбор", ПараметрыОтбора);
	
	ОткрытьФорму("РегистрСведений.РезультатыОбменаДанными.Форма.ПредупрежденияСинхронизаций",
		ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность,
		ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
