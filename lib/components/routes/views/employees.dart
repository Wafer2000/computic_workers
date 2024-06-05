import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic_workers/components/routes/tools/my_drawer.dart';
import 'package:computic_workers/style/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Employees extends StatefulWidget {
  static const String routname = '/employees';
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .where('cargo', isEqualTo: 'employees')
          .snapshots(),
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
              title: const Center(child: Text('Empleados')),
              actions: const [
                SizedBox(
                  width: 48,
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
            title: const Center(child: Text('Empleados')),
            actions: const [
              SizedBox(
                width: 48,
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
              Map<String, dynamic> user =
                  document.data() as Map<String, dynamic>;

              int edadf = 0;

              if (user['fnacimiento'] != '') {
                final DateFormat formatter = DateFormat('dd/MM/yyyy');
                final DateTime fechaNacimiento =
                    formatter.parse(user['fnacimiento']);
                final DateTime now = DateTime.now();
                final int years = now.year - fechaNacimiento.year;
                int edad;
                if (now.month < fechaNacimiento.month ||
                    (now.month == fechaNacimiento.month &&
                        now.day < fechaNacimiento.day)) {
                  edad = years - 1;
                } else {
                  edad = years;
                }
                edadf = edad;
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).brightness == Brightness.light
                        ? WallpaperColor.white().color
                        : WallpaperColor.iceberg().color,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.network(
                          user['fperfil'],
                          width: 150,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return IconButton(
                              highlightColor: Colors.transparent,
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/user.png',
                                width: 150,
                                height: 150,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Nombres: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center, // Add this line
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                '${user['nombres']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Apellidos: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center, // Add this line
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                '${user['apellidos']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Correo: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center, // Add this line
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                '${user['email']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Direccion: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center, // Add this line
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                '${user['direccion']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Celular: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center, // Add this line
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                '${user['celular']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Edad: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center, // Add this line
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                edadf == 0
                                ? 'Dato vacio'
                                : '${edadf.toString()} Años',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Text(
                              'Sexo: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.center, // Add this line
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // Add this line
                          children: [
                            Flexible(
                              child: Text(
                                '${user['sexo']}',
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center, // Add this line
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
