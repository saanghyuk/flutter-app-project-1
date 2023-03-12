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
  final _scrollController = ScrollController();
  int _btnState = 0;

  final List<Size> _sizes = [];


  @override
  void dispose() {
    // TODO: implement dispose
    this._controller.dispose();
    this._scrollController.dispose();
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
                // physics: NeverScrollableScrollPhysics(),
                controller: this._scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: this.widget.data.map<Widget>((e){
                    final _eIndex = this.widget.data.indexOf(e);
                    return BnTextButton(
                      onPressed: () async {
                        this._controller.jumpToPage(_eIndex);
                        await this.widget.onTap(_eIndex);

                        this._scrollController.jumpTo(_eIndex*this._sizes[_eIndex].width);
                      },
                      title: e['title'],
                      isAction: this._btnState == _eIndex,
                      onComplete: (Size size){
                          this._sizes.add(size);
                      }
                    );
                  }).toList(),
                )
            ),
            Expanded(
                child: PageView.builder(
                    onPageChanged: (int index) async {
                      setState(() {
                        this._btnState = index;
                      });
                      // 누적 시켜서 넣어야 한다.
                      print(_scrollController.position);
                      // if(this._scrollController.position.pixels >= this._scrollController.position.maxScrollExtent){
                      //   return;
                      // }
                      await this.widget.onChanged(index);

                      double result = 0;
                      for(int i = 0; i<index; i++){
                        result += this._sizes[i].width;
                      }
                      // print(result);
                      // print(this._scrollController.position.maxScrollExtent);
                      if(result >= this._scrollController.position.maxScrollExtent){
                          return;
                      }
                      this._scrollController.jumpTo(index*this._sizes[index].width);

                    },
                    controller: this._controller,
                    itemCount: this.widget.data.length,
                    itemBuilder: (BuildContext context, int index) => Container(
                        child: Column(
                          children: [
                            Expanded(child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  // image: DecorationImage(
                                  //   fit: BoxFit.cover,
                                  //   image: NetworkImage(this.widget.data[index]['img'].toString()),
                                  // )
                              ),
                            )
                            ),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(this.widget.data[index]['des'].toString())
                            )
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

class BnTextButton extends StatefulWidget {
  final FutureOr<void> Function() onPressed;
  final String title;
  final bool isAction;
  final void Function(Size) onComplete;
  const BnTextButton({Key? key, required this.onPressed, required this.title, required this.isAction, required this.onComplete}) : super(key: key);


  @override
  State<BnTextButton> createState() => _BnTextButtonState();
}

class _BnTextButtonState extends State<BnTextButton> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      this.widget.onComplete(this.context.size!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: this.widget.onPressed,
      child: Text(this.widget.title, style: this.widget.isAction
          ?
      TextStyle(color: Colors.red, fontWeight : FontWeight.bold)
          : TextStyle(color: Colors.grey)),
    );
  }
}
