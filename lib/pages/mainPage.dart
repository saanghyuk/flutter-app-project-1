import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterstudy2/components/titleGrid.dart';
import 'package:flutterstudy2/components/titleList.dart';
import 'package:flutterstudy2/pages/detailPage.dart';
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
    // 뒤로 갈 수 있는지 여부
    print(Navigator.of(context).canPop());

    final bool _canPop = Navigator.of(context).canPop();
    return Scaffold(
      // drawerEnableOpenDragGesture: false,
      // drawerScrimColor: Colors.blue,
      drawer: _canPop ? null : Drawer(
        // backgroundColor: Colors.red,
          elevation: 10.0,
          child: Column(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 2.0, color: Colors.grey.shade200))
                  ),
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("Welcome")
                  )
              ),
              ...<String>["Home", "Menu1", "Menu2"].map<Widget>(
                      (String menuTitle) => ListTile(
                    title: Text(menuTitle),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () async {
                      // 닫기
                      // Drawer 닫고
                      Navigator.of(context).pop();

                      // 다른 코드들 실행되게 하려고 붙여주는 것.
                      // 현재 context에서는 기다리되 다른 context는 실행되도록
                      // await Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (BuildContext context) => MainPage())
                      // );
                    },
                  )
              ).toList()
            ],
          )
        // child: ,

      ),
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
                  alignment : Alignment.center,
                  padding: EdgeInsets.only(top:30.0),
                  child:Text("Airbridge SDK TEST", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0))
              ),
              Container(
                  height: 400.0,
                  child: BN.Banner(
                    onTap: (int index){
                      print(index);
                    },
                    onChanged: (int index){
                      print(index);
                    },
                    data: [ {
                      "img": "https://ssl.pstatic.net/melona/libs/1432/1432421/a099d8fde3ec492dcb72_20230310141831265.jpg",
                      // "img": "https://ca.slack-edge.com/T07GVPPHU-U03J34P9TCN-111f3245ddb1-512",
                      "title":"test1",
                      "des": "test1 description",
                    },
                      {
                        "img": "https://ssl.pstatic.net/melona/libs/1432/1432421/a099d8fde3ec492dcb72_20230310141831265.jpg",
                        "title":"test2",
                        "des": "test2 description",
                      },
                      {
                        "img": "https://ssl.pstatic.net/melona/libs/1432/1432421/a099d8fde3ec492dcb72_20230310141831265.jpg",
                        "title":"test3",
                        "des": "test3 description",
                      },
                      {
                        "img": "https://ssl.pstatic.net/melona/libs/1432/1432421/a099d8fde3ec492dcb72_20230310141831265.jpg",
                        "title":"test4",
                        "des": "test4 description",
                      },
                      {
                        "img": "https://ssl.pstatic.net/melona/libs/1432/1432421/a099d8fde3ec492dcb72_20230310141831265.jpg",
                        "title":"test5",
                        "des": "test5 description",
                      },
                      {
                        "img": "https://ssl.pstatic.net/melona/libs/1432/1432421/a099d8fde3ec492dcb72_20230310141831265.jpg",
                        "title":"test6",
                        "des": "test6 description",
                      },
                      {
                        "img": "https://ssl.pstatic.net/melona/libs/1432/1432421/a099d8fde3ec492dcb72_20230310141831265.jpg",
                        "title":"test7",
                        "des": "test7 description",
                      },
                      {
                        "img": "https://ssl.pstatic.net/melona/libs/1432/1432421/a099d8fde3ec492dcb72_20230310141831265.jpg",
                        "title":"test8",
                        "des": "test8 description",
                      },
                      {
                        "img": "https://ssl.pstatic.net/melona/libs/1432/1432421/a099d8fde3ec492dcb72_20230310141831265.jpg",
                        "title":"test9",
                        "des": "test9 description",
                      }
                    ],
                  )
              ),
              // Container(
              //   height: 240.0,
              //   width: _size.width,
              //   child: TitleList(
              //     title: "SingleChildScrollView",
              //     children: [
              //       Container(
              //         width: 200.0,
              //         color: Colors.red
              //       ),
              //       Container(
              //         width: 200.0,
              //         margin: EdgeInsets.symmetric(horizontal: 20.0),
              //         child: TitleListItem(
              //           img: 'https://cdn.pixabay.com/photo/2023/01/28/12/18/fog-7750811_640.jpg',
              //           title: 'test',
              //           subTitle: '1000원',)
              //       )
              //     ]
              //   )
              // ), // Container
              Container(
                  height: 300.0,
                  width: _size.width,
                  child: TitleList.builder(
                      title: "Test2",
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => DetailPage())
                            );
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              width: 240.0,
                              child: TitleListItem(
                                  img: 'https://cdn.pixabay.com/photo/2023/01/28/12/18/fog-7750811_640.jpg',
                                  title: 'test $index',
                                  subTitle: '1000원')
                          ),
                        );
                      })
              ),
              Container(
                  height: 300.0,
                  width: _size.width,
                  child: TitleList.builder(
                      title: "Test2",
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            width: 240.0,
                            child: TitleListItem(
                                img: 'https://ssl.pstatic.net/melona/libs/1432/1432421/fd1685d2358917002d3d_20230310141843048.jpg',
                                title: 'test $index',
                                subTitle: '1000원')
                        );
                      })
              ),
              Container(
                  child: TitleGrid(
                    // @TODO: 데이터 작업 후 반복 예정
                    title: 'GridTest',
                    rowCount: 2,
                    children: [
                      [
                        Container(
                          // color: Colors.red,
                            width : _size.width * 0.50 - 40.0,
                            height: 240.0,
                            margin: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("https://ssl.pstatic.net/melona/libs/1432/1432421/fd1685d2358917002d3d_20230310141843048.jpg"),
                                )
                            )
                        ),
                        // GridTile(
                        //     child: Container()
                        // )
                      ],
                      [
                        Container(color: Colors.yellow, width : 100.0, height: 100.0),
                        Container(color: Colors.green, width : 100.0, height: 100.0)
                      ]
                    ],
                  )
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