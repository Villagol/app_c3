import 'package:app_c3/pages/login.dart';
import 'package:app_c3/services/autentificacion_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilPage extends StatelessWidget {
  final AutenticacionGoogle _authService = AutenticacionGoogle();

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        iconTheme: IconThemeData(color: Color(0xFF3199c9)),
        backgroundColor: Color(0xFF1b141a),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: user != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.photoURL ?? ''),
                    ),
                    SizedBox(height: 20),
                    Text(
                      user.displayName ?? 'Nombre no disponible',
                      style: TextStyle(
                        color: Color(0xFF3199c9),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user.email ?? 'Correo no disponible',
                      style: TextStyle(
                        color: Color(0xFF3199c9),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3199c9),
                        foregroundColor: Color(0xFF1b141a),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () async {
                        await _authService.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        'Cerrar Sesión',
                        style: TextStyle(
                          color: Color(0xFFdedbde),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )
              : Text(
                  'No hay usuario autenticado',
                  style: TextStyle(
                    color: Color(0xFF3199c9),
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
