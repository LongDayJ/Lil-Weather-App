import 'package:flutter/material.dart';
import 'package:lil_weather/data/database.dart';
import 'package:lil_weather/data/weather.dart';
import 'package:sqflite/sqflite.dart';

class FavCityDao {
  static const String tabela =
    'CREATE TABLE IF NOT EXISTS favoritos (id INTEGER PRIMARY KEY AUTOINCREMENT, cityName TEXT, description1 TEXT, cityCountry TEXT)';

  save(Weather weather) async {
    final Database db = await getDatabase();
    var itemExists =  await find(weather.cityName);
    Map<String, dynamic> weatherMap = toMap(weather);
    if (itemExists.isEmpty) {
      return await db.insert('favoritos', weatherMap);
    } else {
      return await db.update(
        'favoritos',
        weatherMap,
        where: 'cityName = ?',
        whereArgs: [weather.cityName],
      );
    }
  }

  Map<String, dynamic> toMap(Weather weather) {
    final Map<String, dynamic> weatherMap = Map();
    weatherMap['cityName'] = weather.cityName;
    weatherMap['description1'] = weather.description1;
    weatherMap['cityCountry'] = weather.cityCountry;
    return weatherMap;

  }

  Future<List<Weather>> findAll() async {
    print('Acessando o findAll: ');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('favoritos');
    print('Listando os favoritos: $result');
    return toList(result);
  }

  List<Weather> toList(List<Map<String, dynamic>> favCities) {
    print('convertendo para uma lista');
    final List<Weather> favCitiesList = [];
    for (Map<String, dynamic> linha in favCities) {
      final Weather favCity = Weather(
        linha['cityName'],
        linha['description1'],
        linha['cityCountry'],
      );
      favCitiesList.add(favCity);
    }
    return favCitiesList;
  }
  Future<List<Weather>> find(String cityName) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      'favoritos',
      where: 'cityName = ?',
      whereArgs: [cityName],
    );
    return toList(result);
  }

  delete(String cityName) async {
    final Database db = await getDatabase();
    return db.delete('favoritos', where: 'cityName = ?', whereArgs: [cityName]);
  }
}