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
    moviesBloc.setVideos("301528");
    return StreamBuilder(
        stream: movieBloc.outMovie.mergeWith([moviesBloc.outVideosInfo]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.hasError) print("errorrrr");
          lista.add(new ListTile(
            title: Text(snapshot.data.toString()),
          )
          );
          // String imagePath = (snapshot.data['poster_path'] == null
          //     ? snapshot.data['backdrop_path']
          //     : snapshot.data['poster_path']);
          // print("DATOS PELICULA: " + snapshot.data.toString());
          // print("PATH:" + imagePath);
          // lista.add(new ListTile(
          //     title: Specs(
          //   imagePath: imagePath,
          //   titulo: snapshot.data['title'],
          //   voteCount: snapshot.data['vote_count'],
          //   voteAverage: snapshot.data['vote_average'].toDouble(),
          //   releaseDate: DateTime.parse(snapshot.data['release_date']),
          // )));

          // lista.add(Container(
          //     padding: EdgeInsets.only(top: 300, bottom: 30),
          //     child: Text(snapshot.data['overview'])));
          // lista.add(Text("Trailers"));
          // getMovieVideos(snapshot.data['id'].toString()).then((info) {
          //   info.forEach((movie) {
          //     print("AGREGANDO TRAILER");
          //     lista.add(new ListTile(
          //       title: Trailers(
          //           imagePath: snapshot.data['backdrop_path'],id: movie['id'],), //Text(movie["name"]),
          //     ));
          //   });
          //   lista.add(FlatButton(
          //     child: Text("Comentarios"),
          //     onPressed: () {},
          //   ));
          // });

          print("Longitud de la lista: " + lista.length.toString());
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
  }
}

// Center(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
// Row(
//   // foto y datos
//   children: <Widget>[
//     ClipRRect(
//         borderRadius: new BorderRadius.circular(15.0),
//         child: Container(
//             height: 200,
//             width: 200 * 0.666,
//             child: imagePath == null
//                 ? Text(snapshot.data['title'])
//                 : CachedNetworkImage(
//                     placeholder: (context, url) =>
//                         CircularProgressIndicator(),
//                     imageUrl:
//                         "https://image.tmdb.org/t/p/w500/" +
//                             imagePath,
//                     fit: BoxFit.cover,
//                   )

//             // Image.network(
//             //     "https://image.tmdb.org/t/p/w500/" + imagePath,
//             //     fit: BoxFit.cover)
//             // alignment: Alignment.center,
//             )),
//     Column(
//       children: <Widget>[
//         Text("User Rating"),
//         Text("estrellitas"),
//         Text((snapshot.data['vote_average'] / 2)
//                 .toString() +
//             " /5.00"), // Dividimos en 2 porque tiene escala del 1 al 10
//         Text(snapshot.data['vote_count'].toString() +
//             ' votes.'),
//         Text("Release Date"),
//         Text(DateFormat.MMMd()
//             .addPattern(", ")
//             .add_y()
//             .format(DateTime.parse(
//                 snapshot.data['release_date'])))
//       ],
//     )
//   ],
// ),
//                       Text(snapshot.data['overview']),
//                       Text("Trailers"),
//                       Text("Trailer 1"),
//                       Text("Trailer 2"),
//                       Text("Trailer 3"),
//                       FlatButton(
//                         child: Text("Comentarios"),
//                         onPressed: () {},
//                       )
//                     ],
//                   ),
//                 ),
//               ),

// ================================ignorar

// Widget _buildActions() {
//     Widget profile = new GestureDetector(
//       onTap: () => (){},
//       child: new Container(
//         height: 30.0,
//         width: 45.0,
//         decoration: new BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.grey,
//           image: new DecorationImage(
//             image: new ExactAssetImage("assets/logo.png"),
//             fit: BoxFit.cover,
//           ),
//           border: Border.all(color: Colors.black, width: 2.0),
//         ),
//       ),
//     );

// double scale;
// if (scrollController.hasClients) {
//   scale = scrollController.offset / 300;
//   scale = scale * 2;
//   if (scale > 1) {
//     scale = 1.0;
//   }
// } else {
//   scale = 0.0;
// }

// return new Transform(
//   transform: new Matrix4.identity()..scale(scale, scale),
//   alignment: Alignment.center,
//   child: profile,
// );
//  }
