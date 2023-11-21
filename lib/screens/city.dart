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
      backgroundColor: Color.fromARGB(255, 45, 0, 170),
      body: Container(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
          children: <Widget>[
            CityCard(),
            WetherCard(),
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
        color: Color.fromARGB(255, 103, 76, 186),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children:[Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Construtor_cidade("Thunderstorm", 56),
              Icon(Icons.star_border_outlined)
            ],
              //Cityicon vai ser uma variavel
             //Citytemp vai falar a temperatura da cidade
             //star button vai ser um botão para favoritar
            
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              Text("Juareizero",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              )),
              Text("CityCountry"
              ,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
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
            if (Clima == "Thunderstorm") Icon(Icons.thunderstorm_rounded),
            if (Clima == "Drizzle") Icon(Icons.foggy),
            if (Clima == "Rain") Icon(Icons.cloudy_snowing), 
            if (Clima == "Snow") Icon(Icons.ac_unit),
            if (Clima == "Clear") Icon(Icons.wb_sunny), 
            if (Clima == "Clouds") Icon(Icons.cloud),
            Text(horario),
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
        color: Color.fromARGB(255, 103, 76, 186),
          child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 60),
        child: SizedBox(
          width: 350,
          height: 250,
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            
            children: [
              Spacer(),
              Construtor_Semanal("16/08/23", 56, "Thunderstorm", 56),
              Spacer(),
              Construtor_Semanal("16/08/23", 56, "Thunderstorm", 56),
              Spacer(),
              Construtor_Semanal("16/08/23", 56, "Thunderstorm", 56),
              Spacer(),
              Construtor_Semanal("16/08/23", 56, "Thunderstorm", 56),
              Spacer(),
              Construtor_Semanal("16/08/23", 56, "Thunderstorm", 56),
              Spacer(),
              ],
              )
          )
        ),
      ),
      );
  

  }
  Widget Construtor_Semanal(String Dia_da_Semana, int Umidade, String Clima, double Temperatura){
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
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
class FavoriteButton extends StatefulWidget{
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool standerSelect = false;
  @override
  Widget build(BuildContext context){
    return IconButton(
      isSelected: ,
      icon: Icon(Icons.star_border_outlined),

      onPressed: (){},
    );
  }
}

//uma classe chamada city card
//outra classe chamada wether card 
// uma card com sizedbox 680, 589
//row com 3 column a primeira colunm com o nome da cidade, a segunda com a humidade e a terceira com temperatura
