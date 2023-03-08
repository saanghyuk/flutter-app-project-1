import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterstudy2/components/titleList.dart';
import '../components/banner.dart' as BN;

class MainPage extends StatefulWidget {
  static const String path = "/";


  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();



}

class _MainPageState extends State<MainPage> {
  final PageController _controller = new PageController();

  int _btmIndex = 0;

  @override
  void dispose(){
    this._controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(9, 67, 214, 1),
        elevation: 1.0,
        centerTitle: true,
        title: Text("Airbridge"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: (){},
          )
        ],
      ),
      body: PageView(
        controller: this._controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeView(),
          Container(color: Colors.blue),
          Container(color: Colors.yellow),
          Container(color: Colors.pink),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._btmIndex,
          onTap: (int index){
            setState(() {
              this._btmIndex = index;
            });
            this._controller.jumpToPage(index);
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.lightBlue,
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.note_sharp), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
          ]
      ),
    );
  }
}


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin{


  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width : _size.width,
          child: Column(
            children: [
              Container(
                  alignment : Alignment.centerLeft,
                  padding: EdgeInsets.only(top:30.0, left:30.0),
                  child:Text("SDK TEST", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0))
              ),
              Container(
                  height: 300.0,
                  child: BN.Banner(
                    onTap: (int index){
                      print(index);
                    },
                    onChanged: (int index){
                      print(index);
                    },
                    data: [ {
                      "img": "https://cdn.pixabay.com/photo/2023/02/17/19/59/dog-7796822_1280.jpg",
                      "title":"test1",
                      "des": "test1 description",
                    },
                      {
                        "img": "https://cdn.pixabay.com/photo/2023/01/23/09/26/cat-7738210_640.jpg",
                        "title":"test2",
                        "des": "test2 description",
                      },
                      {
                        "img": "https://cdn.pixabay.com/photo/2023/02/24/10/14/flowers-7810659_1280.jpg",
                        "title":"test3",
                        "des": "test3 description",
                      },
                      {
                        "img": "https://cdn.pixabay.com/photo/2023/02/25/12/30/man-7813108_1280.jpg",
                        "title":"test4",
                        "des": "test4 description",
                      },
                      {
                        "img": "https://cdn.pixabay.com/photo/2023/01/28/12/18/fog-7750811_1280.jpg",
                        "title":"test5",
                        "des": "test5 description",
                      },
                      {
                        "img": "https://cdn.pixabay.com/photo/2023/02/14/18/55/flowers-7790227_640.jpg",
                        "title":"test6",
                        "des": "test6 description",
                      },
                      {
                        "img": "https://cdn.pixabay.com/photo/2023/01/21/22/33/hamburg-7735229_640.jpg",
                        "title":"test7",
                        "des": "test7 description",
                      }
                    ],
                  )
              ),
              Container(
                height: 240.0,
                width: _size.width,
                child: TitleList(
                  title: "SingleChildScrollView",
                  children: [
                    Container(
                      width: 200.0,
                      color: Colors.red
                    ),
                    Container(
                        width: 200.0,
                        color: Colors.green
                    ),
                    Container(
                        width: 200.0,
                        color: Colors.blue
                    )
                  ]
                )
              ),
              Container(
                  height: 300.0,
                  width: _size.width,
                  child: TitleList.builder(
                      title: "ListView.builder",
                      itemCount: 100,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                          width: _size.width/2,
                          color: Colors.grey.shade300,
                          margin: EdgeInsets.all(10.0),
                          child: Text(index.toString())
                        );
                      })
              )
            ],
          ),
        )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

