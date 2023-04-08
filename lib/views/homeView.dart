import 'package:flutter/material.dart';
import '../components/banner.dart' as BN;
import '../components/titleGrid.dart';
import '../components/titleList.dart';
import '../pages/detailPage.dart';

class HomeViewItemListData{
  final String title;
  final int count;
  final Widget Function(BuildContext, int) builder;
  HomeViewItemListData({required this.title, required this.count, required this.builder});
}


class HomeViewGridItemListData{
  final String title;
  final int rowCount;
  final int itemCount;
  final Widget Function(BuildContext, int) builder;
  const HomeViewGridItemListData({
    required this.builder,
    required this.title,
    required this.itemCount,
    required this.rowCount,
  });
}


class HomeView extends StatefulWidget {
  final String titleTxt;
  final ScrollController controller;
  final List<Map<String, String>> bnData;
  final HomeViewItemListData homeViewItemListData;
  final HomeViewGridItemListData homeViewGridItemListData;
  // final ListBuilderData listBuilderData;

  const HomeView({Key? key, required this.controller, required this.titleTxt, required this.bnData, required this.homeViewItemListData, required this.homeViewGridItemListData}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin{


  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        controller: this.widget.controller,
        physics: BouncingScrollPhysics(),
        child: Container(
          width : _size.width,
          child: Column(
            children: [
              Container(
                  alignment : Alignment.center,
                  padding: EdgeInsets.only(top:30.0),
                  child:Text(this.widget.titleTxt, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0))
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
                    data: this.widget.bnData.map<BN.BannerItem>(
                            (Map<String, String> e) => BN.BannerItem.json(e)
                    ).toList(),
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
                    titleListData: TitleListData.builder(
                      title: this.widget.homeViewItemListData.title,
                      count: this.widget.homeViewItemListData.count,
                      builder: this.widget.homeViewItemListData.builder,
                        // title: 'AB180',
                        // count: 3,
                        // builder: (BuildContext context, int index) {
                        //   return GestureDetector(
                        //     onTap: () async {
                        //       await Navigator.of(context).push(
                        //           MaterialPageRoute(builder: (_) => DetailPage())
                        //       );
                        //     },
                        //     child: Container(
                        //         margin: EdgeInsets.symmetric(horizontal: 10.0),
                        //         width: 240.0,
                        //         child: TitleListItem(
                        //             img: 'https://cdn.pixabay.com/photo/2023/01/28/12/18/fog-7750811_640.jpg',
                        //             title: 'test $index',
                        //             subTitle: '1000원')
                        //     ),
                        //   );
                        // }
                    ) ,

                    // title: this.widget.listTitle,
                    // itemCount: this.widget.listItemCount,
                    // itemBuilder: (BuildContext context, int index){
                    //   return GestureDetector(
                    //     onTap: () async {
                    //       await Navigator.of(context).push(
                    //           MaterialPageRoute(builder: (_) => DetailPage())
                    //       );
                    //     },
                    //     child: Container(
                    //         margin: EdgeInsets.symmetric(horizontal: 10.0),
                    //         width: 240.0,
                    //         child: TitleListItem(
                    //             img: 'https://cdn.pixabay.com/photo/2023/01/28/12/18/fog-7750811_640.jpg',
                    //             title: 'test $index',
                    //             subTitle: '1000원')
                    //     ),
                    //   );
                  )
              ),
              // Container(
              //   height: 300.0,
              //   width: _size.width,
              //   // child: TitleList.builder(
              //   //     title: "Test2",
              //   //     itemCount: 3,
              //   //     itemBuilder: (BuildContext context, int index){
              //   //       return Container(
              //   //           margin: EdgeInsets.symmetric(horizontal: 10.0),
              //   //           width: 240.0,
              //   //           child: TitleListItem(
              //   //               img: 'https://ssl.pstatic.net/melona/libs/1432/1432421/fd1685d2358917002d3d_20230310141843048.jpg',
              //   //               title: 'test $index',
              //   //               subTitle: '1000원')
              //   //       );
              //   //     })
              // ),
              Container(
                  child: TitleGrid(
                    // @TODO: 데이터 작업 후 반복 예정
                    title: this.widget.homeViewGridItemListData.title,
                    rowCount: this.widget.homeViewGridItemListData.rowCount,
                    children: ((){
                        List<List<Widget>> list = [];
                        for(int e = 0; e<this.widget.homeViewGridItemListData.itemCount; e++){
                          Widget _item = Builder(builder: (BuildContext context) => this.widget.homeViewGridItemListData.builder(context , e));
                          if(e != 0 && e % 2 != 0){
                            list[list.length-1].add(_item);
                          }else{
                            list.add([_item]);
                          }
                        }
                        return list;
                    })(),
                  )
              ),
              Container(
                width: _size.width,
                height: 200.0,
                child: TitleGrid.builder(
                    sliverGridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: this.widget.homeViewGridItemListData.builder,
                    itemCount: this.widget.homeViewGridItemListData.itemCount,
                    title: this.widget.homeViewGridItemListData.title)
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