

import 'package:flutter/material.dart';
import 'dart:async';



class BannerItem{
    final String img;
    final String title;
    final String des;

    const BannerItem( {
      required this.img,
      required this.title,
      required this.des,
    });

    // BannerItem.json(Map<String, String> e)
    //     : img = e['img'].toString(),
    //       title = e['title'].toString(),
    //       des =e['des'].toString();

    // 더 편한 방법이 있다.
    factory BannerItem.json(Map<String, String> e){
      return BannerItem(
        img:e['img'].toString(),
        title:e['title'].toString(),
        des:e['des'].toString(),
      );
    }
}


class Banner extends StatefulWidget {
  // final int count = 8;

  final double? height;
  final EdgeInsets? margin;

  final FutureOr<void> Function(int) onTap;
  final FutureOr<void> Function(int) onChanged;
  final List<BannerItem> data;

  const Banner({Key? key, required this.data, this.height, this.margin, required this.onTap, required this.onChanged}) : super(key: key);

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  final PageController _controller = PageController();
  int _btnState = 0;
  final _scrollController = ScrollController();

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
                controller: this._scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: this.widget.data.map<Widget>(
                          (BannerItem e){
                    final _eIndex = this.widget.data.indexOf(e);
                    return BnTextButton(onPressed: () async {
                      this._controller.jumpToPage(_eIndex);
                      await this.widget.onTap(_eIndex);
                      this._scrollController.jumpTo(_eIndex*this._sizes[_eIndex].width);
                            },
                       // {"title": "title1 "}// map객체에서 선택
                       // e.title
                      title: e.title,
                      isAction: this._btnState == _eIndex,
                      onComplete: (Size size) {
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
                      await this.widget.onChanged(index);
                      print(_scrollController.position);
                      print(this._scrollController.position.maxScrollExtent);
                      double result =0;
                      for(int i = 0; i<index ; i++){
                        result += this._sizes[i].width;
                      }

                      // maxScrollExtent는 총 스크롤 가능한 길이
                      print(this._scrollController.position.maxScrollExtent);

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
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(this.widget.data[index].img),
                                  )
                              ),
                            )
                            ),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(this.widget.data[index].des)
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this.widget.onComplete(this.context.size!);
      print(this.context.size);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: this.widget.onPressed,
      child: Text(
          this.widget.title, style: this.widget.isAction ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold) : TextStyle(color: Colors.grey)
      ),
    );;
  }
}


