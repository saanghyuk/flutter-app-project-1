import 'package:flutter/material.dart'; 

class ReviewStar extends StatelessWidget {
  final int value;
  const ReviewStar({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int _max = 5;
    final double _iconSize = 18.0;
    final Color _activeColor = Colors.red;
    final Color _inactiveColor = Colors.grey.shade400;

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List<int>.generate(_max, (index) => index)
          .map<Widget>((int e){
            final int _i = e+1;
            if(_i <= value){
              return Icon(Icons.star, color: _activeColor, size: _iconSize);
            } else{
              return Icon(Icons.star_border, color: _inactiveColor, size : _iconSize);
            }
        }).toList(),
      ),
    );
  }
}
