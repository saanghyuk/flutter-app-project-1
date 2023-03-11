import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Title"),
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
          controller : this._controller,
          child: Container()
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: (){},
      ),
    );
  }
}