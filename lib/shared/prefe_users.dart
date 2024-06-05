import 'package:computic_workers/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUser {
  static late SharedPreferences _prefs;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _prefs = await SharedPreferences.getInstance();
  }

  String get ultimateUid {
    return _prefs.getString('ultimateUid') ?? '';
  }

  set ultimateUid(String value) {
    _prefs.setString('ultimateUid', value);
  }

  String get detailsId {
    return _prefs.getString('detailsId') ?? '';
  }

  set detailsId(String value) {
    _prefs.setString('detailsId', value);
  }

  bool get isAdmin {
    return _prefs.getBool('isAdmin') ?? false;
  }

  set isAdmin(bool value) {
    _prefs.setBool('isAdmin', value);
  }
}
