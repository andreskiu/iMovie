import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class MovieBlocController extends BlocBase {
  MovieBlocController();
  var _movie = BehaviorSubject<dynamic>(seedValue: null);

  Observable<dynamic> get outMovie => _movie.stream;
  Sink<dynamic> get inMovie => _movie.sink;

  setMovie(movie) {
    inMovie.add(movie);
  }

  @override
  void dispose() {
    _movie.close();
    super.dispose();
  }
}
