// hacer el stream para la modificacion del titulo, segun el orden que se elija para las peliculas
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class MainBlocController extends BlocBase {
  MainBlocController();

  // Stream main list
  var _title = BehaviorSubject<String>(seedValue: "Más Populares");
  Stream<String> get outTitle => _title.stream;
  Sink<String> get inTitle => _title.sink;

  setTitle(title){
    inTitle.add(title);
  }
}
