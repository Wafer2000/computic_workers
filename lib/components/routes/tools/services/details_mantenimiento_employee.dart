// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic_workers/components/routes/tools/helper_functions.dart';
import 'package:computic_workers/components/routes/tools/llegada.dart';
import 'package:computic_workers/components/routes/tools/loading_indicator.dart';
import 'package:computic_workers/components/routes/tools/my_button.dart';
import 'package:computic_workers/components/routes/tools/my_textfield.dart';
import 'package:computic_workers/components/routes/views/services.dart';
import 'package:computic_workers/components/routes/views/services/maintenance_employee.dart';
import 'package:computic_workers/shared/prefe_users.dart';
import 'package:computic_workers/style/global_colors.dart';
import 'package:flutter/material.dart';

class DetailsMaintenanceEmployee extends StatefulWidget {
  static const String routname = '/deatils_maintenance_employee';
  const DetailsMaintenanceEmployee({super.key});

  @override
  State<DetailsMaintenanceEmployee> createState() =>
      _DetailsMaintenanceEmployeeState();
}

class _DetailsMaintenanceEmployeeState
    extends State<DetailsMaintenanceEmployee> {
  final TextEditingController tipeController = TextEditingController();
  final TextEditingController desmaController = TextEditingController();
  final TextEditingController restecnicoController = TextEditingController();
  final TextEditingController tectotalController = TextEditingController();
  final _pref = PreferencesUser();

  @override
  void dispose() {
    super.dispose();
  }

  void RechazarTrabajo() async {
    LoadingScreen().show(context);
    FirebaseFirestore.instance
        .collection('Servicios')
        .doc(_pref.detailsId)
        .update({
      'tecnico': '',
      'idtecnico': '',
      'etapa': 'Tecnico No Asignado',
      'restecnicotf': null,
      'asistenciatf': null,
    });
    _pref.detailsId = '';
    LoadingScreen().hide();
    tipeController.clear();
    desmaController.clear();
    Navigator.pushNamed(context, Services.routname);
  }

  void Actualizar() async {
    LoadingScreen().show(context);

    if (restecnicoController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser('Debe colocar su respuesta al mantenimiento', context);
    } else if (tectotalController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser('Debe colocar un costo de su trabajo', context);
    } else {
      FirebaseFirestore.instance
          .collection('Servicios')
          .doc(_pref.detailsId)
          .update({
        'restecnico': restecnicoController.text,
        'etapa': 'Respuesta del Tecnico',
        'tectotal': tectotalController.text,
      });
      _pref.detailsId = '';
      LoadingScreen().hide();
      tipeController.clear();
      desmaController.clear();
      Navigator.pushNamed(context, MaintenanceEmployeeService.routname);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Mantenimiento')),
        actions: const [
          SizedBox(
            width: 56,
          )
        ],
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? WallpaperColor.steelBlue().color
            : WallpaperColor.kashmirBlue().color,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Servicios')
              .doc(_pref.detailsId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const AlertDialog(
                title: Text('Algo salio mal'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }
            if (snapshot.data == null) {
              return const Text('No hay datos');
            }
            final doc = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Tipo de PC: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${doc['tipo']}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Descripcion: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.left, // Add this line
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                '${doc['descripcion']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.left, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Tecnico: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.left, // Add this line
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                '${doc['tecnico']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.left, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (doc['restecnicotf'] == true &&
                          doc['asistenciatf'] == true)
                        const SizedBox(
                          height: 10,
                        ),
                      if (doc['asistenciatf'] == true)
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Direccion del Cliente: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      if (doc['asistenciatf'] == true)
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                '${doc['direccion']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (doc['asistenciatf'] == true)
                        const SizedBox(
                          height: 10,
                        ),
                      if (doc['restecnicotf'] == true &&
                          doc['asistiotf'] == true &&
                          doc['restecnico'] == '' &&
                          doc['asistenciatf'] == true)
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Add this line
                            children: [
                              Text(
                                'Respuesta del Tecnico: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.left, // Add this line
                              ),
                            ],
                          ),
                        ),
                      if (doc['restecnicotf'] == true &&
                          doc['asistiotf'] == true &&
                          doc['restecnico'] == '' &&
                          doc['asistenciatf'] == true)
                        MyTextField(
                            labelText:
                                'Su respuesta no puede ser modificada despues...',
                            obscureText: false,
                            controller: restecnicoController),
                      if (doc['restecnicotf'] == true &&
                          doc['asistiotf'] == true &&
                          doc['restecnico'] == '' &&
                          doc['asistenciatf'] == true)
                        const SizedBox(
                          height: 10,
                        ),
                      if (doc['restecnicotf'] == true &&
                          doc['asistiotf'] == true &&
                          doc['tectotal'] == '' &&
                          doc['asistenciatf'] == true)
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Add this line
                            children: [
                              Text(
                                'Costo de su trabajo: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.left, // Add this line
                              ),
                            ],
                          ),
                        ),
                      if (doc['restecnicotf'] == true &&
                          doc['asistiotf'] == true &&
                          doc['tectotal'] == '' &&
                          doc['asistenciatf'] == true)
                        MyTextField(
                            labelText:
                                'Su respuesta no puede ser modificada despues...',
                            obscureText: false,
                            controller: tectotalController),
                      if (doc['restecnicotf'] == true &&
                          doc['asistiotf'] == true &&
                          doc['tectotal'] == '' &&
                          doc['asistenciatf'] == true)
                        const SizedBox(
                          height: 10,
                        ),
                      if (doc['restecnico'] != '')
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Respuesta del tecnico: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.left, // Add this line
                            ),
                          ],
                        ),
                      ),
                      if (doc['restecnico'] != '')
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                '${doc['restecnico']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.left, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (doc['restecnico'] != '')
                        const SizedBox(
                          height: 10,
                        ),
                      if (doc['tectotal'] != '')
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Costo Total de Trabajo: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.left, // Add this line
                            ),
                          ],
                        ),
                      ),
                      if (doc['tectotal'] != '')
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                '${doc['tectotal']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.left, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (doc['tectotal'] != '')
                        const SizedBox(
                          height: 10,
                        ),
                      if (doc['etapa'] == 'Tecnico Asignado')
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 90,
                                decoration: BoxDecoration(
                                  color: WallpaperColor.baliHai().color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    RechazarTrabajo();
                                  },
                                  child: const Text('Rechazar',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              Container(
                                width: 90,
                                decoration: BoxDecoration(
                                  color: WallpaperColor.blueZodiac().color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.pushReplacementNamed(
                                        context, Llegada.routname);
                                  },
                                  child: const Text('Aceptar',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (doc['asistenciatf'] == false)
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'El cliente no acepto la hora que propusiste ¿Rechazas el trabajo o propones una hora y fecha?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (doc['asistenciatf'] == false)
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 90,
                                decoration: BoxDecoration(
                                  color: WallpaperColor.baliHai().color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    RechazarTrabajo();
                                  },
                                  child: const Text('Rechazar',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              Container(
                                width: 90,
                                decoration: BoxDecoration(
                                  color: WallpaperColor.blueZodiac().color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.pushNamed(
                                        context, Llegada.routname);
                                  },
                                  child: const Text('Proponer',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (doc['etapa'] != 'Tecnico Asignado' &&
                          doc['tectotal'] == '' &&
                          doc['asistiotf'] == true &&
                          doc['asistenciatf'] == true)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 40),
                          child: MyButton(text: 'Guardar', onTap: Actualizar),
                        ),
                      Divider(
                        height: 10, // The height of the divider
                        thickness: 1, // The thickness of the divider
                        color: Theme.of(context).brightness == Brightness.light
                            ? WallpaperColor.black().color
                            : WallpaperColor.white()
                                .color, // The color of the divider
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Solicitud',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Hora: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      '${doc['hsolicitud']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Fecha: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      '${doc['fsolicitud']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (doc['asistenciatf'] == null && doc['fllegada'] == '')
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Proceda a aceptar o denegar el trabajo y asi indicar su fecha y hora de llegada',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (doc['asistenciatf'] == null && doc['fllegada'] != '')
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    'En espera de la respuesta del cliente por propuesta de hora y fecha, hasta que no sea aceptada no debes proceder hacia las labores debidas; Espera con paciencia porfavor...',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
