import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovies/Blocs/movies_bloc.dart';
import 'package:imovies/Blocs/single_movie_bloc.dart';
import 'package:imovies/Components/Genericos/shimmer.dart';
import 'package:imovies/Views/movieDetails.dart';

class MovieCard extends StatelessWidget {
  MovieCard({@required this.movie});
  final dynamic movie;
  final bloc = new MovieBlocController();
  final moviesBloc = BlocProvider.getBloc<BlocController>();
  _viewDetails(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetails(movieBloc: bloc),
        ));
  }

  @override
  Widget build(BuildContext context) {
    bloc.setMovie(movie);
    return StreamBuilder(
        stream: bloc.outMovie,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) //return CircularProgressIndicator();
            return MyShimmer();

          if (snapshot.hasError) print("errorrrr");
          String imagePath = (snapshot.data['poster_path'] == null
              ? snapshot.data['backdrop_path']
              : snapshot.data['poster_path']);
          return //MyShimmer();
              GestureDetector(
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
                                        MyShimmer(), //CircularProgressIndicator(),
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w500/" +
                                            imagePath,
                                    fit: BoxFit.cover,
                                  ))),
                    StreamBuilder(
                        stream: moviesBloc.outFavoriteMovies,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return MyShimmer(); //CircularProgressIndicator();
                          }
                          if (snapshot.hasError) print("errorrrr");
                          return IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: moviesBloc.esFavorita(movie)
                                  ? Colors.pink
                                  : Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              if (moviesBloc.esFavorita(movie)) {
                                //eliminamos de la lista de favoritos
                                moviesBloc.removeFavoritesMovies(movie);
                              } else {
                                moviesBloc.addFavoritesMovies(movie);
                              }
                            },
                          );
                        })
                  ]));
        });
  }
}
