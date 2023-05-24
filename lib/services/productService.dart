import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../repos/connect.dart';


class ProductModel{
  final List<BannerModel> listBn;
  final HomeListProductModel listProductModel;
  final HomeGridProductModel gridProductModel;
  const ProductModel({required this.listBn, required this.listProductModel, required this.gridProductModel});
  ProductModel copy() => ProductModel(
      listBn: [...listBn],
      listProductModel: listProductModel.copy(),
      gridProductModel: gridProductModel.copy()
  );
}


final class BannerModel {
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

final class HomeListItem{
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

final class HomeListProductModel {
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

final class HomeGridItemModel{
  final String title;
  final String img;
  const HomeGridItemModel({required this.title, required this.img});
  factory HomeGridItemModel.json(Map<String, dynamic> json) => HomeGridItemModel(
      title: json['title'].toString(),
      img: json['img'].toString()
  );
}

final class HomeGridProductModel{
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


abstract interface class ProductServiceInterface{

  Future<ProductModel> fetchIsolate({int limit = 10});

}

base class ProductServiceBase extends ProductServiceInterface{
  final Connect _connect = Connect();

  @override
  Future<ProductModel> fetchIsolate({int limit = 10}) async {
    final ConnectResModel _res = await this._connect.getReq(path: "path");
    // Compute가 Future를 리턴하다.
    return await compute(parse, _res.body);
  }

  static ProductModel parse(String body){
    Map<String, dynamic> _body = json.decode(body);
    // this._setBanner(_body['bn']);
    final List<BannerModel> _listBn = List.of(_body["bn"]).map((json) => BannerModel.json(json)).toList();
    // this._setHomeListProduct(_body['list']);
    final HomeListProductModel _listP = HomeListProductModel.json(_body["list"]);
    // this._setGridProduct(_body['grid']);
    final HomeGridProductModel _gridP = HomeGridProductModel.json(_body['grid']);

    return ProductModel(
          listBn: _listBn,
          listProductModel: _listP,
          gridProductModel: _gridP);
    }

}

final class ProductService extends ProductServiceBase{

}

