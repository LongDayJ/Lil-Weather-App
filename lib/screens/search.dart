// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lil_weather/constants/color.dart';
import 'package:lil_weather/screens/search_bar.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        leading: 
          IconButton(onPressed: () {
            showSearch(context: context,
             delegate: PesquisaPage(),);

          }, icon: Icon(Icons.search_rounded),
          ),
      ),
      backgroundColor: BgColor.bgAppbarBlack,
      body: Container(
      child: SafeArea(
        child: Column(
        ),
      ),
    ),
    );
}

}