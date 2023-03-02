import 'package:flutter/material.dart'; 

class MainPage extends StatefulWidget {
  static const String path = "/";
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final PageController _controller = new PageController();
  // final 안붙이고 int
  int _btmIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        // RGBO
        backgroundColor: Colors.green.shade500,
        elevation: 1.0,
        centerTitle: true,
        title: Text("Airbridge"),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications)
          )
        ]
      ),
      // pageview가 알아서 setstate해주는 것.
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
          this.setState(() => this._btmIndex = index);
          this._controller.jumpToPage(index);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey.shade400,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.note_sharp), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "")
        ],
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
    return
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
          child: Container(
              // height:2000.0, color: Colors.red,
            width: _size.width,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top:30.0, left:30.0),
                  child: Text("Title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)
                  ),
                ),
                Container(
                   height: 200.0,
                   child: Banner(
                       count: 10,
                   ),
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



class Banner extends StatefulWidget {
  // final double height;
  // final int count;
  final List data;
  const Banner({Key? key, required this.data}) : super(key: key);

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
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              // List 타입 자체에서 주는 생성자
              children: this.widget.data.map<Widget>((e) {
                final _eIndex = this.widget.data.indexOf(e);
                return TextButton(
                    onPressed: () => this._controller.jumpToPage(_eIndex),
                    child: Text(e['title'].toString(),
                        style: this._btnState == _eIndex
                            ? TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)
                            : TextStyle(color: Colors.grey))
                )
              }).toList(),
            ),
          ),
          Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  setState(() {
                    this._btnState = index;
                  });
                },
                controller: this._controller,
                itemCount: this.widget.data.length,
                itemBuilder : (BuildContext context, int index) => Container(
                      child: Column(
                        children: [
                          Expanded(child: Container(color: Colors.blue)),
                          Container(child: Text(this.widget.data[index]['des'].toString()))


                        ],
                      ),
                    )


              )
          )
        ],
      ),
    );
  }
}
