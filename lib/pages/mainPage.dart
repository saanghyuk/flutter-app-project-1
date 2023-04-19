


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterstudy2/components/titleGrid.dart';
import 'package:flutterstudy2/components/titleList.dart';
import 'package:flutterstudy2/pages/detailPage.dart';
import 'package:flutterstudy2/views/peedView.dart';
import '../components/banner.dart' as BN;
import '../views/homeView.dart';
import '../views/searchView.dart';

class MainPage extends StatefulWidget {
  static const String path = "/";

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();



}

class _MainPageState extends State<MainPage> {
  final PageController _controller = new PageController();
  int _btmIndex = 0;
  final ScrollController _homeViewController = ScrollController();
  final ScrollController _peedViewController = ScrollController();
  final List<String> _menus = ["Home", "Menu1", "Menu2"];

  @override
  void dispose(){
    this._controller.dispose();
    _homeViewController.dispose();
    _peedViewController.dispose();
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
              ...this._menus.map<Widget>(
                      (String menuTitle) {
                    final int _pIndex = this._menus.indexOf(menuTitle);
                    return ListTile(
                      title: Text(menuTitle),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () async {
                        // 닫기
                        // Drawer 닫고
                        Navigator.of(context).pop();
                        this._controller.jumpToPage(_pIndex);
                        // 다른 코드들 실행되게 하려고 붙여주는 것.
                        // 현재 context에서는 기다리되 다른 context는 실행되도록
                        // await Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (BuildContext context) => MainPage())
                        // );
                      },
                    );
                  }
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
          HomeView(
            controller : this._homeViewController,
            titleTxt: 'Airbridge SDK TEST',
            bnData: [ {
              "img": "https://cdn.pixabay.com/photo/2023/03/19/12/24/chick-7862460_640.jpg",
              // "img": "https://ca.slack-edge.com/T07GVPPHU-U03J34P9TCN-111f3245ddb1-512",
              "title":"test1",
              "des": "test1 description",
            },
              {
                "img": "https://cdn.pixabay.com/photo/2023/03/19/12/24/chick-7862460_640.jpg",
                "title":"test2",
                "des": "test2 description",
              },
              {
                "img": "https://cdn.pixabay.com/photo/2023/03/19/12/24/chick-7862460_640.jpg",
                "title":"test3",
                "des": "test3 description",
              },
              {
                "img": "https://cdn.pixabay.com/photo/2023/03/19/12/24/chick-7862460_640.jpg",
                "title":"test4",
                "des": "test4 description",
              },
              {
                "img": "https://cdn.pixabay.com/photo/2023/03/19/12/24/chick-7862460_640.jpg",
                "title":"test5",
                "des": "test5 description",
              },
              {
                "img": "https://cdn.pixabay.com/photo/2023/03/19/12/24/chick-7862460_640.jpg",
                "title":"test6",
                "des": "test6 description",
              },
              {
                "img": "https://cdn.pixabay.com/photo/2023/03/19/12/24/chick-7862460_640.jpg",
                "title":"test7",
                "des": "test7 description",
              },
              {
                "img": "https://cdn.pixabay.com/photo/2023/03/19/12/24/chick-7862460_640.jpg",
                "title":"test8",
                "des": "test8 description",
              },
              {
                "img": "https://cdn.pixabay.com/photo/2023/03/19/12/24/chick-7862460_640.jpg",
                "title":"test9",
                "des": "test9 description",
              }
            ], homeViewItemListData: HomeViewItemListData(
              title: 'AB180',
              count: 10,
              builder: (BuildContext context, int index){
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
                      img: 'https://cdn.pixabay.com/photo/2023/03/27/14/18/british-shorthair-7880879_1280.jpg',
                      title: 'AB180',
                      subTitle: 'test $index',
                    ),
                  ),
                );
              }
          ), homeViewGridItemListData: HomeViewGridItemListData(
              builder: (BuildContext context, int index) => Container(
                  child: Text(index.toString())
              ),
              title: 'GridTitle',
              itemCount: 10,
              rowCount: 2
          ),
          ),
          SearchView(searchViewData: SearchViewData(
              hintText: "검색어를 입력해 주세요!",
              keyword: ["추천검색1", "검색1","추천검색2", "검색2","추천검색3", "검색3", "추천검색4", "추천검색5", "추천검색6"],
              onTap: (int index){

              }
          )),
          PeedView(controller : this._peedViewController),
          Container(color: Colors.pink),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._btmIndex,
          onTap: (int index){
            // print()
            if(this._btmIndex == index){
              if(index == 0){
                if(this._homeViewController.position.pixels >= 100){
                  this._homeViewController.jumpTo(0);
                }

              }
              if(this._btmIndex ==2){
                if(this._peedViewController.position.pixels >= 100){
                  this._peedViewController.jumpTo(0);
                }
              }
              return;
            }

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