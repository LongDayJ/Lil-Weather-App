import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lil_weather/constants/urls.dart';

/*
Future<List<Map<String, dynamic>>> filtroDoFiltro(List<Map<String, dynamic>> jsonDone) async {
  return jsonDecode(await http
        .get(Uri.http(Constants.baseURL, "/previsao"))
        .then((value) => value.body))["content"];
}
*/
