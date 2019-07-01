import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovies/Blocs/movies_bloc.dart';
import 'package:imovies/Blocs/single_movie_bloc.dart';
import 'package:imovies/Components/movie_details/movie_specs.dart';
import 'package:imovies/Components/movie_details/movie_trailers.dart';
import 'package:imovies/Components/slivercontainer.dart';
import 'package:imovies/Helpers/moviedb.dart';
import 'package:intl/intl.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails(
      {@required
          this.movieBloc}); // evalual posibilidad de nor ecibir el bloc como parametro y recuperarlo de algun lado con getBloc(). El problema estaría en la marca de los favoritos

  final MovieBlocController movieBloc;
  final List lista = new List<Widget>();
  final BlocController moviesBloc = BlocProvider.getBloc<BlocController>();

  @override
  Widget build(BuildContext context) {
    // movieBloc.setMovie("301528");
    // moviesBloc.setVideos("301528");
    return StreamBuilder(
        stream: movieBloc.outMovie,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.hasError) print("errorrrr");

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
                  return Center(child: CircularProgressIndicator());
                if (snapshot.hasError) print("errorrrr");

                snapshot.data.forEach((trailer) {
                  lista.add(ListTile(
                    title: Trailer(imagePath: imagePath, trailer: trailer),
                  ));
                });

                lista.add(Center(
                    child: OutlineButton(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                  color: Colors.black,
                  child: Text("Leer Comentarios",
                      style: Theme.of(context).textTheme.button),
                  onPressed: () {},
                )));

                return Scaffold(
                  body: new Builder(
                    builder: (context) => new SliverContainer(
                      floatingActionButton: new Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          // image: new DecorationImage(
                          //   image: new ExactAssetImage("assets/logo.png"),
                          //   fit: BoxFit.cover,
                          // ),
                          border: Border.all(color: Colors.black, width: 2.0),
                        ),
                      ),
                      expandedHeight: 200.0,
                      slivers: <Widget>[
                        new SliverAppBar(
                          iconTheme: IconThemeData(color: Colors.white),
                          expandedHeight: 200.0,
                          pinned: true,
                          flexibleSpace: new FlexibleSpaceBar(
                            title: new Text(
                              "Developer Libs",
                              style: TextStyle(color: Colors.white),
                            ),
                            // background: new Image.network(
                            //   snapshot.data[imagePath],
                            // ),
                          ),
                        ),
                        new SliverList(
                            // aqui el contenido de la pagina
                            delegate: new SliverChildListDelegate(lista)),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}