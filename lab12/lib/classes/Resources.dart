class Resources {
  int _beans = 250;
  int _milk = 250;
  int _water = 250;
  int _cash = 0;

  int get beans => _beans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  void addBeans(int amount) {
    _beans += amount;
  }

  void addMilk(int amount) {
    _milk += amount;
  }

  void addWater(int amount) {
    _water += amount;
  }

  void addCash(int amount) {
    _cash += amount;
  }

  void subtractBeans(int amount) {
    if (_beans >= amount) _beans -= amount;
  }

  void subtractMilk(int amount) {
    if (_milk >= amount) _milk -= amount;
  }

  void subtractWater(int amount) {
    if (_water >= amount) _water -= amount;
  }

  void subtractCash(int amount) {
    if (_cash >= amount) _cash -= amount;
  }

  bool canMakeEspresso() => _beans >= 50 && _water >= 100;
  bool canMakeCappuccino() => _beans >= 50 && _water >= 100 && _milk >= 50;
  bool canMakeAmericano() => _beans >= 50 && _water >= 100;

  void useEspresso() {
    subtractBeans(50);
    subtractWater(100);
  }

  void useCappuccino() {
    subtractBeans(50);
    subtractWater(100);
    subtractMilk(50);
  }

  void useAmericano() {
    subtractBeans(50);
    subtractWater(100);
  }
}
