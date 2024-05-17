import 'package:computic_workers/components/routes/tools/my_drawer.dart';
import 'package:computic_workers/components/routes/tools/notifications.dart';
import 'package:computic_workers/components/routes/views/services/maintenance.dart';
import 'package:computic_workers/components/routes/views/services/shope.dart';
import 'package:computic_workers/style/global_colors.dart';
import 'package:flutter/material.dart';

class Services extends StatefulWidget {
  static const String routname = '/services';
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Center(child: Text('S e r v i c i o s')),
          actions: [Notifications()],
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? WallpaperColor.steelBlue().color
              : WallpaperColor.kashmirBlue().color,
        ),
        drawer: const MyDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        height: MediaQuery.sizeOf(context).width * 0.45,
                        child: FloatingActionButton.extended(
                          heroTag: 'tiendaTag',
                          onPressed: () {
                            Navigator.pushNamed(context, ShopeService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.store,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Tienda',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Text(
                                'Virtual',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.veniceBlue().color
                                  : WallpaperColor.iceberg().color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        height: MediaQuery.sizeOf(context).width * 0.45,
                        child: FloatingActionButton.extended(
                          heroTag: 'mantenimientoTag',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MaintenanceService.routname);
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.laptop,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Mantenimiento de',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Text(
                                'Computadores',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.veniceBlue().color
                                  : WallpaperColor.iceberg().color,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        height: MediaQuery.sizeOf(context).width * 0.45,
                        child: FloatingActionButton.extended(
                          heroTag: 'capacitacionTag',
                          onPressed: () {
                            /*Navigator.pushNamed(
                                context, TrainingService.routname);*/
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.school,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Capacitacion de',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Text(
                                'Soluciones Tecnológicas',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.veniceBlue().color
                                  : WallpaperColor.iceberg().color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        height: MediaQuery.sizeOf(context).width * 0.45,
                        child: FloatingActionButton.extended(
                          heroTag: 'creacionappTag',
                          onPressed: () {
                            /*Navigator.pushNamed(
                                context, CreationService.routname);*/
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.code,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Creacion de',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Text(
                                'Aplicaciones',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.veniceBlue().color
                                  : WallpaperColor.iceberg().color,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        height: MediaQuery.sizeOf(context).width * 0.45,
                        child: FloatingActionButton.extended(
                          heroTag: 'creacionwebTag',
                          onPressed: () {
                            /*Navigator.pushNamed(
                                context, CreationService.routname);*/
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.web,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Creacion de',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Text(
                                'Paginas Web',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.veniceBlue().color
                                  : WallpaperColor.iceberg().color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        height: MediaQuery.sizeOf(context).width * 0.45,
                        child: FloatingActionButton.extended(
                          heroTag: 'instalacioncamarasTag',
                          onPressed: () {
                            /*Navigator.pushNamed(
                                context, FacilityService.routname);*/
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.videocam,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Instalacion de',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Text(
                                'Camaras',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.veniceBlue().color
                                  : WallpaperColor.iceberg().color,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        height: MediaQuery.sizeOf(context).width * 0.45,
                        child: FloatingActionButton.extended(
                          heroTag: 'instalacioncercadoTag',
                          onPressed: () {
                            /*Navigator.pushNamed(
                                context, FacilityService.routname);*/
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fence,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Instalacion de',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Text(
                                'Cercado Electrico',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.veniceBlue().color
                                  : WallpaperColor.iceberg().color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        height: MediaQuery.sizeOf(context).width * 0.45,
                        child: FloatingActionButton.extended(
                          heroTag: 'alquilerTag',
                          onPressed: () {
                            /*Navigator.pushNamed(context, RentService.routname);*/
                          },
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.device_hub,
                                color: Theme.of(context).colorScheme.primary,
                                size: 35,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Alquiler de',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Text(
                                'Equipos Tecnológicos',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? WallpaperColor.veniceBlue().color
                                  : WallpaperColor.iceberg().color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
