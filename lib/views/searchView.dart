
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy2/components/roundBorderText.dart';

import '../components/inputField.dart';

class SearchViewData{
  final String hintText;
  final List<String> keyword;
  final FutureOr<void> Function(int) onTap;
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
