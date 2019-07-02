import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovies/Blocs/single_movie_bloc.dart';
import 'package:imovies/Views/movieDetails.dart';

// imagen en ['backdrop_path']

// buscar imagenes en "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"

class MovieCard extends StatelessWidget {
  MovieCard({@required this.movie});
  final dynamic movie;
  // static final bloc = new MovieBlocController();
  final MovieBlocController bloc = BlocProvider.getBloc<MovieBlocController>();
  // bool _favorite;
  _viewDetails(BuildContext context) {
    // enviamos el valor del favorito para que construya el floatingButton
    // bloc.setFavorite(_favorite);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetails(movieBloc: bloc),
        ));
  }

  @override
  Widget build(BuildContext context) {
    bloc.setMovie(movie);
    // bloc.outFavorite.listen((valor) {
    //   _favorite = valor;
    // });
    return StreamBuilder(
        stream: bloc.outMovie,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.hasError) print("errorrrr");
          String imagePath = (snapshot.data['poster_path'] == null
              ? snapshot.data['backdrop_path']
              : snapshot.data['poster_path']);
          //print('reconstruida: ' + snapshot.data['title']);
          return GestureDetector(
              onTap: () {
                print("presionado: " + snapshot.data['title']);
                _viewDetails(context);
              },
              child: Stack(alignment: Alignment.bottomRight, children: [
                Center(
                    child: Container(
                        child: imagePath == null
                            ? Text(snapshot.data['title'])
                            : CachedNetworkImage(
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                imageUrl: "https://image.tmdb.org/t/p/w500/" +
                                    imagePath,
                                fit: BoxFit.cover,
                              ))),
                StreamBuilder(
                    stream: bloc.outFavorite,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        // _favorite = false;
                        // bloc.setFavorite(
                        //     false); // inicializamos aqui y no en el bloc porque sino se borra el valor al retornar
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) print("errorrrr");
                      return IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: snapshot.data ? Colors.pink : Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          print('cambiando favorito: ' + snapshot.data.toString());
                          // _favorite = !snapshot.data;
                          bloc.setFavorite(!snapshot.data);
                        }, // esto cambia el valor bien, pero no refresca la tarjeta, ya que no se modifica el stream que la creó
                      );
                    })
              ]));
        });
  }
}
