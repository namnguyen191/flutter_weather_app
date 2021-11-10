import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future getData() async {
    var urlObj = Uri.parse(url);

    http.Response response = await http.get(urlObj);

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      return decodedData;
    } else {
      // ignore: avoid_print
      print(response.statusCode);
    }
  }
}
