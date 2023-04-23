import 'dart:async';

import 'package:flutter/material.dart';



class PeedCard extends StatelessWidget {
  final String name;
  final String imgSrc;
  final double imgSize;
  final String profileImgSrc;
  final FutureOr<void> Function() onTap1;
  final FutureOr<void> Function() onTap2;
  final FutureOr<void> Function() onTap3;
  const PeedCard({Key? key, required this.name, required this.imgSrc, required this.imgSize, required this.profileImgSrc, required this.onTap1, required this.onTap2, required this.onTap3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      elevation: 10.0,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(this.profileImgSrc),
                ),
                Text(this.name)
              ],
            ),
            Container(
              width: this.imgSize,
              height: this.imgSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(this.imgSrc),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: this.onTap1, child: Text("Tap1", style: TextStyle())),
                TextButton(onPressed: this.onTap2, child: Text("Tap2", style: TextStyle())),
                TextButton(onPressed: this.onTap3, child: Text("Tap3", style: TextStyle())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
