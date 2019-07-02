import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imovies/Views/movieCard.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';

class MovieGrid extends StatelessWidget {
  MovieGrid({@required this.stream});

  final Stream<dynamic> stream;
  @override
  Widget build(BuildContext context) {
    // final BlocController bloc = BlocProvider.getBloc<BlocController>();
    // bloc.getMovies();
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return OrientationBuilder(builder: (context, orientation) {
            return GridView.count(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.666,
                crossAxisCount: orientation == Orientation.portrait ? 2 : 5,
                children: List.generate(snapshot.data.length, (index) {
                  return MovieCard(
                      movie: snapshot
                          .data[index]);
                }));
          });
        });
  }
}
