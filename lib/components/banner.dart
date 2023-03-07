import 'package:flutter/material.dart';
import 'dart:async';

class Banner extends StatefulWidget {
  // final int count = 8;
  final double? height;
  final EdgeInsets? margin;

  final FutureOr<void> Function(int) onTap;
  final FutureOr<void> Function(int) onChanged;

  final List data;
  const Banner({Key? key, required this.data, this.height, this.margin, required this.onTap, required this.onChanged}) : super(key: key);

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  final PageController _controller = PageController();
  int _btnState = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    this._controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.widget.height,
        margin: this.widget.margin,
        // color: Colors.red,
        // width: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  // color: Colors.red,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: this.widget.data.map<Widget>((e){
                      final _eIndex = this.widget.data.indexOf(e);
                      return TextButton(
                        onPressed: () async {
                          this._controller.jumpToPage(_eIndex);
                          await this.widget.onTap(_eIndex);

                        },
                        child: Text(e['title'].toString(), style: this._btnState == _eIndex
                            ?
                        TextStyle(color: Colors.red, fontWeight : FontWeight.bold)
                            : TextStyle(color: Colors.grey)),
                      );
                    }).toList(),
                  ),
                )
            ),
            Expanded(
                child: PageView.builder(
                    onPageChanged: (int index) async {
                      setState(() {
                        this._btnState = index;
                      });
                      await this.widget.onChanged(index);
                    },
                    controller: this._controller,
                    itemCount: this.widget.data.length,
                    itemBuilder: (BuildContext context, int index) => Container(
                        child: Column(
                          children: [
                            Expanded(child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image : NetworkImage(this.widget.data[index]["img"].toString())
                                  )
                              ),
                            )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(this.widget.data[index]['des'].toString()))
                          ],
                        )
                    )
                )
            )
          ],
        )
    );
  }
}
