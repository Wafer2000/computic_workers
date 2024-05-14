// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, await_only_futures

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic_workers/components/routes/log/login.dart';
import 'package:computic_workers/components/routes/views/services.dart';
import 'package:computic_workers/shared/prefe_users.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  static const String routname = 'splash_view';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    String admin = 'zUWqaYsFfQYukykS06bc0bS8hcn2';
    PreferencesUser prefs = PreferencesUser();
    Future.delayed(Duration(milliseconds: (6720).round()), () async {
      final uid = await prefs.ultimateUid;
      if (uid != null && uid != '' && prefs.ultimateUid == admin) {
        prefs.isAdmin = true;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const Services();
          }),
        );
      } else if (uid != null && uid != '') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const Services();
          }),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const Login();
          }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SizedBox(
          width: 120,
          height: 213.5,
          child: Lottie.asset('assets/splash.json'),
        ),
      ),
    );
  }
}
