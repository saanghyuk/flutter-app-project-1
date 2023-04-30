import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterstudy2/components/peedCard.dart';

class PeedViewModel{
  final String uid;
  final String name;
  final String profileImg;
  final String img;
  const PeedViewModel({required this.uid, required this.name, required this.profileImg, required this.img});
}

class PeedView extends StatefulWidget {
  final ScrollController controller;
  final List<PeedViewModel> data;
  final FutureOr<void> Function(String uid, int index) onTap1;
  final FutureOr<void> Function(String uid, int index) onTap2;
  final FutureOr<void> Function(String uid, int index) onTap3;
  final FutureOr<void> Function() event;
  const PeedView({Key? key, required this.controller, required this.data, required this.onTap1, required this.onTap2, required this.onTap3, required this.event}) : super(key: key);

  @override
  State<PeedView> createState() => _PeedViewState();
}

class _PeedViewState extends State<PeedView> with AutomaticKeepAliveClientMixin{
  bool check = false;
  @override void initState() {
    // TODO: implement initState
    this.widget.controller.addListener(() async{
      if(check){
        return;
      }
      if(this.widget.controller.position.pixels > this.widget.controller.position.maxScrollExtent*.50){
        this.check=true;
        await this.widget.event();
        this.check = false;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _viewSize = MediaQuery.of(context).size;
    return Container(
      width: _viewSize.width,
      child: ListView.builder(
        controller: this.widget.controller,
        itemCount: this.widget.data.length,
        itemBuilder: (BuildContext context, int index){
          final PeedViewModel _model = this.widget.data[index];
          return PeedCard(
              name: _model.name,
              imgSrc: _model.img,
              imgSize: _viewSize.width,
              profileImgSrc: _model.profileImg,
              onTap1: (){
                this.widget.onTap1(_model.uid, index);
              },
              onTap2:(){
                this.widget.onTap2(_model.uid, index);
              },
              onTap3: (){
                this.widget.onTap3(_model.uid, index);
              }
          );
        },

      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}