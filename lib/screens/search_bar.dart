import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lil_weather/screens/city.dart';

class PesquisaPage extends SearchDelegate<String>{
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: (){
        query = '';
      } , icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, '');
    }, 
    icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
   if (query.isEmpty){
    return Container();
   } return FutureBuilder<List>(
      future: sugestoes(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(snapshot.data![index]['cityName']),
                subtitle: Text(snapshot.data![index]['cityCountry']),
              );
            });
        }else if (snapshot.hasError){
          return Center(
            child: Text('Erro ao Pesquisar a Cidade!'),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }   );
  }
 Future<List<Map<String, dynamic>>> sugestoes() async {
      var url = Uri.parse('https://dw9lw.wiremockapi.cloud/city/$query');
var response = await http.get(url);
if (response. statusCode == 200){
return json.decode(response.body).map((dynamic json) => json as Map<String, dynamic>).tolist();
}
  throw Exception('Erro ao solicitar o produto pesquisado');
}
}
     

    