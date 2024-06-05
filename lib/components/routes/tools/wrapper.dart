// ignore_for_file: library_private_types_in_public_api

import 'package:computic_workers/shared/prefe_users.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  final Widget child;

  const Wrapper({super.key, required this.child});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with WidgetsBindingObserver {
  final _pref = PreferencesUser();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _pref.detailsId = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
