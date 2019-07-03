import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovies/Blocs/comments_bloc.dart';
import 'package:imovies/Blocs/movies_bloc.dart';
import 'package:imovies/Blocs/single_movie_bloc.dart';
import 'package:imovies/Components/Genericos/shimmer.dart';
import 'package:imovies/Components/movie_details/movie_specs.dart';
import 'package:imovies/Components/movie_details/movie_trailers.dart';
import 'package:imovies/Components/slivercontainer.dart';
import 'package:imovies/Helpers/moviedb.dart';
import 'package:imovies/Views/comentarios.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails(
      {@required
          this.movieBloc}); // evalual posibilidad de nor ecibir el bloc como parametro y recuperarlo de algun lado con getBloc(). El problema estaría en la marca de los favoritos

  final MovieBlocController movieBloc;

  // Lista de widgets para el armado de la pantalla
  final List lista = new List<Widget>();
  final BlocController moviesBloc = BlocProvider.getBloc<BlocController>();
  final CommentBlocController commentsBloc =
      BlocProvider.getBloc<CommentBlocController>();

  @override
  Widget build(BuildContext context) {
    var _movie;
    String _titulo;
    bool _visibility;
    return StreamBuilder(
        stream: movieBloc.outMovie,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return MyShimmer();//CircularProgressIndicator();
          if (snapshot.hasError) print("errorrrr");
          _movie = snapshot.data;
          String imagePath = (snapshot.data['poster_path'] == null
              ? snapshot.data['backdrop_path']
              : snapshot.data['poster_path']);
          print("DATOS PELICULA: " + snapshot.data.toString());
          print("PATH:" + imagePath);
          lista.add(new ListTile(
              title: Specs(
            imagePath: imagePath,
            titulo: snapshot.data['title'],
            voteCount: snapshot.data['vote_count'],
            voteAverage: snapshot.data['vote_average'].toDouble(),
            releaseDate: DateTime.parse(snapshot.data['release_date']),
          )));

          _titulo = snapshot.data['title'];
          lista.add(Container(
              padding: EdgeInsets.all(15),
              child: Text(snapshot.data['overview'],
                  style: Theme.of(context).textTheme.body1,
                  textAlign: TextAlign.justify)));

          lista.add(Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Trailers",
                style: Theme.of(context).textTheme.subhead,
              )));

          moviesBloc.setVideos(snapshot.data['id'].toString());
          return StreamBuilder(
              stream: moviesBloc.outVideosInfo,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData)
                  return MyShimmer();
                ;
                if (snapshot.hasError) print("errorrrr");

                snapshot.data.forEach((trailer) {
                  lista.add(ListTile(
                    title: Trailer(imagePath: imagePath, trailer: trailer),
                  ));
                });

                lista.add(FutureBuilder(
                  future: getMovieReviews(_movie['id'].toString()),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isEmpty)
                        _visibility = false;
                      else
                        _visibility = true;
                    } else
                      _visibility = false;

                    return Visibility(
                      maintainState: true,
                      maintainAnimation: true,
                      maintainSize: true,
                      visible: _visibility,
                      child: Center(
                          child: OutlineButton(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        color: Colors.black,
                        child: Text("Leer Comentarios",
                            style: Theme.of(context).textTheme.button),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Comentarios(
                                  movieId: _movie['id'].toString(),
                                ),
                              ));
                        },
                      )),
                    );
                  },
                ));

                return Scaffold(
                  body: new SliverContainer(
                    floatingActionButton: StreamBuilder(
                        stream: moviesBloc.outFavoriteMovies,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: MyShimmer());//CircularProgressIndicator());
                          if (snapshot.hasError) print("errorrrr");
                          return FloatingActionButton(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.favorite_border,
                                color: moviesBloc.esFavorita(_movie)
                                    ? Colors.pink
                                    : Colors.grey,
                                size: 30,
                              ),
                              onPressed: () {
                                print("FAVORITO: " + snapshot.data.toString());
                                if (moviesBloc.esFavorita(_movie)) {
                                  // si es favorita, la eliminamos
                                  moviesBloc.removeFavoritesMovies(_movie);
                                } else {
                                  //si no es favorita, la agregamos
                                  moviesBloc.addFavoritesMovies(_movie);
                                }
                              });
                        }),
                    expandedHeight: 200.0,
                    topScalingEdge: 100,
                    marginRight: 25,
                    slivers: <Widget>[
                      new SliverAppBar(
                        // title: Text(_titulo),
                        iconTheme: IconThemeData(color: Colors.white),
                        expandedHeight: 200.0,
                        pinned: true,
                        flexibleSpace: new FlexibleSpaceBar(
                          title: new Text(
                            _titulo,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white),
                          ),
                          background: CachedNetworkImage(
                            placeholder: (context, url) =>
                                MyShimmer(),//CircularProgressIndicator(), // no deberia verse ya que la imagen se descarga y cachea antes
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500/" + imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      new SliverList(
                          // aqui el contenido de la pagina
                          delegate: new SliverChildListDelegate(lista)),
                    ],
                  ),
                );
              });
        });
  }
}
