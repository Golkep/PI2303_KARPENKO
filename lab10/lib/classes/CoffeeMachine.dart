import 'Resources.dart';
import '../interfaces/ICoffee.dart';
import 'Espresso.dart';
import 'Americano.dart';
import 'Cappuccino.dart';

class CoffeeMachine {
  late Resources resources;
  late Map<int, ICoffee> coffeeMenu;

  CoffeeMachine() {
    resources = Resources();
    coffeeMenu = {
      1: Espresso(),
      2: Americano(),
      3: Cappuccino()
    };
  }

  String brew(int coffeeType) {
    if (coffeeMenu.containsKey(coffeeType)) {
      return coffeeMenu[coffeeType]!.brew(resources);
    }
    return 'Неизвестный тип кофе.';
  }

  void refill() {
    resources.refill();
    print('Запасы пополнены.');
  }

  void showStatus() {
    resources.display();
  }

  void showMenu() {
    print('\nМеню:');
    coffeeMenu.forEach((key, coffee) {
      print('$key. ${coffee.name}');
    });
    print('4. Пополнить запасы');
    print('5. Статус');
    print('6. Выход');
  }
}
