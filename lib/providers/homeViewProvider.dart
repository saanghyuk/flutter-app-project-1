import 'package:flutter/foundation.dart';

class BannerModel{
  final String title;
  final String img;
  final String des;

  const BannerModel({required this.title, required this.img, required this.des});
  factory BannerModel.json(json) => BannerModel(
      title: json['title'].toString(),
      img: json['img'].toString(),
      des: json['des'].toString()
  );
}
class HomeListItem{
  final String title;
  final String des;
  final String img;
  const HomeListItem({required this.title, required this.img, required this.des});
  factory HomeListItem.json(Map<String, dynamic> json) => HomeListItem(
      title: json['title'].toString(),
      img: json['img'].toString(),
      des: json['des'].toString(),
  );
}

class HomeListProductModel{
  final String title;
  final List<HomeListItem> items;
  const HomeListProductModel({required this.title, required this.items});
  factory HomeListProductModel.json(Map<String, dynamic> json) => HomeListProductModel(
      title: json['title'].toString(),
      items: List.of(json['items']).map((e) => HomeListItem.json(e)).toList(),
  );

  HomeListProductModel copy(){
    return HomeListProductModel(
        title: this.title,
        items: [...items]
    );
  }
}


class HomeGridItemModel{
  final String title;
  final String img;
  const HomeGridItemModel({required this.title, required this.img});
  factory HomeGridItemModel.json(Map<String, dynamic> json) => HomeGridItemModel(
      title: json['title'].toString(),
      img: json['img'].toString()
  );
}
class HomeGridProductModel{
  final String title;
  final List<HomeGridItemModel> items;
  const HomeGridProductModel({required this.title, required this.items});
  factory HomeGridProductModel.json(Map<String, dynamic> json) => HomeGridProductModel(
      title: json['title'].toString(),
      items: List.of(json['items ']).map<HomeGridItemModel>(
          (e) => HomeGridItemModel.json(e)
      ).toList()
  );
  HomeGridProductModel copy() => HomeGridProductModel(
      title: this.title, items: [...this.items]
  );
}


class HomeViewProvider with ChangeNotifier{

  HomeViewProvider(){
    Future(this._init);
  }
  void _init() async {
    // await fetch();
    // this._setBanner(bnJson);
    // this.notifyListeners();
  }
  
  final String homeTitle = "logo";
  List<BannerModel>? _bannerData; // 불러와서 넣어줄거라 final 안된다. 아니면, 비어있는 []넣고 add로 해도 되긴 한다.
  // 리스트는 연결 끊어주었다.
  List<BannerModel>? get bannerData => [...this._bannerData ?? []];


  // _bannerData에 들어갈 데이터를 이 메서드를 통해서 만들어주는 것. API를 통해서 호출할 것.
  // API하나
  _setBanner(List<Map<String, dynamic>> bnJson){
    _bannerData = bnJson.map<BannerModel>(
            (e) => BannerModel.json(e)).toList();
  }

  // 상품 나열
  HomeListProductModel? _listProduct;
  // List<HomeListItem>을 직접 넣을 수도 있어서 그대로 내보내면 안된다.
  HomeListProductModel? get listProduct => this._listProduct?.copy();

  void _setHomeListProduct(Map<String, dynamic> json){
    this._listProduct = HomeListProductModel.json(json);
  }

  // 그룹 형식
  HomeGridProductModel? _gridProduct;

}