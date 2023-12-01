import 'package:lil_weather/data/fav_city_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'lil_weather.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(FavCityDao.tabela);
    },
    version: 1,
  );
}

