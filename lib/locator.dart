import 'package:chatIt/services/authenticationServices.dart';
import 'package:chatIt/services/firestoreServices.dart';
import 'package:chatIt/services/navigatorServices.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => FireStoreServices());
}
