import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic_workers/components/routes/tools/my_button.dart';
import 'package:computic_workers/style/global_colors.dart';
import 'package:flutter/material.dart';

class DetailsMantenimiento extends StatefulWidget {
  static const String routname = '/deatils_maintenance';
  const DetailsMantenimiento({super.key, required this.id});
  final String id;
  
  @override
  State<DetailsMantenimiento> createState() => _DetailsMantenimientoState();
}

class _DetailsMantenimientoState extends State<DetailsMantenimiento> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Mantenimiento ${widget.id}'),
      ),
      body: Center(
        child: Text('Details for mantenimiento ${widget.id}'),
      ),
    );

  }
}
