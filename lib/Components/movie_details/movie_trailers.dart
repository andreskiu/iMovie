import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovies/Blocs/movies_bloc.dart';
import 'package:imovies/Components/Genericos/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:imovies/Blocs/movies_bloc.dart';

class Trailer extends StatelessWidget {
  Trailer({@required this.imagePath, @required this.trailer});

  final String imagePath;
  final dynamic trailer;
  // final BlocController moviesBloc = BlocProvider.getBloc<BlocController>();

  _openYoutube() async {
    print("hicimos click");
    if (trailer['site'] == 'YouTube') {
      //abrimos youtube

      print("ESTARIAMOS ABRIENDO YOUTUBE, ID: " + trailer['key']);
      String url = "https://www.youtube.com/watch?v=" + trailer['key'];
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch Video';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: new BorderRadius.circular(15.0),
        child: GestureDetector(
            onTap: _openYoutube,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: 200,
              width: 200 * 1.777777,
              child: imagePath == null
                  ? Center(
                      child: Icon(Icons.play_circle_outline, size: 60),
                    )
                  : Stack(children: <Widget>[
                      CachedNetworkImage(
                        width: 200 * 1.77777,
                        height: 200,
                        placeholder: (context, url) =>
                            MyShimmer(),//CircularProgressIndicator(),
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500/" + imagePath,
                        fit: BoxFit.cover,
                      ),
                      Center(
                        child: Icon(Icons.play_circle_outline,
                            color: Colors.white, size: 60),
                      )
                    ]),
            )));
  }
}
