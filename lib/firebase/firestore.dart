import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computic_workers/shared/prefe_users.dart';

class GetCollectionsServices {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getCollections(String service, String client) {
    final services = _firestore
        .collection('Servicios')
        .where('servicio', isEqualTo: service)
        .where('cliente', isEqualTo: client)
        .snapshots();
    return services;
  }
}

class GetCollectionsServiceWithEmployee {
  final _firestore = FirebaseFirestore.instance;
  final _pref = PreferencesUser();

  Stream<QuerySnapshot> getCollections(String service) {
    final services = _firestore
        .collection('Servicios')
        .where('idtecnico', isEqualTo: _pref.ultimateUid)
        .where('servicio', isEqualTo: service)
        .snapshots();
    return services;
  }
}

class GetCollectionsServiceAnyClient {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getCollections(String service) {
    final services = _firestore
        .collection('Servicios')
        .where('servicio', isEqualTo: service)
        .snapshots();
    return services;
  }
}

class GetCollectionsEmployees {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getCollections() {
    final services = _firestore
        .collection('Users')
        .where('cargo', isEqualTo: 'employees')
        .snapshots();
    return services;
  }
}
