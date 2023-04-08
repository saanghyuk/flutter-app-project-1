import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/roundBorderText.dart';


// Main에서 만들어서 넘겨줄 클래스
class SearchViewData{
  final String hintText;
  const SearchViewData({required this.hintText});
}


class SearchView extends StatefulWidget {
  final SearchViewData searchViewData;
  const SearchView({Key? key, required this.searchViewData}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with AutomaticKeepAliveClientMixin{
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _viewSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: _viewSize.width,
        child: Column(
          children: [
              InputField(controller: this._controller, hintText: this.widget.searchViewData.hintText),
              Wrap(
                spacing: 3.0,
                alignment: WrapAlignment.start,
                children: ["추천검색1", "검색1","추천검색2", "검색2","추천검색3", "검색3", "추천검색4", "추천검색5", "추천검색6"]
                    .map<Widget>((String txt) => RoundBorderText(
                                  txt: txt,
                                  onTap: (BuildContext context){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) => Scaffold(
                                        appBar: AppBar(
                                          title: Text(txt),
                                          ),
                                      )
                                      )
                                    );
                                  },
                    )
                ).toList(),
              )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class InputField extends StatelessWidget {
  final String hintText;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  const InputField({Key? key, this.onChanged, required this.controller, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
    CupertinoTextField(
      clearButtonMode: OverlayVisibilityMode.editing,
    )
        :
    Container(
      margin: EdgeInsets.all(20.0),
      child: Stack(
        children: [
          TextField(
            onChanged: this.onChanged,
            controller: this.controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(), // OutlineInputBorder
                hintText: this.hintText,
                counterText: ""
            ),
            maxLength: 10,
          ),
          Positioned(
              right: 0,
              top: 0,
              bottom:0,
              child: IconButton(icon: Icon(Icons.close), onPressed: (){},)
          )
        ],
      ),
    );
  }
}
