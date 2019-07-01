import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imovies/Blocs/main_bloc.dart';
import 'package:imovies/Blocs/movies_bloc.dart';

class HomeActions extends StatelessWidget {
  final BlocController bloc = BlocProvider.getBloc<BlocController>();

  _seleccion(int valor) {
    MainBlocController mainBloc = BlocProvider.getBloc<MainBlocController>();
    switch (valor) {
      case 1: //populares
        mainBloc.setTitle("Más Populares");
        bloc.getPopularMovies();
        break;
      case 2: // mejores rankeadas
      mainBloc.setTitle("Mejor Valoradas");
        bloc.getMostRatedMovies();
        break;
      default:
      mainBloc.setTitle("Más Populares");
        bloc.getPopularMovies();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return PopupMenuButton(
          onSelected: (value) {
            print("seleccionado");
            _seleccion(value);
          },
          icon: Icon(Icons.more_vert, size: 30),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 1,
                child: Text(
                    "Mas Populares"), // si ya hay invitados, no se deberia poder eliminar el evento, solo cancelar
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Mejor Valoradas"),
              ),
            ];
          },
        );
      },
    );
  }
}
