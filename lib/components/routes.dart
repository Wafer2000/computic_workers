// ignore_for_file: unnecessary_null_comparison

import 'package:computic_workers/components/routes/log/login.dart';
import 'package:computic_workers/components/routes/log/register.dart';
import 'package:computic_workers/components/routes/tools/llegada.dart';
import 'package:computic_workers/components/routes/tools/services/admin/details_mantenimiento.dart';
import 'package:computic_workers/components/routes/tools/services/admin/details_rent.dart';
import 'package:computic_workers/components/routes/tools/services/details_mantenimiento_employee.dart';
import 'package:computic_workers/components/routes/tools/services/details_rent_employee.dart';
import 'package:computic_workers/components/routes/views/employees.dart';
import 'package:computic_workers/components/routes/views/guard/extra_data.dart';
import 'package:computic_workers/components/routes/views/services.dart';
import 'package:computic_workers/components/routes/views/profile.dart';
import 'package:computic_workers/components/routes/views/services/admin/maintenance.dart';
import 'package:computic_workers/components/routes/views/services/admin/rent.dart';
import 'package:computic_workers/components/routes/views/services/admin/shope.dart';
import 'package:computic_workers/components/routes/views/services/maintenance_employee.dart';
import 'package:computic_workers/components/routes/views/services/rent_employee.dart';
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
      home: const Services(),
      routes: {
        Login.routname: (context) => const Login(),
        Profile.routname: (context) => const Profile(),
        Register.routname: (context) => const Register(),
        ExtraData.routname: (context) => const ExtraData(),
        SplashView.routname: (context) => const SplashView(),
        Employees.routname: (context) => const Employees(),
        Services.routname: (context) => const Services(),
        Llegada.routname: (context) => const Llegada(),
        ShopeService.routname: (context) => const ShopeService(),
        //Mantenimiento
        MaintenanceService.routname: (context) => const MaintenanceService(),
        DetailsMaintenance.routname: (context) => const DetailsMaintenance(),
        MaintenanceEmployeeService.routname: (context) => const MaintenanceEmployeeService(),
        DetailsMaintenanceEmployee.routname: (context) => const DetailsMaintenanceEmployee(),
        //Alquiler
        RentService.routname: (context) => const RentService(),
        DetailsRent.routname: (context) => const DetailsRent(),
        RentEmployeeService.routname: (context) => const RentEmployeeService(),
        DetailsRentEmployee.routname: (context) => const DetailsRentEmployee(),
        
      },
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}