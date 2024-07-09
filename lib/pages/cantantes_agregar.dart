import 'package:app_c3/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CantantesAgregar extends StatefulWidget {
  const CantantesAgregar({super.key});

  @override
  State<CantantesAgregar> createState() => _CantantesAgregarState();
}

class _CantantesAgregarState extends State<CantantesAgregar> {
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController apodoCtrl = TextEditingController();
  TextEditingController edadCtrl = TextEditingController();
  TextEditingController nacionalidadCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime fecha_nacimiento = DateTime.now();
  final formatoFecha = DateFormat('dd-MM-yyyy');
  String genero = '';
  String concierto = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF3199c9)),
        title: Text(
          'Agregar cantante',
          style: TextStyle(color: Color(0xFF3199c9)),
        ),
        backgroundColor: Color(0xFF1b141a),
      ),
      backgroundColor: Color(0xFFdedbde),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(
                  label: Text('Nombre'),
                ),
                validator: (nombre) {
                  if (nombre == null || nombre.isEmpty) {
                    return 'Debes ingresar un nombre';
                  }
                  if (nombre.length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: apellidoCtrl,
                decoration: InputDecoration(
                  label: Text('Apellido'),
                ),
                validator: (apellido) {
                  if (apellido == null || apellido.isEmpty) {
                    return 'Debes ingresar un apellido';
                  }
                  if (apellido.length < 3) {
                    return 'El apellido debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: apodoCtrl,
                decoration: InputDecoration(
                  label: Text('Apodo'),
                ),
                validator: (apodo) {
                  if (apodo == null || apodo.isEmpty) {
                    return 'Debes ingresar un apodo';
                  }
                  if (apodo.length < 3) {
                    return 'El apodo debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: edadCtrl,
                decoration: InputDecoration(
                  label: Text('Edad'),
                ),
                validator: (edad) {
                  if (edad == null || edad.isEmpty) {
                    return 'Debes ingresar la edad';
                  }
                  if (int.tryParse(edad) == null) {
                    return 'La edad debe ser un número';
                  }
                  if (int.parse(edad) < 0) {
                    return 'La edad debe ser un número positivo';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: nacionalidadCtrl, //
                decoration: InputDecoration(
                  label: Text('Nacionalidad'),
                ),
                validator: (nacionalidad) {
                  if (nacionalidad == null || nacionalidad.isEmpty) {
                    return 'Debes ingresar una nacionalidad';
                  }
                  if (nacionalidad.length < 3) {
                    return 'La nacionalidad debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text('Fecha de nacimiento '),
                    Text(formatoFecha.format(fecha_nacimiento),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime.now(),
                                locale: Locale('es', 'ES'))
                            .then((fecha) {
                          setState(() {
                            fecha_nacimiento = fecha ?? fecha_nacimiento;
                          });
                        });
                      },
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: FirestoreService().generos(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Cargando géneros...');
                  } else {
                    var generos = snapshot.data!.docs;
                    return DropdownButtonFormField<String>(
                      value: genero == '' ? generos[0]['nombre'] : genero,
                      decoration: InputDecoration(labelText: 'Géneros'),
                      items: generos.map<DropdownMenuItem<String>>((genero) {
                        return DropdownMenuItem<String>(
                          child: Text(genero['nombre']),
                          value: genero['nombre'],
                        );
                      }).toList(),
                      onChanged: (generoSeleccionado) {
                        setState(() {
                          this.genero = generoSeleccionado!;
                        });
                      },
                    );
                  }
                },
              ),
              FutureBuilder(
                future: FirestoreService().conciertoss(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Cargando conciertos...');
                  } else {
                    var conciertos = snapshot.data!.docs;
                    return DropdownButtonFormField<String>(
                      value:
                          concierto == '' ? conciertos[0]['lugar'] : concierto,
                      decoration: InputDecoration(labelText: 'Conciertos'),
                      items:
                          conciertos.map<DropdownMenuItem<String>>((concierto) {
                        return DropdownMenuItem<String>(
                          child: Text(concierto['lugar']),
                          value: concierto['lugar'],
                        );
                      }).toList(),
                      onChanged: (conciertoSeleccionado) {
                        setState(() {
                          this.concierto = conciertoSeleccionado!;
                        });
                      },
                    );
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1b141a)),
                  child: Text(
                    'Agregar cantante',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirestoreService().cantanteAgregar(
                        nombreCtrl.text.trim(),
                        apellidoCtrl.text.trim(),
                        apodoCtrl.text.trim(),
                        int.parse(edadCtrl.text.trim()),
                        this.fecha_nacimiento,
                        nacionalidadCtrl.text.trim(),
                        this.genero,
                        this.concierto,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
