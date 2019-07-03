import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:imovies/Helpers/moviedb.dart';

class CommentBlocController extends BlocBase {
  CommentBlocController();

  // Titulo del Scaffold principal
  var _comments = PublishSubject<dynamic>();
  Stream<dynamic> get outComments => _comments.stream;
  Sink<dynamic> get inComments => _comments.sink;

  getComments(String id) async {
    inComments.add(await getMovieReviews(id));
  }

  @override
  void dispose() {
    _comments.close();
    super.dispose();
  }
}
