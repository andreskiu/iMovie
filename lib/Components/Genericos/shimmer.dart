import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  MyShimmer();
  @override
  Widget build(BuildContext context) {
    return 
        Center(
            child: Shimmer(
                gradient: LinearGradient(colors: [
                  Colors.grey[300],
                  Colors.white,
                  Colors.grey[300],
                  Colors.white,
                ]),
                period: Duration(milliseconds: 900),
                child: 
                Container(
                  color: Colors.white,
                ),
                ));
  }
}
