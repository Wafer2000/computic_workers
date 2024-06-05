// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic_workers/components/routes/tools/helper_functions.dart';
import 'package:computic_workers/components/routes/tools/loading_indicator.dart';
import 'package:computic_workers/shared/prefe_users.dart';
import 'package:computic_workers/style/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Llegada extends StatefulWidget {
  static const String routname = '/llegada';
  const Llegada({super.key});

  @override
  State<Llegada> createState() => _LlegadaState();
}

class _LlegadaState extends State<Llegada> {
  final TextEditingController hllegadaController = TextEditingController();
  final TextEditingController fllegadaController = TextEditingController();
  final _pref = PreferencesUser();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Center(child: Text('Llegada')),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? WallpaperColor.steelBlue().color
              : WallpaperColor.kashmirBlue().color,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Nota: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Debes asignar tu hora y fecha de llegada para atender al cliente, la cual no podra ser modificada por nadie mas que el administrador.',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: hllegadaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Hora de Llegada',
                      floatingLabelStyle: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.black().color
                                  : WallpaperColor.white().color),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.black().color
                                  : WallpaperColor.white().color,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    onTap: () async {
                      var time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        cancelText: 'Cancelar',
                        confirmText: 'Confirmar',
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data:
                                Theme.of(context).brightness == Brightness.light
                                    ? ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(
                                          background: Colors.grey.shade300,
                                          primary: Colors.grey.shade500,
                                          secondary: Colors.grey.shade400,
                                          inversePrimary: Colors.grey.shade500,
                                        ),
                                      )
                                    : ThemeData.dark().copyWith(
                                        colorScheme: ColorScheme.dark(
                                          background: Colors.grey.shade300,
                                          primary: Colors.grey.shade500,
                                          secondary: Colors.grey.shade400,
                                          inversePrimary: Colors.grey.shade500,
                                        ),
                                      ),
                            child: child!,
                          );
                        },
                      );
                      if (time != null && mounted) {
                        var format = DateFormat('HH:mm:ss');
                        var formattedTime = format
                            .format(DateTime(0, 0, 0, time.hour, time.minute));
                        setState(() {
                          hllegadaController.text = formattedTime;
                        });
                      }
                    },
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: fllegadaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: 'Fecha de Llegada',
                      floatingLabelStyle: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    onTap: () async {
                      DateTime? datetime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        cancelText: 'Cancelar',
                        confirmText: 'Confirmar',
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data:
                                Theme.of(context).brightness == Brightness.light
                                    ? ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(
                                          background: Colors.grey.shade300,
                                          primary: Colors.grey.shade500,
                                          secondary: Colors.grey.shade400,
                                          inversePrimary: Colors.grey.shade500,
                                        ),
                                      )
                                    : ThemeData.dark().copyWith(
                                        colorScheme: ColorScheme.dark(
                                          background: Colors.grey.shade300,
                                          primary: Colors.grey.shade500,
                                          secondary: Colors.grey.shade400,
                                          inversePrimary: Colors.grey.shade500,
                                        ),
                                      ),
                            child: child!,
                          );
                        },
                      );
                      if (datetime != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(datetime);
                        fllegadaController.text = formattedDate;
                      }
                    },
                    obscureText: false,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? 'assets/14.png'
                            : 'assets/13.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Divider(
                    height: 10, // The height of the divider
                    thickness: 1, // The thickness of the divider
                    color: Theme.of(context).brightness == Brightness.light
                        ? WallpaperColor.black().color
                        : WallpaperColor.white()
                            .color, // The color of the divider
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: WallpaperColor.baliHai().color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            hllegadaController.clear();
                            fllegadaController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text('Cancelar',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: WallpaperColor.blueZodiac().color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            LoadingScreen().show(context);

                            if (hllegadaController.text == '') {
                              LoadingScreen().hide();
                              displayMessageToUser(
                                  'Debe colocar la hora de asistencia',
                                  context);
                            } else if (fllegadaController.text == '') {
                              LoadingScreen().hide();
                              displayMessageToUser(
                                  'Debe colocar la fecha de asistencia',
                                  context);
                            } else {
                              LoadingScreen().show(context);

                              await FirebaseFirestore.instance
                                  .collection('Servicios')
                                  .doc(_pref.detailsId)
                                  .update({
                                'hllegada': hllegadaController.text,
                                'fllegada': fllegadaController.text,
                                'restecnicotf': true,
                                'etapa': 'Fecha de Asistencia Propuesta',
                              });
                            }
                            hllegadaController.clear();
                            fllegadaController.clear();
                            displayMessageToUser('Datos Guardados', context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            LoadingScreen().hide();
                          },
                          child: const Text('Guardar',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
