import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lil_weather/constants/color.dart';

import 'package:lil_weather/constants/urls.dart';

class CallService {
    Future<List<Map<String, dynamic>>> filtroDoFiltro({required String cityName}) async {
    try {
      final response = await http.get(Uri.parse("${Constants.baseURL}$cityName"));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data =
            jsonDecode(utf8.decode(response.bodyBytes))["content"];
        print('Data: $data');
        return data
            .map((dynamic json) => json as Map<String, dynamic>)
            .toList();
      } else {
        throw Exception("Erro ao carregar os dados da API");
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
  
    Color WeatherIdentifier({required String weather}) {
    switch (weather) {
      case 'Thunderstorm':
        return BgColor.thunderstormBG;
      case 'Drizzle':
        return BgColor.drizzleBG;
      case 'Rain':
        return BgColor.rainBG;
      case 'Snow':
        return BgColor.snowBG;
      case 'Clear':
        return BgColor.clearBG;
      case 'Clouds':
        return BgColor.cloudsBG;
      default:
        return BgColor.clearBG;
    }
  }
}