import 'package:app_c3/pages/conciertos_page.dart';
import 'package:app_c3/pages/cantantes_page.dart';
import 'package:app_c3/pages/generos_page.dart';
import 'package:app_c3/widgets/app_drawer.dart';
import 'package:app_c3/widgets/fondo.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Fondo(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3199c9),
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF3199c9)),
        backgroundColor: Color(0xFF1b141a),
      ),
      drawer: AppDrawer(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bienvenidos',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3199c9),
              shadows: [
                Shadow(
                  offset: Offset(3.0, 3.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: [
              // Item 1: ConciertosPage
              _buildCarouselItem(
                context,
                'Conciertos',
                'Explora los próximos conciertos',
                'assets/img/conciertos_image.jpg',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConciertosPage()),
                  );
                },
              ),
              // Item 2: CantantesPage
              _buildCarouselItem(
                context,
                'Cantantes',
                'Descubre artistas y bandas',
                'assets/img/cantantes_image.jpg',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CantantesPage()),
                  );
                },
              ),
              // Item 3: GenerosPage
              _buildCarouselItem(
                context,
                'Géneros',
                'Explora diferentes estilos musicales',
                'assets/img/generos_image.jpg',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenerosPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, String title, String subtitle,
      String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20.0,
              left: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
