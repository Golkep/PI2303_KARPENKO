import 'classes/Machine.dart';
import 'dart:io';

void main() {
  print("Кофемашина\n");

  Machine coffeeMachine = Machine();

  bool isWorking = true;

  while (isWorking) {
    print("\nМеню:");
    print("1. Приготовить кофе");
    print("2. Показать статус");
    print("3. Пополнить запасы");
    print("4. Выход");
    print("Выбор: ");

    String? input = stdin.readLineSync();

    switch (input) {
      case "1":
        String result = coffeeMachine.makingCoffee();
        print(result);
        break;

      case "2":
        coffeeMachine.displayStatus();
        break;

      case "3":
        coffeeMachine.coffeeBeans = 500;
        coffeeMachine.water = 1000;
        coffeeMachine.milk = 300;
        print("Запасы пополнены.");
        break;

      case "4":
        print("Выход.");
        isWorking = false;
        break;

      default:
        print("Неверная опция.");
    }
  }
}
