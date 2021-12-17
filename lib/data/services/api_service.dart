import 'package:apod/data/helpers/constants.dart';
import 'package:apod/data/models/model.dart';
import 'package:http/http.dart' as http;

class APIService {
  // Get the Today's Picture
  static Future<Map<String, dynamic>> getTodaysPicture() async {
    try {
      final http.Response _apiResponse = await http.get(Uri.parse(url));
      if (_apiResponse.statusCode == 200) {
        final Model data = modelFromJson(_apiResponse.body);
        return {'status': true, 'data': data};
      } else {
        return {'status': false, 'error': 'Error in fetching the data'};
      }
    } on Exception catch (e) {
      return {'status': false, 'error': 'Error in fetching the data\n$e'};
    }
  }

  static Future<Map<String, dynamic>> getParticulerDatePicture(
      String date) async {
    try {
      final http.Response _apiResponse =
          await http.get(Uri.parse(url + "&date=$date"));
      if (_apiResponse.statusCode == 200) {
        final Model data = modelFromJson(_apiResponse.body);
        return {'status': true, 'data': data};
      } else {
        return {'status': false, 'error': 'Error in fetching the data'};
      }
    } on Exception catch (e) {
      return {'status': false, 'error': 'Error in fetching the data\n$e'};
    }
  }
}
