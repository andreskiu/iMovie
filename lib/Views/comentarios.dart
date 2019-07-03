import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:imovies/Blocs/comments_bloc.dart';
import 'package:imovies/Components/Comentarios/comentarioCard.dart';
import 'package:imovies/Components/Genericos/shimmer.dart';

class Comentarios extends StatelessWidget {
  Comentarios({@required this.movieId});
  final String movieId;
  final CommentBlocController commentsBloc =
      BlocProvider.getBloc<CommentBlocController>();

  @override
  Widget build(BuildContext context) {
    commentsBloc.getComments(movieId);
    return Scaffold(
        appBar: AppBar(
          title: Text("Comentarios"),
        ),
        body: Container(
          child: StreamBuilder(
            stream: commentsBloc.outComments,
            // initialData: initialData ,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return MyShimmer();//CircularProgressIndicator();
              if (snapshot.hasError) print("Ha ocurrido un error");

              return Container(
                child: ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ComentarioCard(
                      comentario: snapshot.data[index],
                    );
                  },
                ),
              );
            },
          ),
        ));
  }
}
