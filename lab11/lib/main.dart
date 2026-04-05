import 'classes/CoffeeMaker.dart';
import 'dart:io';

void main() async {
  CoffeeMaker maker = CoffeeMaker();

  print('=== Асинхронная кофемашина ===\n');

  bool isWorking = true;

  while (isWorking) {
    print('Меню:');
    print('1. Эспрессо');
    print('2. Капучино');
    print('3. Американо');
    print('4. Выход');
    print('Выбор: ');

    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        await maker.makeEspresso();
        break;

      case '2':
        await maker.makeCappuccino();
        break;

      case '3':
        await maker.makeAmericano();
        break;

      case '4':
        print('Выход.');
        isWorking = false;
        break;

      default:
        print('Неверная опция.\n');
    }
  }
}
