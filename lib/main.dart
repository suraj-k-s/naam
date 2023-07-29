import 'package:flutter/material.dart';
import 'package:naam/sheet_api.dart';
import 'package:naam/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SheetApi.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: SplashScreen(),
          ),
        ),
      ),
    );
  }
}
