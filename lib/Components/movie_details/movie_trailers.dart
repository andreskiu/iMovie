import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovies/Blocs/movies_bloc.dart';
// import 'package:imovies/Blocs/movies_bloc.dart';

class Trailers extends StatelessWidget {
  Trailers({@required this.imagePath, @required this.id});

  final String imagePath;
  final String id;
  final BlocController moviesBloc = BlocProvider.getBloc<BlocController>();
  @override
  Widget build(BuildContext context) {
    // return ClipRRect(
    //     borderRadius: new BorderRadius.circular(15.0),
    //     child: Container(
    //         padding: EdgeInsets.only(top: 20),
    //         height: 200,
    //         width: 200 * 1.777777,
    //         child: imagePath == null
    //             ? Center(
    //                 child: Icon(Icons.play_circle_outline, size: 60),
    //               )
    //             : Stack(children: <Widget>[
    //                 CachedNetworkImage(
    //                   width: 200 * 1.77777,
    //                   height: 200,
    //                   placeholder: (context, url) =>
    //                       CircularProgressIndicator(),
    //                   imageUrl: "https://image.tmdb.org/t/p/w500/" + imagePath,
    //                   fit: BoxFit.cover,
    //                 ),
    //                 Center(
    //                   child: Icon(Icons.play_circle_outline,
    //                       color: Colors.white, size: 60),
    //                 )
    //               ])));
    moviesBloc.setVideos(id);
    return Container(
        height: 500,
        // width: 100,
        child: StreamBuilder(
            stream: moviesBloc.outVideosInfo,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              if (snapshot.hasError) print("errorrrr");
              print("SNAPSHOT: " + snapshot.data.toString());
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: ClipRRect(
                          borderRadius: new BorderRadius.circular(15.0),
                          child: Container(
                              padding: EdgeInsets.only(top: 20),
                              height: 200,
                              width: 200 * 1.777777,
                              child: imagePath == null
                                  ? Center(
                                      child: Icon(Icons.play_circle_outline,
                                          size: 60),
                                    )
                                  : Stack(children: <Widget>[
                                      CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/w500/" +
                                                imagePath,
                                        fit: BoxFit.cover,
                                      ),
                                      Center(
                                        child: Icon(Icons.play_circle_outline,
                                            color: Colors.white, size: 60),
                                      )
                                    ]))));
                },
              );
            }));
  }
}
