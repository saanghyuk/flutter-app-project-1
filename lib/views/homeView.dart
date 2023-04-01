import 'package:flutter/material.dart';
import '../components/banner.dart' as BN;
import '../components/titleGrid.dart';
import '../components/titleList.dart';
import '../pages/detailPage.dart';

class HomeView extends StatefulWidget {
  final String titleTxt;
  final ScrollController controller;
  final List<Map<String, String>> bnData;
  const HomeView({Key? key, required this.controller, required this.titleTxt, required this.bnData}) : super(key: key);

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