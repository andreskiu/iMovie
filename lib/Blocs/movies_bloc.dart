import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:imovies/Helpers/moviedb.dart';
import 'package:rxdart/rxdart.dart';

class BlocController extends BlocBase {
  BlocController();

  // Stream main list
  var _movieMainList = BehaviorSubject<dynamic>(seedValue: null);
  Stream<dynamic> get outMainMovies => _movieMainList.stream;
  Sink<dynamic> get inMainMovies => _movieMainList.sink;

  getPopularMovies() async {
    print("Por añadir items");
    inMainMovies.add(await getMostPopular());
    print("terminamos de añadir items: " + outMainMovies.length.toString());
  }

  getMostRatedMovies() async {
    print("Por añadir items");
    inMainMovies.add(await getMostRated());
    print("terminamos de añadir items: " + outMainMovies.length.toString());
  }

// Stream favorite list
  var _movieFavoriteList = BehaviorSubject<dynamic>(seedValue: null);
  Stream<dynamic> get outFavoriteMovies => _movieFavoriteList.stream;
  Sink<dynamic> get inFavoriteMovies => _movieFavoriteList.sink;

  getFavoritesMovies() async {
    print("Por añadir items");
    inFavoriteMovies.add(await getMostRated());
    print("terminamos de añadir items: " + outMainMovies.length.toString());
  }

  // // Stream movie
  // var _movie = BehaviorSubject<dynamic>(seedValue: null);
  // Stream<dynamic> get outMovie => _movie.stream;
  // Sink<dynamic> get inMovie => _movie.sink;

  // loadMovie(dynamic movie){
  //   inMovie.add(movie);
  // }

// stream videos de una pelicula
  var _videos = PublishSubject<dynamic>();
  Observable<dynamic> get outVideosInfo => _videos.stream;
  Sink<dynamic> get inVideosInfo => _videos.sink;

  setVideos(idMovie) async {
    print("ID DE LA PELICULA" + idMovie);
    inVideosInfo.add(await getMovieVideos(idMovie));
  }

//dispose will be called automatically by closing its streams
  @override
  void dispose() {
    // _counterController.close();
    _movieMainList.close();
    _movieFavoriteList.close();
    _videos.close();
    super.dispose();
  }
}
