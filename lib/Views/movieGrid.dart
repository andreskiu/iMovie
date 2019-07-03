import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imovies/Components/Genericos/shimmer.dart';
import 'package:imovies/Views/movieCard.dart';

class MovieGrid extends StatelessWidget {
  MovieGrid({@required this.stream});

  final Stream<dynamic> stream;
  @override
  Widget build(BuildContext context) {
    print("STREAM: " + stream.toString());
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return MyShimmer();
          if (snapshot.hasError)
            print("Ups, ocurrio un error:" + snapshot.error.toString());

          if (snapshot.data.isEmpty)
            return Center(
              child: Text("Aqui no hay nada :(",
                  style: Theme.of(context).textTheme.button),
            );
          return OrientationBuilder(builder: (context, orientation) {
            return GridView.count(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.666,
                crossAxisCount: orientation == Orientation.portrait ? 2 : 5,
                children: List.generate(snapshot.data.length, (index) {
                  return MovieCard(movie: snapshot.data[index]);
                }));
          });
        });
  }
}
