abstract class StateBase{}

// обновлене всего
class StateStart extends StateBase {}

//Загрузка суммы
class StateLoadingSummBU extends StateBase {}

//Загрузка контента
class StateLoadingContentPlus extends StateBase {}

//Контент загружен
class StateCompleteContext extends StateBase {
  var notes;
  StateCompleteContext(this.notes);
}

//Сумма загружена
class StateCompleteSummBU extends StateBase{
  var date;
  var notes;
  StateCompleteSummBU(this.date, this.notes);
}

//Ошибка загрузки
class StateErr extends StateBase {}