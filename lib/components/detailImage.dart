import 'package:flutter/material.dart';

class DetailImage extends StatelessWidget {
  final String src;
  const DetailImage({Key? key, required this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewSize = MediaQuery.of(context).size;
    return Container(
      width: _viewSize.width,
      // height: 300.0,
      //   decoration: BoxDecoration(
      //       image: DecorationImage(
      //         fit: BoxFit.fitWidth,
      //         image: NetworkImage(this.src),
      //       )
      child: Image.network(this.src)
    );
  }
}
