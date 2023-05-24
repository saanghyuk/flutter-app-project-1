import 'package:http/http.dart' as http;
// 정의: HTTP 통신
// 사용 패키지: http

class ConnectResModel{
  final String body;
  final int statusCode;

  ConnectResModel(http.Response res):
        this.body = res.body,
        this.statusCode = res.statusCode;

}

abstract interface class ConnectInterface{
 Future<ConnectResModel> get({required String path});

}

base class Connect extends ConnectInterface{
  String endPoint = "";
  @override
  Future<ConnectResModel> get({required String path}) async {
    http.Response res = await http.get(Uri.parse(this.endPoint+path));
    return new ConnectResModel(res);
  }
}

final class Connect_Noel extends Connect{
  @override
  Future<ConnectResModel> get({required String path}) async {
    print("CONNECT_NOEL");
    return await super.get(path:path);
  }
}

ConnectInterface connect = Connect_Noel();

