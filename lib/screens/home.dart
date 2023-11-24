// ignore_for_file: unused_element, prefer_const_constructors
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lil_weather/constants/color.dart';
import 'package:lil_weather/constants/urls.dart';
import 'package:lil_weather/screens/city.dart';
import 'package:lil_weather/screens/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = false;
  Future<List<Map<String, dynamic>>>? _futureData;
  late SharedPreferences prefs;

  Future<List<Map<String, dynamic>>> filtroDoFiltro() async {
    try {
      final response = await http.get(Uri.parse("${Constants.baseURL}Recife"));
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

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  void initState() {
    _futureData = filtroDoFiltro();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureData,
      builder: (context, snapshot) {
        {
          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar os dados"),
            );
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor:
                  _isDarkMode ? BgColor.BgAppbarBlack : BgColor.BgAppbarWhite,
              appBar: AppBar(
                backgroundColor:
                    _isDarkMode ? BgColor.BgAppbarBlack : BgColor.BgAppbarWhite,
                title: Text(
                  "Lil Weather",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode
                        ? BgColor.BgAppbarWhite
                        : BgColor.BgAppbarBlack,
                  ),
                ),
                centerTitle: true,
              ),
              drawer: Drawer(
                backgroundColor:
                    _isDarkMode ? BgColor.BgAppbarBlack : BgColor.BgAppbarWhite,
                child: Column(
                  children: [
                    DrawerHeader(
                      child: IconButton(
                          onPressed: _closeDrawer,
                          icon: Icon(
                            Icons.close,
                            color: _isDarkMode
                                ? BgColor.BgAppbarWhite
                                : BgColor.BgAppbarBlack,
                          )),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.brightness_6,
                        color: _isDarkMode
                            ? BgColor.BgAppbarWhite
                            : BgColor.BgAppbarBlack,
                      ),
                      title: Text(
                        'Mudar Tema',
                        style: TextStyle(
                            color: _isDarkMode
                                ? BgColor.BgAppbarWhite
                                : BgColor.BgAppbarBlack),
                      ),
                      onTap: () {
                        _toggleTheme();
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.star,
                        color: _isDarkMode
                            ? BgColor.BgAppbarWhite
                            : BgColor.BgAppbarBlack,
                      ),
                      title: Text('Favoritos',
                          style: TextStyle(
                              color: _isDarkMode
                                  ? BgColor.BgAppbarWhite
                                  : BgColor.BgAppbarBlack)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.search,
                        color: _isDarkMode
                            ? BgColor.BgAppbarWhite
                            : BgColor.BgAppbarBlack,
                      ),
                      title: Text('Pesquisa',
                          style: TextStyle(
                              color: _isDarkMode
                                  ? BgColor.BgAppbarWhite
                                  : BgColor.BgAppbarBlack)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Search())));
                      },
                    ),
                  ],
                ),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    //Image.asset("../assets/icons/LilW_Logo.png"),
                    ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => City(
                                        cityName: snapshot.data![index]
                                            ["cityName"],
                                      )),
                            );
                          },
                          title: Text(
                            snapshot.data![index]["cityName"],
                            style: TextStyle(
                              color: _isDarkMode
                                  ? BgColor.BgAppbarWhite
                                  : BgColor.BgAppbarBlack,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data![index]["description1"] +
                                ", " +
                                snapshot.data![index]["cityCountry"],
                            style: TextStyle(
                              color: _isDarkMode
                                  ? BgColor.BgAppbarWhite
                                  : BgColor.BgAppbarBlack,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
