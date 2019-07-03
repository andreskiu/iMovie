import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovies/Components/Genericos/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Specs extends StatelessWidget {
  Specs(
      {@required this.imagePath,
      @required this.titulo,
      @required this.voteCount,
      @required this.voteAverage,
      @required this.releaseDate});

  final String imagePath;
  final String titulo;
  final int voteCount;
  final double voteAverage;
  final DateTime releaseDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        // foto y datos
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: new BorderRadius.circular(15.0),
              child: Container(
                  height: 200,
                  width: 200 * 0.666,
                  child: imagePath == null
                      ? Text(titulo)
                      : CachedNetworkImage(
                          placeholder: (context, url) =>
                              MyShimmer(),//CircularProgressIndicator(),
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500/" + imagePath,
                          fit: BoxFit.cover,
                        ))),
          Container(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("User Rating",
                      style: Theme.of(context).textTheme.subtitle),
                  // Text("estrellitas"),

                  Container(
                      padding: EdgeInsets.only(left: 30),
                      child: Column(children: <Widget>[
                        SmoothStarRating(
                          borderColor: Colors.grey,
                          starCount: 5,
                          color: Colors.orange,
                          allowHalfRating: false, // funciona al reves :S
                          rating: voteAverage / 2,
                        ),
                        Text((voteAverage / 2).toString() + " /5.00",
                            style: Theme.of(context)
                                .textTheme
                                .body2), // Dividimos en 2 porque tiene escala del 1 al 10
                        Text(voteCount.toString() + ' votes.',
                            style: Theme.of(context).textTheme.body2),
                      ])),
                  Text("Release Date",
                      style: Theme.of(context).textTheme.subtitle),
                  Container(
                      padding: EdgeInsets.only(left: 45),
                      alignment: Alignment.center,
                      child: Text(
                          DateFormat.MMMd()
                              .addPattern(", ")
                              .add_y()
                              .format(releaseDate),
                          style: Theme.of(context).textTheme.body2))
                ],
              ))
        ],
      ),
    );
  }
}
