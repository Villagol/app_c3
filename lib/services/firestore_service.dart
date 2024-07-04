import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //obtener lista de cantantes
  Stream<QuerySnapshot> cantantes() {
    return FirebaseFirestore.instance
        .collection('cantantes')
        .orderBy('apodo')
        .snapshots();
  }

  //obtener lista de conciertos
  Future<QuerySnapshot> generos() {
    return FirebaseFirestore.instance.collection('generos').get();
  }

  //Insertar cantante en bd
  Future<void> cantanteAgregar(String nombre, String apellido, String apodo,
      int edad, DateTime fecha_nacimiento, String nacionalidad, String genero) {
    return FirebaseFirestore.instance.collection('cantantes').doc().set({
      'nombre': nombre,
      'apellido': apellido,
      'apodo': apodo,
      'edad': edad,
      'nacionalidad': nacionalidad,
      'fecha nacimiento': fecha_nacimiento,
      'genero': genero,
    });
  }

  //Borrar cantante
  Future<void> cantanteBorrar(String docId) {
    return FirebaseFirestore.instance
        .collection('cantantes')
        .doc(docId)
        .delete();
  }
}
