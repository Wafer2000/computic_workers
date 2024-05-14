import 'package:computic_workers/components/routes.dart';
import 'package:computic_workers/firebase/firebase_options.dart';
import 'package:computic_workers/shared/prefe_users.dart';
import 'package:computic_workers/style/theme/dark.dart';
import 'package:computic_workers/style/theme/light.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferencesUser.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Routes(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}