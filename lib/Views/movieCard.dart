import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovies/Blocs/single_movie_bloc.dart';
import 'package:imovies/Views/movieDetails.dart';

// imagen en ['backdrop_path']

// buscar imagenes en "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"

class MovieCard extends StatelessWidget {
  MovieCard({@required this.movie});
  final dynamic movie;
  final bloc = new MovieBlocController();

  _viewDetails(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetails(movieBloc: bloc),
        ));
  }

  @override
  Widget build(BuildContext context) {
    bool _favorite = false;
    bloc.setMovie(movie);
    bloc.outFavorite.listen((valor) {
      _favorite = valor;
    });
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
                              )

                        // Image.network(
                        //     "https://image.tmdb.org/t/p/w500/" + imagePath,
                        //     fit: BoxFit.cover)
                        // alignment: Alignment.center,
                        )),
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: _favorite
                        ? Colors.pink
                        : Colors.white, // cambiar según sea favorito o no
                    size: 30,
                  ),
                  onPressed: () {
                    print('caqmbiando favorito: ' + _favorite.toString());
                    bloc.setFavorite(!_favorite);
                  }, // esto cambia el valor bien, pero no refresca la tarjeta, ya que no se modifica el stream que la creó
                )
              ]));
        });
  }
}
