import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterstudy2/providers/status_enum.dart';

class HomeDataModel{
  final List<BannerModel> listBn;
  final HomeListProductModel listProductModel;
  final HomeGridProductModel gridProductModel;
  const HomeDataModel({required this.listBn, required this.listProductModel, required this.gridProductModel});

  HomeDataModel copy() => HomeDataModel(
      listBn: [...listBn],
      listProductModel: listProductModel.copy(),
      gridProductModel: gridProductModel.copy()
  );
}

class BannerModel {
  final String title;
  final String img;
  final String des;

  const BannerModel({required this.title, required this.img, required this.des});
  factory BannerModel.json(json) => BannerModel(
    title: json['title'].toString(),
    img: json['img'].toString(),
    des: json['des'].toString(),
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

class HomeListProductModel {
  final String title;
  final List<HomeListItem> items;
  const HomeListProductModel({required this.title, required this.items});
  factory HomeListProductModel.json(Map<String, dynamic> json) => HomeListProductModel(
      title: json['title'].toString(),
      items: List.of(json['items']).map((e) => HomeListItem.json(e)).toList()
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
      items: List.of(json['items']).map<HomeGridItemModel>(
              (e) => HomeGridItemModel.json((e))
      ).toList()
  );

  HomeGridProductModel copy() => HomeGridProductModel(
      title: this.title,
      items: [...items]
  );
}

class HomeViewProvider with ChangeNotifier{

  HomeViewProvider(){
    Future(this._init);
  }
  Status isLoad = Status.Load;

  void _init() async {
    try{
      String _body = await this._fetch();
      this._homeDataModel = await compute(parse, _body);
      this.isLoad = Status.OK;
      this.notifyListeners();
    }catch(e){
      this.isLoad = Status.Fail;
      this.notifyListeners();
    }

  }

  static HomeDataModel parse(String body){
    Map<String, dynamic> _body = json.decode(body);
    // this._setBanner(_body['bn']);
    final List<BannerModel> _listBn = List.of(_body["bn"]).map((json) => BannerModel.json(json)).toList();
    // this._setHomeListProduct(_body['list']);
    final HomeListProductModel _listP = HomeListProductModel.json(_body["list"]);
    // this._setGridProduct(_body['grid']);
    final HomeGridProductModel _gridP = HomeGridProductModel.json(_body['grid']);

    return HomeDataModel(
        listBn: _listBn,
        listProductModel: _listP,
        gridProductModel: _gridP
    );
  }

  final String homeTitle = 'logo';
  // List<BannerModel>? _bannerData;
  // List<BannerModel>? get bannerData => [..._bannerData ?? []];
  //
  // // [BannerModel, BannerModel, ... ]
  // _setBanner(List<Map<String, dynamic>> bnJson){
  //   _bannerData = bnJson.map<BannerModel>(
  //       (e) => BannerModel.json(e)).toList();
  // }
  //
  // // title: "", items: [HomeListItem, HomeListItem, ...]
  // HomeListProductModel? _listProduct;
  // HomeListProductModel? get listProduct => this._listProduct?.copy();
  // void _setHomeListProduct(Map<String, dynamic> json){
  //   this._listProduct = HomeListProductModel.json(json);
  // }
  //
  // // title: "", items: [HomeGridItemModel, HomeGridItemModel, ...]
  // HomeGridProductModel? _gridProduct;
  // HomeGridProductModel? get gridProduct => this._gridProduct?.copy();
  //
  // void _setGridProduct(Map<String, dynamic> json) => this._gridProduct = HomeGridProductModel.json(json);

  HomeDataModel? _homeDataModel;
  HomeDataModel? get homeDataModel => this._homeDataModel?.copy();

  Future<String> _fetch() async {
    // HTTP
    return json.encode({
      "bn": [
        {
          "title": "BN001",
          "img": "https://cdn.pixabay.com/photo/2023/03/28/19/55/lake-7884049_640.jpg",
          "des": "first banner"
        }, {
          "title": "BN002",
          "img": "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
          "des": "second banner"
        }
      ],
      "list": {
        "title": "List1",
        "items": [
          {
            "title": "BN001",
            "img": "https://cdn.pixabay.com/photo/2023/03/28/19/55/lake-7884049_640.jpg",
            "des": "first banner"
          }, {
            "title": "BN002",
            "img": "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
            "des": "second banner"
          }
        ]
      },
      "grid": {
        "title": "GRID1",
        "items": [
          {
            "title": "GRID001",
            "img": "https://cdn.pixabay.com/photo/2023/03/28/19/55/lake-7884049_640.jpg",
          }, {
            "title": "GRID002",
            "img": "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
          }
        ]
      }
    });
  }
}