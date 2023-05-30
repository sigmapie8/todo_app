import 'package:uuid/uuid.dart';

class Utilities {
  static String getIdForTask() {
    return const Uuid().v4();
  }
}
