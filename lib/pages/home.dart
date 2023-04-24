import 'package:ejercicio_api/provides/provide_movies.dart';
import 'package:ejercicio_api/widgets/lista_slider.dart';
import 'package:ejercicio_api/widgets/tarjetas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Peliculas',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // Tarjetas
          Tarjetas(movies: provider.nowPlaying),

          // Slider Peliculas
          ListaSlider(
            movies: provider.populares,
            title: 'Populares',
            nextPage: () => provider.getPopurales(),
          ),

          ListaSlider(
            movies: provider.topRated,
            title: 'Rankings Top',
            nextPage: () => provider.getTopRated(),
          ),

          ListaSlider(
            movies: provider.upcoming,
            title: 'Por venir',
            nextPage: () => provider.getUpComing(),
          )
        ],
      )),
    );
  }
}
