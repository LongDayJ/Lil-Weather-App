// ignore_for_file: prefer_const_constructors, unused_field, annotate_overrides, avoid_print, use_rethrow_when_possible

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lil_weather/constants/urls.dart';
import 'package:lil_weather/screens/city.dart';
import 'package:lil_weather/services/service.dart';

class PesquisaPage extends SearchDelegate<String> {
  Future<List<Map<String, dynamic>>>? _futureData;
  String get searchFieldLabel => 'Digite a cidade aqui Cidade';
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: _futureData = CallService().filtroDoFiltro(cityName: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => City(
                        cityName: snapshot.data![index]["cityName"],
                      ),
                    ),
                  );
                },
                title: Text(snapshot.data![index]["cityName"]),
                subtitle: Text(snapshot.data![index]["cityCountry"]),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Erro ao carregar os dados da API",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
