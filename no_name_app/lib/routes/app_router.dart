import 'package:get/get.dart';
import 'package:no_name_app/screens/login_screen.dart';
import 'package:no_name_app/screens/home_screen.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/screens/register_screen.dart';

class Pages {
  static final pages = [
    GetPage(name: Routes.LOGIN_SCREEN, page: () => const AuthScreen()),
    GetPage(name: Routes.HOME_SCREEN, page: () => const HomeScreen()),
    // GetPage(name: name, page: page)
    // GetPage(name: Routes.REGISTER_SCREEN, page: () => const RegisterScreen())
  ];
}
