import 'dart:convert';

import 'package:http/http.dart' as http;
// 정의: HTTP 통신
// 사용 패키지: http

class ConnectResModel{
  final String body;
  final int statusCode;

  ConnectResModel(http.Response res):
        this.body = res.body,
        this.statusCode = res.statusCode;

  ConnectResModel.test(String testBody)
      : this.body = testBody, statusCode = 200;

}

abstract interface class ConnectInterface{
  Future<ConnectResModel> getReq({required String path});

}

base class Connect extends ConnectInterface{
  String endPoint = "";
  @override
  Future<ConnectResModel> getReq({required String path}) async {
    // http.Response res = await http.get(Uri.parse(this.endPoint+path));
    // return new ConnectResModel(res);
    throw "PLEASE USE Connect_Noel, Connect_AWS, Connect_Local";
    // String _testBody = await this._fetch();
    // return ConnectResModel.test(_testBody);

  }
}

final class Connect_Noel extends Connect{
  @override
  Future<ConnectResModel> getReq({required String path}) async {
    print("CONNECT_NOEL");
    String _testBody = await this._fetch();
    return ConnectResModel.test(_testBody);
    // return await super.getReq(path:path);
  }

    Future<String> _fetch() async {
    // HTTP
          return json.encode({
              "bn": [
              {
              "title": "BN001",
              "img": "https://cdn.pixabay.com/photo/2023/03/28/19/55/lake-7884049_640.jpg",
              "des": "first banner"
              }, {
              "title": "BN002",
              "img": "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
              "des": "second banner"
              }
              ],
              "list": {
              "title": "List1",
              "items": [
              {
              "title": "BN001",
              "img": "https://cdn.pixabay.com/photo/2023/03/28/19/55/lake-7884049_640.jpg",
              "des": "first banner"
              }, {
              "title": "BN002",
              "img": "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
              "des": "second banner"
              }
              ]
              },
              "grid": {
              "title": "GRID1",
              "items": [
              {
              "title": "GRID001",
              "img": "https://cdn.pixabay.com/photo/2023/03/28/19/55/lake-7884049_640.jpg",
              }, {
              "title": "GRID002",
              "img": "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
              },
              {
              "title": "GRID003",
              "img": "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
              },
              {
              "title": "GRID004",
              "img": "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
              }
              ]
              }
          });
    }
}

// 배포 서버 연결
final class Connect_AWS extends Connect{
  @override
  String endPoint = "https://43.201.25.174";

  @override
  Future<ConnectResModel> getReq({required String path}) async {
    // TODO: implement getReq
    return ConnectResModel(await http.get(Uri.parse(this.endPoint+path)));
  }
}

// 개발 테스트 서버 연결
final class Connect_Local extends Connect{
  @override
  String endPoint = "http://172.30.1.57:3000";

  @override
  Future<ConnectResModel> getReq({required String path}) async {
    // TODO: implement getReq
    return ConnectResModel(await http.get(Uri.parse(this.endPoint+path)));
  }
}

