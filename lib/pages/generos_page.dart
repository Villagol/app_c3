import 'package:app_c3/services/firestore_service.dart';
import 'package:app_c3/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GenerosPage extends StatefulWidget {
  const GenerosPage({super.key});

  @override
  State<GenerosPage> createState() => _GenerosPageState();
}

class _GenerosPageState extends State<GenerosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF3199c9)),
        title: Row(
          children: [
            Icon(
              Icons.music_note,
              color: Color(0xFF3199c9),
            ),
            SizedBox(width: 10),
            Text(
              'Géneros',
              style: TextStyle(color: Color(0xFF3199c9)),
            ),
          ],
        ),
        backgroundColor: Color(0xFF1b141a),
      ),
      drawer: AppDrawer(),
      backgroundColor: Color(0xFFdedbde),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: FirestoreService().generos(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var genero = snapshot.data!.docs[index];
                  // Separar ejemplos por coma y eliminar espacios alrededor
                  List<String> ejemplos = (genero['ejemplos'] as String)
                      .split(',')
                      .map((e) => e.trim())
                      .toList();
                  return ListTile(
                    leading: Icon(Icons.library_music),
                    title: Text('${genero['nombre']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Cantidad de artistas: ${genero['cantidad de artistas']}'),
                        SizedBox(height: 4),
                        Text('Ejemplos:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        // Mostrar cada ejemplo en una nueva línea
                        for (var ejemplo in ejemplos) Text('- $ejemplo'),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
