import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/MedigoUser.dart';
import '../models/Doctor.dart';
import '../models/Appointment.dart';

class UserDatabaseService {
  
  final Firestore _db = Firestore.instance;

  Stream<MedigoUser> streamUser(String id) {
    return _db.collection('users').document(id).snapshots().map(
      (snapshot) => MedigoUser.fromFirestore(snapshot)
    );
  }

  Future<MedigoUser> getUser(String id) async {
    DocumentSnapshot snapshot = await _db.collection('users').document(id).get();
    print(snapshot.data);
    return MedigoUser.fromFirestore(snapshot);
  }

  Stream<Doctor> streamDoctor(String id) {
    return _db.collection('doctors').document(id).snapshots().map(
      (snapshot) => Doctor.fromFirestore(snapshot)
    );
  }

  Future<Doctor> getDoctor(String id) async {
    DocumentSnapshot snapshot = await _db.collection('doctors').document(id).get();
    print(snapshot.data);
    return Doctor.fromFirestore(snapshot);
  }

  Stream<Appointment> streamAppointment(String id) {
    return _db.collection('appointments').document(id).snapshots().map(
      (snapshot) => Appointment.fromFirestore(snapshot)
    );
  }

  Future<Appointment> getAppointment(String id) async {
    DocumentSnapshot snapshot = await _db.collection('appointments').document(id).get();
    print(snapshot.data);
    return Appointment.fromFirestore(snapshot);
  }

}