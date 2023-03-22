
import 'package:flutter/material.dart';
import 'package:flutterstudy2/components/TextBanner.dart';
import 'package:flutterstudy2/components/detailImage.dart';
import 'package:flutterstudy2/components/titleGrid.dart';

import '../components/titleText.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ScrollController _controller = ScrollController();
  bool _isShow = false;
  bool _isEvents = false;

  void _handler() {

    // if(!this.mounted) return;

    // print("events");
    // print(this._controller.position);
    if(this._controller.position.pixels >= 100){
      if(this._isShow) return;
      print("show");
      setState(() {
        this._isShow= true;
      });
    } else{
      if(!this._isShow) return;
      print("not show");
      // if(!this.mounted) return;
      setState(() {
        this._isShow= false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // 특별한 거 아니면 위에꺼 끝나고 아래
      this._controller.addListener(_handler);
      setState(() => this._isEvents = true);
    });

    // 리스너 삭제
    // this._controller.removeListener(_handler)
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _viewSize = MediaQuery.of(context).size;
    return IgnorePointer(
      ignoring: !this._isEvents,
      child: Scaffold(
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: MaterialButton(
                height: kBottomNavigationBarHeight,
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  child: Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(child:
                MaterialButton(
                    height: kBottomNavigationBarHeight,
                    padding: EdgeInsets.zero,
                    textColor: Colors.white,
                    color: Colors.red,
                    child: Text("OK"),
                onPressed: (){}
            )),
          ],
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white54,
          centerTitle: true,
          title: Text("Title"),
          foregroundColor: Colors.black87,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                controller: this._controller,
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(bottom: 60.0),
                  width: _viewSize.width,
                  child: Column(
                    children: [
                      TextBanner(
                          child: Text("Text Bannder")
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: TitleText.review(
                          alignment: CrossAxisAlignment.center,
                          txt: "AB180",
                          star: 4,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      DetailImage(src: "https://thumbnail8.coupangcdn.com/thumbnails/remote/q89/image/retail/images/2192795093435290-b1334436-d7c8-4d5d-8002-35b80ec5cda5.jpg"),
                      Container(
                        width: _viewSize.width,
                        height: 200.0,
                        child: TitleGrid.builder(
                            sliverGridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0
                            ),
                            itemBuilder: (BuildContext, int) => GridTile(child: Container(color: Colors.red)),
                            itemCount: 10,
                            title: "Helo World",
                            axis: Axis.horizontal,
                        ),
                      )
                    ],
                  ),
                )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            ...this._isEvents ? []:  <Widget>[Positioned(
              top:0,
              bottom: 0,
              left:0,
              right: 0,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),
              // Layer가 앞에 Positioned 위, 즉 맨 위
              Positioned(
                  top:0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                      child: CircularProgressIndicator()
                  )
              )]
          ],
        ),
        floatingActionButton: !this._isShow ? null : FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: (){
            this._controller.jumpTo(0);
          },
        ),
      ),
    );
  }
}