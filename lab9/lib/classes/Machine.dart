class Machine {
  // Закрытые поля машины
  int _coffeeBeans = 500;
  int _milk = 300;
  int _water = 1000;
  int _cash = 0;

  // Геттеры
  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  // Сеттеры
  set coffeeBeans(int value) {
    if (value >= 0) {
      _coffeeBeans = value;
    }
  }

  set milk(int value) {
    if (value >= 0) {
      _milk = value;
    }
  }

  set water(int value) {
    if (value >= 0) {
      _water = value;
    }
  }

  set cash(int value) {
    if (value >= 0) {
      _cash = value;
    }
  }

  // Проверка доступности ресурсов
  bool isAvailable() {
    return _coffeeBeans >= 50 && _water >= 100;
  }

  // Закрытый метод уменьшения ресурсов
  void _subtractResources() {
    _coffeeBeans -= 50;
    _water -= 100;
  }

  // Метод приготовления кофе
  String makingCoffee() {
    if (isAvailable()) {
      _subtractResources();
      return "Кофе готов!";
    } else {
      return "Недостаточно ресурсов.";
    }
  }

  // Информационный метод
  void displayStatus() {
    print("=== Состояние машины ===");
    print("Кофейные зёрна: $_coffeeBeans г");
    print("Молоко: $_milk мл");
    print("Вода: $_water мл");
    print("Касса: $_cash копеек");
  }
}
