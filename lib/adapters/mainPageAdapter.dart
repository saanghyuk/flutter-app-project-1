

import 'package:flutter/cupertino.dart';
import 'package:flutterstudy2/pages/mainPage.dart';

import '../providers/homeViewProvider.dart';
import '../views/homeView.dart';


// abstract class MainPageAdapterImpl{}

abstract class MainPageAdapterInterface {
  List<BnDataModel> BannerModel_2_BnDataModel({required List<BannerModel> bannerModel});

  HomeViewGridItemListData grid({
    required HomeGridProductModel data,
    required  builder,
  });

}

class MainPageAdapter implements MainPageAdapterInterface{
  @override
  List<BnDataModel> BannerModel_2_BnDataModel({
    required List<BannerModel> bannerModel
  }){
    return bannerModel.map<BnDataModel>(
            (BannerModel model) => BnDataModel(
            title: model.title, img: model.img, des: model.des
        )
    ).toList();
  }

  final HomeViewAdapter homeViewAdapter = const HomeViewAdapter();

  @override
  HomeViewGridItemListData grid({
      required HomeGridProductModel data,
      required  builder
  }) {
    return HomeViewGridItemListData(
        builder: (BuildContext context, int index) => builder(
            data.items[index]
          ),
        title: data.title,
        itemCount: data.items.length,
        rowCount: 2
    );
  }
}

class HomeViewAdapter{
  const HomeViewAdapter();

  List<BnDataModel> BannerModel_2_BnDataModel({
    required List<BannerModel> bannerModel,
  }){
    return bannerModel.map<BnDataModel>(
            (BannerModel model) => BnDataModel(
            title: model.title, img: model.img, des: model.des
        )
    ).toList();
  }
}