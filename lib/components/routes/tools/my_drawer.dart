// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:computic_workers/components/routes/log/login.dart';
import 'package:computic_workers/components/routes/tools/loading_indicator.dart';
import 'package:computic_workers/components/routes/views/services.dart';
import 'package:computic_workers/components/routes/views/profile.dart';
import 'package:computic_workers/components/routes/views/employees.dart';
import 'package:computic_workers/shared/prefe_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var pref = PreferencesUser();

  final TextEditingController _textController = TextEditingController();

  Future<void> _signOut() async {
    LoadingScreen().show(context);

    try {
      await FirebaseAuth.instance.signOut();
      pref.ultimateUid = '';
      pref.isAdmin = false;
      LoadingScreen().hide();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  Theme.of(context).brightness == Brightness.light
                      ? 'assets/14.png'
                      : 'assets/13.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text('S E R V I C I O S'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Services.routname);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text('P E R F I L'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Profile.routname);
                  },
                ),
              ),
              if (pref.isAdmin == true)
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.group,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: const Text('E M P L E A D O S'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Employees.routname);
                    },
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text('C E R R A R  S E S I O N'),
              onTap: () {
                _signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
