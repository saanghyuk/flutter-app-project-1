import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterstudy2/providers/status_enum.dart';
import 'package:flutterstudy2/services/productService.dart' as PD_Service;

import '../services/productService.dart';

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

  factory HomeDataModel.parse(PD_Service.ProductModel productModel){
    return HomeDataModel(
        listBn: (productModel.listBn as List<PD_Service.BannerModel>).map<BannerModel>(
                (PD_Service.BannerModel e) => BannerModel(
              title: e.title,
              img: e.img,
              des: e.des,
            )
        ).toList(),
        listProductModel: HomeListProductModel(
            title: productModel.listProductModel.title,
            items: productModel.listProductModel.items.map<HomeListItem>(
                    (PD_Service.HomeListItem e) => HomeListItem(
                  img: e.img,
                  des: e.des,
                  title: e.title,
                )
            ).toList()
        ),
        gridProductModel: HomeGridProductModel(
            title:productModel.gridProductModel.title,
            items: productModel.gridProductModel.items.map<HomeGridItemModel>(
                    (PD_Service.HomeGridItemModel e) => HomeGridItemModel(
                    title: e.title,
                    img: e.img
                )).toList()
        )
    );
  }
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

  final ProductService _productService = ProductService();

  HomeViewProvider(){
    Future(this._init);
  }
  Status isLoad = Status.Load;

  void _init() async {



    try{

      // String _body = await this._fetch();
      // this._homeDataModel = await compute(parse, _body);

      /// TODO ProductModel => HomeDataModel
      this._homeDataModel = HomeDataModel.parse(
          await this._productService.fetchIsolate()
      );

      this.isLoad = Status.OK;
      this.notifyListeners();
    }catch(e){
      print(e);
      this.isLoad = Status.Fail;
      this.notifyListeners();
    }

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


}