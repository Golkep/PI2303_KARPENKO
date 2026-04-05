import '../classes/Resources.dart';

abstract class ICoffee {
  String get name;
  String brew(Resources resources);
}
