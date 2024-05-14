// ignore_for_file: must_be_immutable

import 'package:computic_workers/style/global_colors.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  int count = 0;
  Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(
        children: [
          const Icon(
            Icons.notifications,
            size: 48,
          ),
          if (count > 0)
            Positioned(
              top: 1,
              right: -3,
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: WallpaperColor.blueZodiac().color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.light
                        ? WallpaperColor.steelBlue().color
                        : WallpaperColor.kashmirBlue().color,
                    width: 3,
                  ),
                ),
                constraints: const BoxConstraints(
                  minWidth: 23,
                  minHeight: 23,
                ),
                child: Center(
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                        color: WallpaperColor.baliHai().color,
                        fontSize: 11,
                        fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
      color: WallpaperColor.blueZodiac().color,
      onPressed: () {
        // Acción al presionar el icono de notificaciones
      },
    );
  }
}
