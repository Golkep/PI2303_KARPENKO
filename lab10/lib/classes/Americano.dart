import '../interfaces/ICoffee.dart';
import 'Resources.dart';

class Americano implements ICoffee {
  @override
  String get name => 'Americano';

  @override
  String brew(Resources resources) {
    if (resources.hasEnough(50, 200, 0)) {
      resources.subtract(50, 200, 0);
      return 'Americano готов!';
    }
    return 'Недостаточно ресурсов для Americano.';
  }
}
