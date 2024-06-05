// ignore_for_file: non_constant_identifier_names, unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic_workers/components/routes/tools/my_drawer.dart';
import 'package:computic_workers/components/routes/tools/services/admin/details_mantenimiento.dart';
import 'package:computic_workers/firebase/firestore.dart';
import 'package:computic_workers/shared/prefe_users.dart';
import 'package:computic_workers/style/global_colors.dart';
import 'package:flutter/material.dart';

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
                                data['total'] == ''
                                    ? data['tecnico'] == ''
                                        ? 'assets/ojo_cerrado.png'
                                        : 'assets/ojo_abierto.png'
                                    : 'assets/lograr.png',
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
                                _pref.detailsId = docID;
                                Navigator.pushNamed(
                                    context, DetailsMaintenance.routname);
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
