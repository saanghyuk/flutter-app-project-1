



import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy2/components/roundBorderText.dart';

class SearchViewData{
  final String hintText;
  final List<String> keyword;
  final void Function(int) onTap;
  const SearchViewData({required this.hintText, required this.keyword, required this.onTap});
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
            _searchInput(),
            _keywordBox(),
          ],
        ),
      ),
    );
  }

  Widget _searchInput() => InputField(controller: this._controller, hintText: this.widget.searchViewData.hintText);

  Widget _keywordBox(){
    if(this.widget.searchViewData.keyword.isEmpty) return Text("Nothing to recommend");
    return Wrap(
      spacing: 3.0,
      alignment: WrapAlignment.start,
      children: this.widget.searchViewData.keyword
          .map<Widget>((String txt) => RoundBorderText(
          txt: txt,
          onTap: (BuildContext context) async {
            final int _index = this.widget.searchViewData.keyword.indexOf(txt);
            await this.widget.searchViewData.onTap(_index);
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (_) => Scaffold(
            //       appBar: AppBar(
            //         title: Text(txt),
            //       ),
            //     ))
            // );
          }
      )
      ).toList(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class InputField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String hintText;
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