import 'package:flutter/material.dart';

class City extends StatefulWidget{
  const City({super.key});

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      body: Container(

      child: SafeArea(
        child: Column(
          children: <Widget>[
            Spacer(),
            CityCard(),
            WetherCard(),
            Spacer(),
          ]
        ),
      ),
    ),
    );


 
  }
}

class CityCard extends StatefulWidget{
  const CityCard({super.key});

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  @override
  Widget build(BuildContext context){

    return Center(
      child: Card(
        child: SizedBox(

          width: 680,
          height: 430,
          child: Column(
            children:[Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Construtor_cidade("Thunderstorm", 56),
              Icon(Icons.star_border_outlined)
            ],
              //Cityicon vai ser uma variavel
             //Citytemp vai falar a temperatura da cidade
             //star button vai ser um botão para favoritar
            
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("uareizero"),
              Text("CityCountry"),
              //Cityname vai falar o nome da cidade
            ],
          ), 
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Construtor_clima("Thunderstorm", "00:00"),
              Construtor_clima("Thunderstorm", "00:00"),
              Construtor_clima("Thunderstorm", "00:00"),
              Construtor_clima("Thunderstorm", "00:00"),
              Construtor_clima("Thunderstorm", "00:00"),
          //row cheio de column clima com icon e horarios
          ],
          ),
            ],
          ),
        ),
      ),
  );
  }  
  Widget Construtor_cidade(String Clima, double Temperatura){
    return Row(
      children: [
        Row(
          children:[
            if (Clima == "Thunderstorm") Icon(Icons.thunderstorm_rounded),
            if (Clima == "Drizzle") Icon(Icons.foggy),
            if (Clima == "Rain") Icon(Icons.cloudy_snowing), 
            if (Clima == "Snow") Icon(Icons.ac_unit),
            if (Clima == "Clear") Icon(Icons.wb_sunny), 
            if (Clima == "Clouds") Icon(Icons.cloud),
            Text(Temperatura.toString()),
          ],
        )
    ],
    );
  }
}
 Widget Construtor_clima(String Clima, String horario){
    return Column(
      children: [
        Row(
          children:[
            if (Clima == "Thunderstorm") Icon(Icons.thunderstorm_rounded),
            if (Clima == "Drizzle") Icon(Icons.foggy),
            if (Clima == "Rain") Icon(Icons.cloudy_snowing), 
            if (Clima == "Snow") Icon(Icons.ac_unit),
            if (Clima == "Clear") Icon(Icons.wb_sunny), 
            if (Clima == "Clouds") Icon(Icons.cloud),
            Text(horario),
          ],
        )
    ],
    );
  }
class WetherCard extends StatefulWidget{
  const WetherCard({super.key});

  @override
  State<WetherCard> createState()=> _WetherCardState();
}

class _WetherCardState extends State<WetherCard>{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          width: 680,
          height: 589,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Construtor_Semanal("16/08/23", 56, "Thunderstorm", 56),
              Construtor_Semanal("16/08/23", 56, "Thunderstorm", 56),
              Construtor_Semanal("16/08/23", 56, "Thunderstorm", 56),
              Construtor_Semanal("16/08/23", 56, "Thunderstorm", 56),
              Construtor_Semanal("16/08/23", 56, "Thunderstorm", 56),
              ],
              )
          )
        ),
      );
  

  }
  Widget Construtor_Semanal(String Dia_da_Semana, int Umidade, String Clima, double Temperatura){

    return Row(
      children: [
        Text(Dia_da_Semana),
        Row(
          children: [
            Icon(Icons.water_drop_outlined),
            Text(Umidade.toString()),
          ],
        ),
        Row(
          children: [
            if (Clima == "Thunderstorm") Icon(Icons.thunderstorm_rounded),
            if (Clima == "Drizzle") Icon(Icons.foggy),
            if (Clima == "Rain") Icon(Icons.cloudy_snowing), 
            if (Clima == "Snow") Icon(Icons.ac_unit),
            if (Clima == "Clear") Icon(Icons.wb_sunny), 
            if (Clima == "Clouds") Icon(Icons.cloud),
            Text(Temperatura.toString()),
          ],
        ),
      ],
    );
  }

}


//uma classe chamada city card
//outra classe chamada wether card 
// uma card com sizedbox 680, 589
//row com 3 column a primeira colunm com o nome da cidade, a segunda com a humidade e a terceira com temperatura
