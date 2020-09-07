abstract class Event {

}
//открыть диалог занесения новой записи
class EventDialogOpen extends Event {}

// закрыть диалог
class EventDialogClose extends Event {}

//обновление даты
class EventAddNullDate extends Event{}

// обновление всего
class EventBase extends Event {}