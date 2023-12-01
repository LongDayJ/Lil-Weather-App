// ignore_for_file: unused_element, prefer_const_constructors, use_rethrow_when_possible, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lil_weather/constants/color.dart';
import 'package:lil_weather/screens/city.dart';
import 'package:lil_weather/screens/search.dart';
import 'package:lil_weather/services/service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Map<String, dynamic>>>? _futureData;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _futureData = CallService().filtroDoFiltro(cityName: 'Pombos');
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  Color _getBgColor() {
    if (_isDarkMode != null && _isDarkMode == true) {
      return BgColor.bgAppbarBlack;
    } else {
      return BgColor.bgAppbarWhite;
    }
  }

  Color _getTextColor() {
    if (_isDarkMode != null && _isDarkMode == true) {
      return BgColor.bgAppbarWhite;
    } else {
      return BgColor.bgAppbarBlack;
    }
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
              backgroundColor: _getBgColor(),
              appBar: AppBar(
                backgroundColor: _getBgColor(),
                title: Text(
                  "Lil Weather",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getTextColor(),
                  ),
                ),
                centerTitle: true,
              ),
              drawer: Drawer(
                backgroundColor: _getBgColor(),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: IconButton(
                          onPressed: _closeDrawer,
                          icon: Icon(
                            Icons.close,
                            color: _getTextColor(),
                          )),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.brightness_6,
                        color: _getTextColor(),
                      ),
                      title: Text(
                        'Mudar Tema',
                        style: TextStyle(color: _getTextColor()),
                      ),
                      onTap: () {
                        _toggleTheme();
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.star,
                        color: _getTextColor(),
                      ),
                      title: Text('Favoritos',
                          style: TextStyle(color: _getTextColor())),
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
                        color: _getTextColor(),
                      ),
                      title: Text('Pesquisa',
                          style: TextStyle(color: _getTextColor())),
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
                    Center(
                      child: Image.network(
                        'https://i.imgur.com/e3fXDI6.png',
                        fit: BoxFit.fitWidth,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                    ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _getBgColor(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
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
                                color: _getTextColor(),
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data![index]["description1"] +
                                  ", " +
                                  snapshot.data![index]["cityCountry"],
                              style: TextStyle(
                                color: _getTextColor(),
                              ),
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
