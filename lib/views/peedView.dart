import 'package:flutter/material.dart'; 

class PeedView extends StatefulWidget {
  final ScrollController controller;
  const PeedView({Key? key, required this.controller}) : super(key: key);

  @override
  State<PeedView> createState() => _PeedViewState();
}

class _PeedViewState extends State<PeedView> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final _viewSize = MediaQuery.of(context).size;
    return Container(
      width: _viewSize.width,
      child: ListView.builder(
          controller: this.widget.controller,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2022/08/15/15/38/animal-7388186_640.jpg"),
                        ),
                        Text("User ID $index")
                      ],
                    ),
                    Container(
                      width: _viewSize.width,
                      height: _viewSize.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://cdn.pixabay.com/photo/2023/03/16/02/10/couple-7855777_1280.jpg"),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: (){}, child: Text("LIKE", style: TextStyle())),
                        TextButton(onPressed: (){}, child: Text("LIKE", style: TextStyle())),
                        TextButton(onPressed: (){}, child: Text("LIKE", style: TextStyle())),
                      ],
                    )
                  ],
                ),
            ),
          )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
