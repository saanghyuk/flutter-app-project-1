import 'package:flutter/material.dart';

class RoundBorderText extends StatelessWidget {
  final String txt;
  final void Function(BuildContext)? onTap;
  const RoundBorderText({Key? key, required this.txt, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.greenAccent.shade200,
          border: Border.all(),
          borderRadius: BorderRadius.circular(20.0)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: (){
          if(onTap == null) return;
          this.onTap!(context);
        },
        child: Container(
          child: Text(txt),
        ),
      ),
    );
  }
}