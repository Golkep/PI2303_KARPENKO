import 'package:flutter/material.dart';
import 'classes/CoffeeMaker.dart';
import 'classes/Resources.dart';

void main() {
  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Machine',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const CoffeeScreen(),
    );
  }
}

class CoffeeScreen extends StatefulWidget {
  const CoffeeScreen({Key? key}) : super(key: key);

  @override
  State<CoffeeScreen> createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen>
    with SingleTickerProviderStateMixin {
  final CoffeeMaker _maker = CoffeeMaker();
  final Resources _resources = Resources();

  late TabController _tabController;

  String _selectedCoffee = 'espresso';
  bool _isLoading = false;
  int _moneyInput = 0;

  final TextEditingController _beansController = TextEditingController();
  final TextEditingController _milkController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _cashController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _makeCoffee() async {
    bool canMake = false;
    String coffeeName = '';
    Future<List<String>> Function() method;

    if (_selectedCoffee == 'espresso') {
      if (!_resources.canMakeEspresso()) {
        _showSnackBar('Недостаточно ресурсов');
        return;
      }
      canMake = true;
      coffeeName = 'Эспрессо';
      method = _maker.makeEspresso;
      _resources.useEspresso();
    } else if (_selectedCoffee == 'cappuccino') {
      if (!_resources.canMakeCappuccino()) {
        _showSnackBar('Недостаточно ресурсов');
        return;
      }
      canMake = true;
      coffeeName = 'Капучино';
      method = _maker.makeCappuccino;
      _resources.useCappuccino();
    }

    if (canMake) {
      setState(() => _isLoading = true);
      _showSnackBar('Готовлю $coffeeName...');

      try {
        await method();
        _showSnackBar('$coffeeName готов!');
        setState(() {});
      } catch (e) {
        _showSnackBar('Ошибка: $e');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _addResource(String type, TextEditingController controller) {
    int value = int.tryParse(controller.text) ?? 0;
    if (type == 'beans') _resources.addBeans(value);
    else if (type == 'milk') _resources.addMilk(value);
    else if (type == 'water') _resources.addWater(value);
    else if (type == 'cash') _resources.addCash(value);
    controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Machine'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.coffee), text: 'Заказать'),
            Tab(icon: Icon(Icons.settings), text: 'Ресурсы'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Вкладка 1: Заказ
          SingleChildScrollView(
            child: Column(
              children: [
                // Статус ресурсов
                Container(
                  color: Colors.yellow[600],
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Beans: ${_resources.beans} | Milk: ${_resources.milk} | Water: ${_resources.water}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                // Основная панель
                Container(
                  color: Colors.lime[300],
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Coffee Maker',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('Your money: $_moneyInput',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                // Выбор кофе
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: const Text('espresso'),
                        value: 'espresso',
                        groupValue: _selectedCoffee,
                        onChanged: (value) =>
                            setState(() => _selectedCoffee = value!),
                      ),
                      RadioListTile<String>(
                        title: const Text('cappuccino'),
                        value: 'cappuccino',
                        groupValue: _selectedCoffee,
                        onChanged: (value) =>
                            setState(() => _selectedCoffee = value!),
                      ),
                    ],
                  ),
                ),
                // Кнопка заказа
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _makeCoffee,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.play_arrow,
                            color: Colors.white, size: 28),
                  ),
                ),
                // Поле денег
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _moneyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Put money here',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() => _moneyInput = int.tryParse(value) ?? 0);
                    },
                  ),
                ),
                // Кнопки +/-
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.green,
                        onPressed: () {
                          setState(() => _moneyInput++);
                          _moneyController.text = _moneyInput.toString();
                        },
                        child: const Text('+',
                            style: TextStyle(
                                fontSize: 24, color: Colors.white)),
                      ),
                      const SizedBox(width: 16),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.pink,
                        onPressed: () {
                          if (_moneyInput > 0) {
                            setState(() => _moneyInput--);
                            _moneyController.text = _moneyInput.toString();
                          }
                        },
                        child: const Text('-',
                            style: TextStyle(
                                fontSize: 24, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Вкладка 2: Ресурсы
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    color: Colors.lime[300],
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Resources:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Milk: ${_resources.milk}'),
                        Text('Water: ${_resources.water}'),
                        Text('Beans: ${_resources.beans}'),
                        Text('Cash: ${_resources.cash}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _beansController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'put beans',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _milkController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'put milk',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _waterController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'put water',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _cashController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'put cash',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.green,
                        onPressed: () {
                          _addResource('beans', _beansController);
                          _addResource('milk', _milkController);
                          _addResource('water', _waterController);
                          _addResource('cash', _cashController);
                        },
                        child: const Text('+',
                            style: TextStyle(
                                fontSize: 28, color: Colors.white)),
                      ),
                      const SizedBox(width: 16),
                      FloatingActionButton(
                        backgroundColor: Colors.red,
                        onPressed: () {
                          setState(() {
                            if (_resources.beans > 0)
                              _resources.subtractBeans(10);
                            if (_resources.milk > 0)
                              _resources.subtractMilk(10);
                            if (_resources.water > 0)
                              _resources.subtractWater(10);
                          });
                        },
                        child: const Text('-',
                            style: TextStyle(
                                fontSize: 28, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _beansController.dispose();
    _milkController.dispose();
    _waterController.dispose();
    _cashController.dispose();
    _moneyController.dispose();
    super.dispose();
  }
}
