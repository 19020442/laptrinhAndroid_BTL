import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/routes/app_router.dart';
import 'package:no_name_app/routes/routes.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  FirebaseCrashlytics.instance.log(firebaseApp.toString());
  Get.put<AuthController>(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          _authController.isLogin ? Routes.HOME_SCREEN : Routes.LOGIN_SCREEN,
      getPages: Pages.pages,
    );
  }
}
