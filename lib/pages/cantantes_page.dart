import 'package:app_c3/pages/cantantes_agregar.dart';
import 'package:app_c3/services/firestore_service.dart';
import 'package:app_c3/widgets/campo_cantante.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final formatoFecha = DateFormat('dd-MM-yyyy');

class CantantesPage extends StatefulWidget {
  const CantantesPage({super.key});

  @override
  State<CantantesPage> createState() => _CantantesPageState();
}

class _CantantesPageState extends State<CantantesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cantantes',
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          Icons.mic,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirestoreService().cantantes(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              //esperando datos
              return Center(child: CircularProgressIndicator());
            } else {
              //datos llegaron, mostrar en pantalla
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var cantante = snapshot.data!.docs[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          icon: MdiIcons.deleteOutline,
                          label: 'Borrar',
                          backgroundColor: Colors.black,
                          onPressed: (context) {
                            confirmarBorrado(context, cantante.id);
                          },
                        )
                      ],
                    ),
                    child: ListTile(
                      leading: (Icon(Icons.account_box_outlined)),
                      title: Text(
                          '${cantante['nombre']} ${cantante['apellido']} (${cantante['apodo']})'),
                      subtitle: Text('${cantante['nacionalidad']}'),
                      onLongPress: () {
                        mostrarInfoCantante(context, cantante);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (context) => CantantesAgregar());
          Navigator.push(context, route);
        },
      ),
    );
  }

  void confirmarBorrado(BuildContext context, String cantanteId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Borrado'),
          content: Text('¿Estás seguro de que quieres borrar este cantante?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Borrar'),
              onPressed: () {
                FirestoreService().cantanteBorrar(cantanteId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void mostrarInfoCantante(BuildContext context, cantante) {
  showBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 350,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              children: [
                CampoCantante(
                    dato: '${cantante['nombre']} ${cantante['apellido']}',
                    icono: Icons.add_reaction_outlined),
                CampoCantante(
                    dato: '${cantante['apodo']}',
                    icono: Icons.person_pin_circle),
                CampoCantante(
                    dato: formatoFecha
                            .format(cantante['fecha nacimiento'].toDate()) +
                        ' | ${cantante['edad']} años',
                    icono: Icons.calendar_month),
                CampoCantante(
                    dato: '${cantante['nacionalidad']}', icono: Icons.flag),
                CampoCantante(
                    dato: '${cantante['genero']}', icono: Icons.music_note),
                Spacer(),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.white),
                    child: Text('Cerrar'),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
