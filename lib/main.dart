import 'package:flutter/material.dart';
import 'package:login_app/screens/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: [Locale('en', 'IND'), Locale('ta', 'IND')],
    path: 'assets/translations',
    saveLocale: true,
    fallbackLocale: Locale('en', 'IND'),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Scaffold(
        body: const SplashScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
