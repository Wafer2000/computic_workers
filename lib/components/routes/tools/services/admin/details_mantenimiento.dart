
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic_workers/components/routes/tools/helper_functions.dart';
import 'package:computic_workers/components/routes/tools/loading_indicator.dart';
import 'package:computic_workers/components/routes/tools/my_button.dart';
import 'package:computic_workers/components/routes/tools/my_textfield.dart';
import 'package:computic_workers/components/routes/views/services/admin/maintenance.dart';
import 'package:computic_workers/shared/prefe_users.dart';
import 'package:computic_workers/style/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsMaintenance extends StatefulWidget {
  static const String routname = '/deatils_maintenance';
  const DetailsMaintenance({super.key});

  @override
  State<DetailsMaintenance> createState() => _DetailsMaintenanceState();
}

class _DetailsMaintenanceState extends State<DetailsMaintenance> {
  final TextEditingController tipeController = TextEditingController();
  final TextEditingController desmaController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  String? _tecnico = '';
  String? _idtecnico = '';
  String? _antiguoidtecnico = '';
  final String? _restecnicotf = null;
  final String _restecnico = '';
  final String _etapa = '';
  final String _tectotal = '';
  final String _extras = '';
  final String _total = '';
  List<String>? _dropDownItems = [];
  final _pref = PreferencesUser();

  @override
  void dispose() {
    super.dispose();
  }

  void Total() async {
    LoadingScreen().show(context);

    final now = DateTime.now();
    final hrespuesta = DateFormat('HH:mm:ss').format(now);
    final frespuesta = DateFormat('yyyy-MM-dd').format(now);

    if (totalController.text == '') {
      LoadingScreen().hide();
      displayMessageToUser('Debe colocar un costo total', context);
    } else {
      FirebaseFirestore.instance
          .collection('Servicios')
          .doc(_pref.detailsId)
          .update({
        'hrespuesta': hrespuesta,
        'frespuesta': frespuesta,
        'total': totalController.text,
      });
      _pref.detailsId = '';
      LoadingScreen().hide();
      totalController.clear();
      Navigator.pushNamed(context, MaintenanceService.routname);
      LoadingScreen().hide();
      displayMessageToUser('Total enviado al cliente', context);
    } 
  }

  void Actualizar() async {
    LoadingScreen().show(context);
    print('Id Antiguo: $_antiguoidtecnico');

    if (_idtecnico == '') {
      LoadingScreen().hide();
      displayMessageToUser('Debe colocar un empleado', context);
    } else if (_idtecnico == _antiguoidtecnico) {
      FirebaseFirestore.instance
          .collection('Servicios')
          .doc(_pref.detailsId)
          .update({
        'tecnico': _tecnico,
        'idtecnico': _idtecnico,
        'restecnico': _restecnico,
        'etapa': _etapa,
        'tectotal': _tectotal,
        'restecnicotf': _restecnicotf,
        'extras': _extras,
        'total': _total,
      });
      _pref.detailsId = '';
      LoadingScreen().hide();
      tipeController.clear();
      desmaController.clear();
      Navigator.pushNamed(context, MaintenanceService.routname);
      LoadingScreen().hide();
      displayMessageToUser('Debe colocar un empleado', context);
    } else if (_idtecnico == '' || _idtecnico != _antiguoidtecnico) {
      FirebaseFirestore.instance
          .collection('Servicios')
          .doc(_pref.detailsId)
          .update({
        'tecnico': _tecnico,
        'idtecnico': _idtecnico,
        'etapa': 'Tecnico Asignado',
        'restecnicotf': null,
        'tectotal': '',
        'extras': '',
        'total': '',
        'restecnico': '',
      });
      _pref.detailsId = '';
      LoadingScreen().hide();
      tipeController.clear();
      desmaController.clear();
      Navigator.pushNamed(context, MaintenanceService.routname);
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

            final Map<String, dynamic>? docData = doc.data();
            _tecnico = docData?['tecnico'] as String?;
            _idtecnico = docData?['idtecnico'] as String?;

            final TextEditingController employeeController =
                TextEditingController(text: doc['tecnico']);
            final TextEditingController employeeIdController =
                TextEditingController(text: doc['idtecnico']);

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
                      if (doc['restecnico'] == '')
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
                      if (doc['restecnico'] == '')
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .where('cargo', isEqualTo: 'employees')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshotEm) {
                            if (snapshotEm.hasError) {
                              print('Error: ${snapshotEm.error}');
                              return const CircularProgressIndicator();
                            }

                            if (snapshotEm.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            _dropDownItems = snapshotEm.data!.docs
                                .map((em) =>
                                    '${em['nombres'].split(' ')[0]} ${em['apellidos'].split(' ')[0]}')
                                .cast<String>()
                                .toList();

                            return DropdownButtonFormField<String>(
                              value: employeeIdController.text.isNotEmpty
                                  ? employeeController.text
                                  : null,
                              items: _dropDownItems?.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                final DocumentSnapshot<Map<String, dynamic>>
                                    em =
                                    snapshotEm.data!.docs.firstWhere((em) =>
                                        '${em['nombres'].split(' ')[0]} ${em['apellidos'].split(' ')[0]}' ==
                                        value);
                                final String docId = em.id;
                                employeeIdController.text = docId;
                                employeeController.text = value!;
                                _idtecnico = employeeIdController.text;
                                _tecnico = employeeController.text;
                                _antiguoidtecnico = doc['idtecnico'];
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                floatingLabelStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? WallpaperColor.black().color
                                        : WallpaperColor.white().color),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? WallpaperColor.black().color
                                        : WallpaperColor.white().color,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            );
                          },
                        ),
                      if (doc['restecnico'] != '')
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
                      if (doc['restecnico'] != '')
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
                      if (doc['tecnico'] != '')
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
                                'Respuesta del Tecnico: ',
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
                      if (doc['restecnico'] != '')
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Add this line
                            children: [
                              Text(
                                'Etapa: ',
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
                                  doc['tectotal'] != ''
                                      ? 'El Tecnico Termino'
                                      : 'Aun no ha dado respuesta el Tecnico',
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
                                'Total del Tecnico: ',
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
                      if (doc['restecnico'] != '')
                        const SizedBox(
                          height: 10,
                        ),
                      if (doc['tectotal'] != '' && doc['total'] == '')
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Add this line
                            children: [
                              Text(
                                'Costo Total del Trabajo: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.left, // Add this line
                              ),
                            ],
                          ),
                        ),
                      if (doc['tectotal'] != '' && doc['total'] == '')
                        MyTextField(
                            labelText:
                                'Su respuesta no puede ser modificada despues...',
                            obscureText: false,
                            controller: totalController),
                            
                      if (doc['total'] != '')
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Add this line
                            children: [
                              Text(
                                'Total: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.left, // Add this line
                              ),
                            ],
                          ),
                        ),
                      if (doc['total'] != '')
                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Add this line
                            children: [
                              Flexible(
                                child: Text(
                                  '${doc['total']}',
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.left, // Add this line
                                ),
                              ),
                            ],
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                      if (doc['frespuesta'] != '' && doc['hrespuesta'] != '')
                        Divider(
                          height: 10, // The height of the divider
                          thickness: 1, // The thickness of the divider
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.black().color
                                  : WallpaperColor.white()
                                      .color, // The color of the divider
                        ),
                      if (doc['frespuesta'] != '' && doc['hrespuesta'] != '')
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Solicitud',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      if (doc['frespuesta'] != '' && doc['hrespuesta'] != '')
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
                                        '${doc['hrespuesta']}',
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
                                        '${doc['frespuesta']}',
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (doc['frespuesta'] != '' && doc['hrespuesta'] != '')
                        const SizedBox(
                          height: 10,
                        ),
                      if (doc['tectotal'] == '')
                      MyButton(text: 'Guardar', onTap: Actualizar),
                      if (doc['tectotal'] != '' && doc['total'] == '')
                      MyButton(text: 'Guardar', onTap: Total)
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
