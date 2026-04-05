class Resources {
  int _coffeeBeans;
  int _water;
  int _milk;

  Resources({
    int coffeeBeans = 500,
    int water = 1000,
    int milk = 300
  }) : _coffeeBeans = coffeeBeans,
       _water = water,
       _milk = milk;

  int get coffeeBeans => _coffeeBeans;
  int get water => _water;
  int get milk => _milk;

  void subtract(int beans, int water, int milk) {
    _coffeeBeans -= beans;
    _water -= water;
    _milk -= milk;
  }

  bool hasEnough(int beans, int water, int milk) {
    return _coffeeBeans >= beans && _water >= water && _milk >= milk;
  }

  void refill() {
    _coffeeBeans = 500;
    _water = 1000;
    _milk = 300;
  }

  void display() {
    print("Ресурсы: зёрна=$_coffeeBeans г, вода=$_water мл, молоко=$_milk мл");
  }
}
