import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    print("SE ESTA CONSTRUYENDO LA LINEA ESTA. TITULO: " + titulo);
    return Container(
      padding: EdgeInsets.only(bottom: 30, top: 30),
      child: Row(
        // foto y datos
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
                              CircularProgressIndicator(),
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500/" + imagePath,
                          fit: BoxFit.cover,
                        ))),
          Column(
            children: <Widget>[
              Text("User Rating"),
              Text("estrellitas"),
              Text((voteAverage / 2).toString() +
                  " /5.00"), // Dividimos en 2 porque tiene escala del 1 al 10
              Text(voteCount.toString() + ' votes.'),
              Text("Release Date"),
              Text(DateFormat.MMMd()
                  .addPattern(", ")
                  .add_y()
                  .format(releaseDate))
            ],
          )
        ],
      ),
    );
  }
}
