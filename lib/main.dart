import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:imovies/Views/homeActions.dart';
import 'package:imovies/Views/movieGrid.dart';
import 'package:imovies/Blocs/movies_bloc.dart';
import 'Blocs/comments_bloc.dart';
import 'Blocs/main_bloc.dart';
import 'Blocs/movies_bloc.dart';
import 'Blocs/single_movie_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        //add yours BLoCs controlles
        blocs: [
          Bloc((i) => BlocController()),
          Bloc((i) => MainBlocController()),
          Bloc((i) => MovieBlocController()),
          Bloc((i) => CommentBlocController()),
        ],
        //your main widget
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
                // Lineas de texto
                body1: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                // other info
                body2: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                subhead: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                subtitle: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                button: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = List<Widget>();
  List<Widget> _actions = [HomeActions()];

  final MainBlocController mainBloc =
      BlocProvider.getBloc<MainBlocController>();

  final BlocController moviesBloc = BlocProvider.getBloc<BlocController>();
  String _titulo = "iMovie";

  @override
  void initState() {
    mainBloc.outTitle.listen((valor) {
      _titulo = valor;
    });
    //cargamos las peliculas populares para el inicio de la app
    moviesBloc.getPopularMovies();
    // agregamos pantalla principal
    _children.add(new MovieGrid(stream: moviesBloc.outMainMovies));

    // agregamos pantalla de favoritos
    _children.add(new MovieGrid(stream: moviesBloc.outFavoriteMovies));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: mainBloc.outTitle,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_titulo),
              actions: _actions,
            ),
            body: _children[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  title: new Text('Inicio'),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), title: Text('Favoritos'))
              ],
            ),
          );
        });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        _actions = [HomeActions()];
      } else {
        _actions = null;
      }
    });
  }
}
