import 'classes/CoffeeMachine.dart';
import 'dart:io';

void main() {
  CoffeeMachine machine = CoffeeMachine();
  bool isWorking = true;

  print('Кофемашина\n');

  while (isWorking) {
    machine.showMenu();
    print('Выбор: ');
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
      case '2':
      case '3':
        int coffeeType = int.tryParse(input ?? '') ?? 0;
        String result = machine.brew(coffeeType);
        print(result);
        break;

      case '4':
        machine.refill();
        break;

      case '5':
        machine.showStatus();
        break;

      case '6':
        print('Выход.');
        isWorking = false;
        break;

      default:
        print('Неверная опция.');
    }
  }
}
