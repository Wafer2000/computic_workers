// ignore_for_file: unnecessary_null_comparison

import 'package:computic_workers/components/routes/log/login.dart';
import 'package:computic_workers/components/routes/log/register.dart';
import 'package:computic_workers/components/routes/tools/services/details_Mantenimiento.dart';
import 'package:computic_workers/components/routes/views/employees.dart';
import 'package:computic_workers/components/routes/views/guard/extra_data.dart';
import 'package:computic_workers/components/routes/views/services.dart';
import 'package:computic_workers/components/routes/views/profile.dart';
import 'package:computic_workers/components/routes/views/services/maintenance.dart';
import 'package:computic_workers/components/routes/views/services/shope.dart';
import 'package:computic_workers/components/splash_view.dart';
import 'package:computic_workers/shared/prefe_users.dart';
import 'package:computic_workers/style/theme/dark.dart';
import 'package:computic_workers/style/theme/light.dart';
import 'package:flutter/material.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  final prefs = PreferencesUser();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.routname,
      routes: {
        Services.routname: (context) => const Services(),
        Login.routname: (context) => const Login(),
        Profile.routname: (context) => const Profile(),
        Register.routname: (context) => const Register(),
        ExtraData.routname: (context) => const ExtraData(),
        SplashView.routname: (context) => const SplashView(),
        Employees.routname: (context) => const Employees(),
        //RentService.routname: (context) => const RentService(),
        ShopeService.routname: (context) => const ShopeService(),
        //CreationService.routname: (context) => const CreationService(),
        //FacilityService.routname: (context) => const FacilityService(),
        //TrainingService.routname: (context) => const TrainingService(),
        MaintenanceService.routname: (context) => const MaintenanceService(),
        DetailsMantenimiento.routname: (context) => DetailsMantenimiento(id: ModalRoute.of(context)!.settings.arguments as String),
      },
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}