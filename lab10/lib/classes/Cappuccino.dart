import '../interfaces/ICoffee.dart';
import 'Resources.dart';

class Cappuccino implements ICoffee {
  @override
  String get name => 'Cappuccino';

  @override
  String brew(Resources resources) {
    if (resources.hasEnough(40, 80, 150)) {
      resources.subtract(40, 80, 150);
      return 'Cappuccino готов!';
    }
    return 'Недостаточно ресурсов для Cappuccino.';
  }
}
