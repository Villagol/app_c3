import 'package:app_c3/services/firestore_service.dart';
import 'package:app_c3/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatoFecha = DateFormat('dd-MM-yyyy');

class ConciertosPage extends StatefulWidget {
  const ConciertosPage({super.key});

  @override
  State<ConciertosPage> createState() => _ConciertosPageState();
}

class _ConciertosPageState extends State<ConciertosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF3199c9)),
        title: Row(
          children: [
            Icon(
              Icons.stadium,
              color: Color(0xFF3199c9),
            ),
            SizedBox(width: 10),
            Text(
              'Conciertos',
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
        child: StreamBuilder(
          stream: FirestoreService().conciertos(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var concierto = snapshot.data!.docs[index];
                  return ListTile(
                    leading: Icon(Icons.stadium),
                    title: Text('${concierto['lugar']}'),
                    subtitle: Text(
                        '${concierto['estado']} Capacidad: ${concierto['capacidad']}'),
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
