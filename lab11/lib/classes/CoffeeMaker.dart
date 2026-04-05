class CoffeeMaker {
  // Нагрев воды
  Future<void> heatWater() async {
    print('Нагревание воды...');
    await Future.delayed(Duration(seconds: 3));
    print('Вода нагрета.');
  }

  // Заваривание кофе
  Future<void> brewCoffee() async {
    print('Заваривание кофе...');
    await Future.delayed(Duration(seconds: 5));
    print('Кофе заварен.');
  }

  // Взбивание молока
  Future<void> frothMilk() async {
    print('Взбивание молока...');
    await Future.delayed(Duration(seconds: 5));
    print('Молоко взбито.');
  }

  // Смешивание кофе и молока
  Future<void> mixCoffeeAndMilk() async {
    print('Смешивание кофе и молока...');
    await Future.delayed(Duration(seconds: 3));
    print('Кофе с молоком готов.');
  }

  // Приготовление эспрессо
  Future<void> makeEspresso() async {
    print('\n=== Приготовление эспрессо ===');
    await heatWater();
    await brewCoffee();
    print('Эспрессо готов!\n');
  }

  // Приготовление капучино
  Future<void> makeCappuccino() async {
    print('\n=== Приготовление капучино ===');
    await heatWater();
    
    // Заваривание и взбивание молока одновременно
    await Future.wait([
      brewCoffee(),
      frothMilk()
    ]);
    
    await mixCoffeeAndMilk();
    print('Капучино готов!\n');
  }

  // Приготовление американо
  Future<void> makeAmericano() async {
    print('\n=== Приготовление американо ===');
    await heatWater();
    await brewCoffee();
    print('Американо готов!\n');
  }
}
