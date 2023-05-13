

import 'package:flutterstudy2/views/homeView.dart';

import 'homeViewProvider.dart';

class BannerAdapter{
  static List<BnDataModel> BannerModel_2_BnDataModel({
    required List<BannerModel> bannerModel
  }){
    return bannerModel.map<BnDataModel>(
        (BannerModel model) => BnDataModel(
            title: model.title, img: model.img, des: model.des
        )
    ).toList();
  }
}
