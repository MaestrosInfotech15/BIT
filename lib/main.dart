import 'package:book_indian_talents_app/helper/page_routes.dart';
import 'package:book_indian_talents_app/helper/permission_helper.dart';
import 'package:book_indian_talents_app/helper/session_manager.dart';
import 'package:book_indian_talents_app/helper/size_config.dart';
import 'package:book_indian_talents_app/helper/theme_helper.dart';
import 'package:book_indian_talents_app/provider/api_controller.dart';
import 'package:book_indian_talents_app/provider/app_controller.dart';
import 'package:book_indian_talents_app/provider/file_provider.dart';
import 'package:book_indian_talents_app/screens/home_screen.dart';
import 'package:book_indian_talents_app/screens/login_screen.dart';
import 'package:book_indian_talents_app/screens/onboarding_screen.dart';
import 'package:book_indian_talents_app/screens/register_screen.dart';
import 'package:book_indian_talents_app/screens/splash_screen.dart';
import 'package:book_indian_talents_app/screens/welcom_screen.dart';
import 'package:book_indian_talents_app/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'helper/firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await SessionManager.init();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 await NotificationService().init();
 await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppController()),
        ChangeNotifierProvider(create: (context) => ApiController()),
        ChangeNotifierProvider(create: (context) => FileProvider()),
      ],
      child: MaterialApp  (
          title: 'Book Indian Talents',
          debugShowCheckedModeBanner: false,
          theme: ThemeHelper.lightTheme(),
          navigatorKey: SizeConfig.navigatorKey,
          onGenerateRoute: PageRoutes.onGenerateRoute,
          initialRoute: SplashScreen.id),
    );
  }
  //todo: function name change
  String getPage() {
    if (SessionManager.getWelcome() == false) {
      return OnboardingScreen.id;
    }
    if (SessionManager.isLoggedIn() == false) {
      return LoginScreen.id;
    }
    return HomeScreen.id;
  }
}