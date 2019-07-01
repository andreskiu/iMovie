import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:imovies/Helpers/moviedb.dart';
import 'package:rxdart/rxdart.dart';

class MovieBlocController extends BlocBase {
  MovieBlocController();

  // movie
  var _movie = BehaviorSubject<dynamic>(seedValue: null);
  // Observable<dynamic> get outMoviee => _movie.stream;
  Observable<dynamic> get outMovie => _movie.stream;
  Sink<dynamic> get inMovie => _movie.sink;

  setMovie(movie) {
    inMovie.add(movie);
  }

  var _favorite = BehaviorSubject<bool>(seedValue: false);
  Stream<bool> get outFavorite => _favorite.stream;
  Sink<bool> get inFavorite => _favorite.sink;

  setFavorite(movie) {
    inFavorite.add(movie);
  }

  @override
  void dispose() {
    _movie.close();
    super.dispose();
  }
}
