import 'package:flutter/material.dart';
import 'classes/CoffeeMaker.dart';

void main() {
  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
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

class _CoffeeScreenState extends State<CoffeeScreen> {
  final CoffeeMaker _maker = CoffeeMaker();
  bool _isLoading = false;
  List<String> _messages = [];

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _makeCoffee(Future<List<String>> Function() method, String name) async {
    setState(() {
      _isLoading = true;
      _messages = [];
    });

    _showSnackBar('Готовлю $name...');

    try {
      final steps = await method();
      setState(() {
        _messages = steps;
      });
      _showSnackBar('$name готов!');
    } catch (e) {
      _showSnackBar('Ошибка: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кофемашина'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Выберите кофе',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () => _makeCoffee(_maker.makeEspresso, 'Эспрессо'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                ),
                child: const Text('Эспрессо', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () => _makeCoffee(_maker.makeCappuccino, 'Капучино'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                ),
                child: const Text('Капучино', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () => _makeCoffee(_maker.makeAmericano, 'Американо'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                ),
                child: const Text('Американо', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 40),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_messages.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.brown),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: _messages
                        .map((msg) => Text(msg, style: const TextStyle(fontSize: 16)))
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
