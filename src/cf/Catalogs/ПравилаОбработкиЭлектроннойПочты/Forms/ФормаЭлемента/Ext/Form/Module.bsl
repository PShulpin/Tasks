﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Объект.Ссылка.Пустая() Тогда
		
		Если Не Взаимодействия.ПользовательЯвляетсяОтветственнымЗаВедениеПапок(Объект.Владелец) Тогда
			Отказ = Истина;
			Возврат;
		КонецЕсли;

		Если Параметры.ЗначениеКопирования.Пустая() Тогда
			ИнициализироватьКомпоновщикСервер(Неопределено);
		Иначе
			ИнициализироватьКомпоновщикСервер(Параметры.ЗначениеКопирования.КомпоновщикНастроек.Получить());
		КонецЕсли;
		
	Иначе
		
		Если Не Взаимодействия.ПользовательЯвляетсяОтветственнымЗаВедениеПапок(Объект.Владелец) Тогда
			ТолькоПросмотр = Истина;
			Элементы.КомпоновщикНастроекНастройкиОтбор.ТолькоПросмотр = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
	//+ #286 Иванов А.Б. 2017-12-17
	пОбъект = РеквизитФормыВЗначение("Объект");
	узОбщийМодульСервер.ДобавитьРеквизитыНаФорму(ЭтаФорма,пОбъект);                              
	//- #286 Иванов А.Б. 2017-12-17
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	СохраненныйКомпоновщикНастроек = ТекущийОбъект.КомпоновщикНастроек.Получить();
	ИнициализироватьКомпоновщикСервер(СохраненныйКомпоновщикНастроек);
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.ПредставлениеОтбора  = Строка(КомпоновщикНастроек.Настройки.Отбор);
	ТекущийОбъект.КомпоновщикНастроек = Новый ХранилищеЗначения(КомпоновщикНастроек.ПолучитьНастройки());
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	СформироватьСписокВыбораНаименования();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КомпоновщикНастроекНастройкиОтборПриИзменении(Элемент)
	
	СформироватьСписокВыбораНаименования();
	
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	СформироватьСписокВыбораНаименования();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ИнициализироватьКомпоновщикСервер(НастройкаКомпоновки)
	
	СхемаКомпоновки = Справочники.ПравилаОбработкиЭлектроннойПочты.ПолучитьМакет("СхемаПравилаОбработкиЭлектроннойПочты");
	АдресСхемы = ПоместитьВоВременноеХранилище(СхемаКомпоновки,УникальныйИдентификатор);
	КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемы));
	
	Если НастройкаКомпоновки = Неопределено Тогда
		КомпоновщикНастроек.ЗагрузитьНастройки(СхемаКомпоновки.НастройкиПоУмолчанию);
	Иначе
		КомпоновщикНастроек.ЗагрузитьНастройки(НастройкаКомпоновки);
		КомпоновщикНастроек.Восстановить(СпособВосстановленияНастроекКомпоновкиДанных.ПроверятьДоступность);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьСписокВыбораНаименования()
	
	Элементы.Наименование.СписокВыбора.Очистить();
	Если Не ПустаяСтрока(Объект.Наименование) Тогда
		Элементы.Наименование.СписокВыбора.Добавить(Объект.Наименование);
	КонецЕсли;
	ПредставлениеОтбора = Строка(КомпоновщикНастроек.Настройки.Отбор);
	Если СтрДлина(ПредставлениеОтбора) > 150 Тогда
		ПредставлениеОтбора = Лев(ПредставлениеОтбора,147) + "...";
	КонецЕсли;
	Если ПредставлениеОтбора <> Объект.Наименование Тогда
		Элементы.Наименование.СписокВыбора.Добавить(ПредставлениеОтбора);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
