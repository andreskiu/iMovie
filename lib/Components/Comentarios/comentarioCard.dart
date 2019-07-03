import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComentarioCard extends StatelessWidget {
  const ComentarioCard({Key key, @required this.comentario}) : super(key: key);
  final dynamic comentario;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    comentario["author"],
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Text(
                      DateFormat
                              .d() // utilizo fecha de hoy ya que la fecha no viene informada en el review
                          .add_MMM()
                          .add_y()
                          .format(DateTime.now()),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: Colors.black45))
                ],
              )),
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
            child: Text(comentario["content"],
                style: Theme.of(context).textTheme.body1),
          )
        ],
      ),
    );
  }
}
