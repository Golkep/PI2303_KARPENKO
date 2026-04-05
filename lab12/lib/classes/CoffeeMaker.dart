class CoffeeMaker {
  // Нагрев воды
  Future<String> heatWater() async {
    await Future.delayed(Duration(seconds: 3));
    return 'Вода нагрета';
  }

  // Заваривание кофе
  Future<String> brewCoffee() async {
    await Future.delayed(Duration(seconds: 5));
    return 'Кофе заварен';
  }

  // Взбивание молока
  Future<String> frothMilk() async {
    await Future.delayed(Duration(seconds: 5));
    return 'Молоко взбито';
  }

  // Смешивание кофе и молока
  Future<String> mixCoffeeAndMilk() async {
    await Future.delayed(Duration(seconds: 3));
    return 'Кофе с молоком готов';
  }

  // Приготовление эспрессо
  Future<List<String>> makeEspresso() async {
    List<String> steps = [];
    steps.add('Нагревание воды...');
    steps.add(await heatWater());
    steps.add('Заваривание кофе...');
    steps.add(await brewCoffee());
    return steps;
  }

  // Приготовление капучино
  Future<List<String>> makeCappuccino() async {
    List<String> steps = [];
    steps.add('Нагревание воды...');
    steps.add(await heatWater());
    steps.add('Заваривание и взбивание...');

    final results = await Future.wait([
      brewCoffee(),
      frothMilk()
    ]);

    steps.addAll(results);
    steps.add('Смешивание...');
    steps.add(await mixCoffeeAndMilk());
    return steps;
  }

  // Приготовление американо
  Future<List<String>> makeAmericano() async {
    List<String> steps = [];
    steps.add('Нагревание воды...');
    steps.add(await heatWater());
    steps.add('Заваривание кофе...');
    steps.add(await brewCoffee());
    return steps;
  }
}
