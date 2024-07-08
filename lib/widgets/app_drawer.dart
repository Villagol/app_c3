import 'package:app_c3/pages/conciertos_page.dart';
import 'package:app_c3/pages/generos_page.dart';
import 'package:app_c3/services/autentificacion_google.dart';
import 'package:flutter/material.dart';
import 'package:app_c3/pages/cantantes_page.dart';
import 'package:app_c3/pages/home.dart';
import 'package:app_c3/pages/login.dart';
import 'package:app_c3/pages/perfil_page.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppDrawer extends StatelessWidget {
  final AutenticacionGoogle _authService = AutenticacionGoogle();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1b141a),
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Color(0xFF3199c9),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(MdiIcons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.accountMusic),
              title: Text('Cantantes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CantantesPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.stadium),
              title: Text('Conciertos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConciertosPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.music),
              title: Text('Generos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenerosPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.account),
              title: Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PerfilPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.accountOff),
              title: Text('Cerrar Sesión'),
              onTap: () async {
                await _authService.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
