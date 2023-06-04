
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterstudy2/components/titleGrid.dart';
import 'package:flutterstudy2/components/titleList.dart';
import 'package:flutterstudy2/pages/detailPage.dart';
import 'package:flutterstudy2/providers/BannerAdapter.dart';
import 'package:flutterstudy2/providers/homeViewProvider.dart';
import 'package:flutterstudy2/views/peedView.dart';
import 'package:provider/provider.dart';
import '../adapters/mainPageAdapter.dart';
import '../components/banner.dart' as BN;
import '../providers/status_enum.dart';
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

  // @override
  // void initState(){
  //   this._peedViewController.addListener(() {
  //     print(this._peedViewController.position.pixels);
  //   });
  //   super.initState();
  // }


  final MainPageAdapterInterface _mainPageAdapter = MainPageAdapter();

  @override
  void dispose(){
    this._controller.dispose();
    _homeViewController.dispose();
    _peedViewController.dispose();
    super.dispose();
  }

  HomeViewProvider? homeViewProvider;

  @override
  void didChangeDependencies() {
    homeViewProvider = context.watch<HomeViewProvider>();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    // 뒤로 갈 수 있는지 여부
    print(Navigator.of(context).canPop());

    // didChangeDependencies 호출하고 바로 build를 호출했는데 didChangeDependencies에서 watch가 안끝나서 Provider가 없을 수 있음.
    if(this.homeViewProvider == null) return Material(
        child: Center(
            child: Text("고객센터로 연락해 주세요. Err P-001")
        )
    );

    if(this.homeViewProvider!.isLoad == Status.Fail) {
      return Text("ERROR");
    }
    if(this.homeViewProvider!.isLoad == Status.Load){
      return Material(
        child: Center(
          child: CircularProgressIndicator(),
        )
      );
    }

    if(homeViewProvider!.homeDataModel == null) return Material();

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
        title: Text("우당탕탕"),
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
            titleTxt: 'SDK Test',
            bnData: _mainPageAdapter.BannerModel_2_BnDataModel(
                bannerModel: this.homeViewProvider!.homeDataModel!.listBn
            ),
            homeViewItemListData: HomeViewItemListData(
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
            ),
            homeViewGridItemListData: _mainPageAdapter.grid(
                data: this.homeViewProvider!.homeDataModel!.gridProductModel,
                builder: (HomeGridItemModel model) => Expanded(
                      child: GestureDetector(
                        onTap: (){},
                        child: Container(
                          height: 300.0,
                          alignment: Alignment.center,
                          child: Text(model.title)
                        ),
                      )
                  ),
                )

            ),
          SearchView(searchViewData: SearchViewData(
              hintText: "검색어를 입력해 주세요!",
              keyword: ["추천검색1", "검색1","추천검색2", "검색2","추천검색3", "검색3", "추천검색4", "추천검색5", "추천검색6"],
              onTap: (int index) async {
                //
              }
          )),
          // Provider
          // JSON{} => Provider가 관리하는 Model => ViewModel
          PeedView(
            event: () async {
              print("Event!");
              await Future.delayed(Duration(seconds : 3));
              print("Event End!");
            },
            controller : this._peedViewController,
            data: [
              PeedViewModel(uid: '', name:"User1", profileImg: "https://cdn.pixabay.com/photo/2023/04/14/10/27/superb-fairywren-7924728_640.jpg", img: "https://cdn.pixabay.com/photo/2023/04/15/17/08/bernese-mountain-dog-7928156_1280.jpg", ),
              PeedViewModel(uid: '', name:"User2", profileImg: "https://cdn.pixabay.com/photo/2023/04/14/10/27/superb-fairywren-7924728_640.jpg", img: "https://cdn.pixabay.com/photo/2023/04/15/17/08/bernese-mountain-dog-7928156_1280.jpg"),
              PeedViewModel(uid: '', name:"User3", profileImg: "https://cdn.pixabay.com/photo/2023/04/14/10/27/superb-fairywren-7924728_640.jpg", img: "https://cdn.pixabay.com/photo/2023/04/15/17/08/bernese-mountain-dog-7928156_1280.jpg"),
            ],
            onTap1: (String uid, int index) {

            },
            onTap2: (String uid, int index) {  },
            onTap3: (String uid, int index) {  },
          ),
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