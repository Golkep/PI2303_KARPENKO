import '../interfaces/ICoffee.dart';
import 'Resources.dart';

class Espresso implements ICoffee {
  @override
  String get name => 'Espresso';

  @override
  String brew(Resources resources) {
    if (resources.hasEnough(50, 100, 0)) {
      resources.subtract(50, 100, 0);
      return 'Espresso готов!';
    }
    return 'Недостаточно ресурсов для Espresso.';
  }
}
