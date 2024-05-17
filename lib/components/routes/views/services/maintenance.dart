// ignore_for_file: non_constant_identifier_names, unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic_workers/components/routes/tools/helper_functions.dart';
import 'package:computic_workers/components/routes/tools/loading_indicator.dart';
import 'package:computic_workers/components/routes/tools/my_button.dart';
import 'package:computic_workers/components/routes/tools/my_drawer.dart';
import 'package:computic_workers/components/routes/tools/my_textfield.dart';
import 'package:computic_workers/components/routes/tools/services/details_Mantenimiento.dart';
import 'package:computic_workers/firebase/firestore.dart';
import 'package:computic_workers/shared/prefe_users.dart';
import 'package:computic_workers/style/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MaintenanceService extends StatefulWidget {
  static const String routname = '/maintenance';
  const MaintenanceService({super.key});

  @override
  State<MaintenanceService> createState() => _MaintenanceServiceState();
}

class _MaintenanceServiceState extends State<MaintenanceService> {
  //Mantenimiento
  final TextEditingController tipeController = TextEditingController();
  final TextEditingController desmaController = TextEditingController();

  final _pref = PreferencesUser();

  String mantenimientoTag = 'mantenimientoTag';

  @override
  void dispose() {
    super.dispose();
  }

  void details_Mantenimiento(String id) {
    String? tecnico = '';
    String? idtecnico = '';
    String? restecnico = '';
    String? etapa = '';
    String? tectotal = '';
    String? extras = '';
    String? total = '';

    void Actualizar() async {
      LoadingScreen().show(context);

      if (idtecnico == '') {
        LoadingScreen().hide();
        displayMessageToUser('Debe colocar un empleado', context);
      } else {
        FirebaseFirestore.instance
            .collection('Servicios')
            .doc('documentId')
            .update({
          'tecnico': tecnico,
          'idtecnico': idtecnico,
          'restecnico': restecnico,
          'etapa': etapa,
          'tectotal': tectotal,
          'extras': extras,
          'total': total,
        });
        LoadingScreen().hide();
        tipeController.clear();
        desmaController.clear();
        Navigator.pushNamed(context, MaintenanceService.routname);
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detalles de su mantenimiento'),
          icon: const Icon(Icons.build),
          shadowColor: WallpaperColor.baliHai().color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Servicios')
                  .doc(id)
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
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
                                  style: const TextStyle(fontSize: 15),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
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
                                    style: const TextStyle(fontSize: 15),
                                    textAlign: TextAlign.left, // Add this line
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .where('cargo', isEqualTo: 'employees')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return const CircularProgressIndicator();
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              List<String>? dropDownItems = [];

                              final Map<String, dynamic>? docData = doc.data();
                              tecnico = docData?['tecnico'] as String?;
                              idtecnico = docData?['idtecnico'] as String?;

                              final TextEditingController employeeController =
                                  TextEditingController(text: tecnico ?? '');
                              final TextEditingController employeeIdController =
                                  TextEditingController(text: doc['idtecnico']);

                              dropDownItems = snapshot.data!.docs
                                  .map((em) => em['nombres'] as String)
                                  .toList();

                              return DropdownButtonFormField<String>(
                                value: employeeController.text.isNotEmpty
                                    ? employeeController.text
                                    : null,
                                items: dropDownItems.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  try {
                                    final List<
                                            QueryDocumentSnapshot<
                                                Map<String, dynamic>>>? docs =
                                        snapshot.data?.docs
                                            .where((em) =>
                                                '${em['nombres']}' == value)
                                            .toList();
                                    if (docs!.isNotEmpty) {
                                      final DocumentSnapshot<
                                          Map<String, dynamic>> em = docs.first;
                                      final String docId = em.id;
                                      setState(() {
                                        employeeIdController.text = docId;
                                        idtecnico = employeeIdController.text;
                                        print(tecnico);
                                        employeeController.text = value!;
                                        tecnico = employeeController.text;
                                        print(idtecnico);
                                      });
                                    } else {
                                      // Handle the case where no document is found
                                      setState(() {
                                        employeeIdController.text = '';
                                        employeeController.text = '';
                                      });
                                    }
                                  } catch (e) {
                                    // Handle any exceptions that may occur
                                    print('Error: $e');
                                  }
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                decoration: InputDecoration(
                                  labelText: 'Tecnico Asignado',
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
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
                                      style: const TextStyle(fontSize: 15),
                                      textAlign:
                                          TextAlign.left, // Add this line
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
                                    'Respuesta del Tecnico: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
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
                                      '${doc['etapa']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign:
                                          TextAlign.left, // Add this line
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
                                    'Respuesta del Tecnico: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
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
                                      '${doc['total']}',
                                      style: const TextStyle(fontSize: 15),
                                      textAlign:
                                          TextAlign.left, // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['restecnico'] != '')
                            const SizedBox(
                              height: 10,
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
                            color:
                                Theme.of(context).brightness == Brightness.light
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          if (doc['frespuesta'] != '' &&
                              doc['hrespuesta'] != '')
                            Divider(
                              height: 10, // The height of the divider
                              thickness: 1, // The thickness of the divider
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? WallpaperColor.black().color
                                  : WallpaperColor.white()
                                      .color, // The color of the divider
                            ),
                          if (doc['frespuesta'] != '' &&
                              doc['hrespuesta'] != '')
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Solicitud',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          if (doc['frespuesta'] != '' &&
                              doc['hrespuesta'] != '')
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Hora: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            '${doc['hrespuesta']}',
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Fecha: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            '${doc['frespuesta']}',
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          if (doc['frespuesta'] != '' &&
                              doc['hrespuesta'] != '')
                            const SizedBox(
                              height: 10,
                            ),
                          MyButton(text: 'Guardar', onTap: Actualizar)
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final collections = GetCollectionsServiceAnyClient();

    return StreamBuilder<QuerySnapshot>(
      stream: collections.getCollections('Mantenimiento'),
      builder: (context, snapshot) {
        final service = snapshot.data?.docs;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }
        if (snapshot.data == null) {
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
            drawer: const MyDrawer(),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: const Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Text(
                      'No hay Datos',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

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
          drawer: const MyDrawer(),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: ListView.builder(
            itemCount: service?.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = service![index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String docID = document.id;

              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).brightness == Brightness.light
                        ? WallpaperColor.veniceBlue().color
                        : WallpaperColor.iceberg().color,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset(
                                data['restecnico'] == ''
                                    ? 'assets/ojo_cerrado.png'
                                    : 'assets/ojo_abierto.png',
                                width: 50,
                                height: 50,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? WallpaperColor.white().color
                                    : WallpaperColor.black().color,
                                errorBuilder: (context, error, stackTrace) {
                                  return IconButton(
                                    highlightColor: Colors.transparent,
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/user.png',
                                      width: 121.8,
                                      height: 121.8,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 30, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize:
                                        MainAxisSize.min, // Add this line
                                    children: [
                                      Text(
                                        data['tipo'] != null &&
                                                data['tipo'].length > 15
                                            ? '${data['tipo'].substring(0, 15)}...'
                                            : data['tipo'] ?? '',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize:
                                        MainAxisSize.min, // Add this line
                                    children: [
                                      Text(
                                        data['descripcion'] != null &&
                                                data['descripcion'].length > 15
                                            ? '${data['descripcion'].substring(0, 15)}...'
                                            : data['descripcion'] ?? '',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.info),
                              onPressed: () {
                                Navigator.pushNamed(context, DetailsMantenimiento.routname, arguments: docID);
                              },
                              iconSize: 50,
                              tooltip: 'Add',
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? WallpaperColor.viking().color
                                  : WallpaperColor.blueZodiac().color,
                              alignment: Alignment.center,
                            ),
                            Text(
                              'Detalles',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
