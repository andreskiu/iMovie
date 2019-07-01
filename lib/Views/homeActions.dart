import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imovies/Blocs/main_bloc.dart';
import 'package:imovies/Blocs/movies_bloc.dart';

class HomeActions extends StatelessWidget {
  final BlocController bloc = BlocProvider.getBloc<BlocController>();
  final MainBlocController mainBloc =
      BlocProvider.getBloc<MainBlocController>();

  _seleccion(int valor) {
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
    return StreamBuilder(
      stream: mainBloc.outSelected,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError) print("errorrrr");

        return PopupMenuButton(
          onSelected: (value) {
            print("seleccionado: " + value.toString());
            mainBloc.setSelected(value);
            _seleccion(value);
          },
          icon: Icon(Icons.more_vert, size: 30),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                enabled: snapshot.data == 1 ? false : true,
                value: 1,
                child: Text(
                  "Mas Populares",
                  style: snapshot.data == 1
                      ? Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.black38)
                      : Theme.of(context).textTheme.button,
                ),
              ),
              PopupMenuItem(
                enabled: snapshot.data == 2 ? false : true,
                value: 2,
                child: Text("Mejor Valoradas",
                    style: snapshot.data == 2
                        ? Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.black38)
                        : Theme.of(context).textTheme.button),
              ),
            ];
          },
        );
      },
    );
  }
}
