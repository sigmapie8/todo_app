import 'package:get_it/get_it.dart';
import 'package:todo_app/data/services/local_storage_impl.dart';
import 'package:todo_app/domain/services/local_storage.dart';

/// [Service Locator] maintains all the abstraction to implementation
/// bindings and help accessing the implementation whenever you need it.

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorageImpl());
}
