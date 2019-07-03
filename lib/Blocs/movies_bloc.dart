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
  var _movieFavoriteList = BehaviorSubject<dynamic>(seedValue: []);
  Stream<dynamic> get outFavoriteMovies => _movieFavoriteList.stream;
  Sink<dynamic> get inFavoriteMovies => _movieFavoriteList.sink;

  // getFavoritesMovies() async {
  //   inFavoriteMovies.add(await getMostRated());
  // }

  addFavoritesMovies(nueva) async {
    // print("Agregando nueva peli favorita: " + nueva.toString());
    List<dynamic> list = _movieFavoriteList.value;
    if (!esFavorita(nueva)) {
      list.add(nueva);
    }
    inFavoriteMovies.add(list);
    print("terminamos de añadir favorito: " + outMainMovies.length.toString());
  }

  removeFavoritesMovies(movie) async {
    // print("Agregando nueva peli favorita: " + nueva.toString());
    List<dynamic> list = _movieFavoriteList.value;
    print("ENTRAMOS AL REMOVE");
    bool salida = list.remove((movie));
    print("SALIDA: " + salida.toString());
    // print("LISTA DESPUES DE ELIMINAR: " + list.toString());
    inFavoriteMovies.add(list);
  }

// evalua si la pelicula ya se encuentra en la lista de favoritos
  bool esFavorita(movie) {
    List<dynamic> list = _movieFavoriteList.value;
    return list.any((pelicula) {
      return pelicula['id'] == movie['id'];
    });
  }

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
