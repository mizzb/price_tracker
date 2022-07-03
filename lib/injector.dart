import 'package:get_it/get_it.dart';
import 'package:price_tracker/controller/stores/home_store.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton(() => HomeStore());
}
