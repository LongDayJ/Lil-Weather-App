// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_element
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lil_weather/constants/color.dart';
import 'package:lil_weather/constants/urls.dart';
import 'package:lil_weather/screens/home.dart';
import 'package:lil_weather/screens/search.dart';

class City extends StatefulWidget {
  final String cityName;
	const City({required this.cityName, super.key});

	@override
	_CityState createState() => _CityState();
}

class _CityState extends State<City> {
	final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
	Future<List<Map<String, dynamic>>>? _futureData;
	bool _isDarkMode = false;
	bool _isFavorited = false;

	Future<List<Map<String, dynamic>>> filtroDoFiltro() async {
		try {
			final response = await http.get(Uri.parse(Constants.baseURL + widget.cityName));
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

	Color WeatherIdentifier(String weather) {
		switch (weather) {
			case 'Thunderstorm':
				return BgColor.ThunderstormBG;
			case 'Drizzle':
				return BgColor.DrizzleBG;
			case 'Rain':
				return BgColor.RainBG;
			case 'Snow':
				return BgColor.SnowBG;
			case 'Clear':
				return BgColor.ClearBG;
			case 'Clouds':
				return BgColor.CloudsBG;
			default:
				return BgColor.ClearBG;
		}
	}

	@override
	void initState() {
		_futureData = filtroDoFiltro();
		super.initState();
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

	void _toggleFavorite() {
		setState(() {
			_isFavorited = !_isFavorited;
		});
	}

	@override
	Widget build(BuildContext context) {
		return FutureBuilder(
			future: _futureData,
			builder: ((context, snapshot) {
				{
					if (snapshot.hasError) {
						return Center(
							child: Text("Erro ao carregar os dados"),
						);
					}
					if (snapshot.hasData && snapshot.data!.isNotEmpty) {
						return Scaffold(
							key: _scaffoldKey,
							backgroundColor: WeatherIdentifier(snapshot.data![0]['weather1']),
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
												Navigator.push(context, MaterialPageRoute(builder: ((context) => Search())));
											},
										),
									],
								),
							),
							body: SafeArea(
								child: ListView(
									physics: NeverScrollableScrollPhysics(),
									children: [
										CityCard(
												_isDarkMode
														? BgColor.BgAppbarBlack
														: BgColor.BgAppbarWhite,
												_isDarkMode
														? BgColor.BgAppbarWhite
														: BgColor.BgAppbarBlack,
												snapshot.data![0]['cityName'],
												snapshot.data![0]['cityCountry'],
												snapshot.data![0]['weather1'],
												snapshot.data![0]['weather2'],
												snapshot.data![0]['weather3'],
												snapshot.data![0]['weather4'],
												snapshot.data![0]['weather5'],
												snapshot.data![0]['temp1'],
												snapshot.data![0]['temp2'],
												snapshot.data![0]['temp3'],
												snapshot.data![0]['temp4'],
												snapshot.data![0]['temp5'],
												snapshot.data![0]['timer1'],
												snapshot.data![0]['timer2'],
												snapshot.data![0]['timer3'],
												snapshot.data![0]['timer4'],
												snapshot.data![0]['timer5'],
												snapshot.data![0]['description1']),
										WetherCard(
												_isDarkMode
														? BgColor.BgAppbarBlack
														: BgColor.BgAppbarWhite,
												_isDarkMode
														? BgColor.BgAppbarWhite
														: BgColor.BgAppbarBlack,
												snapshot.data![0]['timer5'],
												snapshot.data![0]['timer6'],
												snapshot.data![0]['timer7'],
												snapshot.data![0]['timer8'],
												snapshot.data![0]['timer9'],
												snapshot.data![0]['humidity5'],
												snapshot.data![0]['humidity6'],
												snapshot.data![0]['humidity7'],
												snapshot.data![0]['humidity8'],
												snapshot.data![0]['humidity9'],
												snapshot.data![0]['weather5'],
												snapshot.data![0]['weather6'],
												snapshot.data![0]['weather7'],
												snapshot.data![0]['weather8'],
												snapshot.data![0]['weather9'],
												snapshot.data![0]['temp5'],
												snapshot.data![0]['temp6'],
												snapshot.data![0]['temp7'],
												snapshot.data![0]['temp8'],
												snapshot.data![0]['temp9']),
									],
								),
							),
						);
					}
					return Center(
						child: CircularProgressIndicator(),
					);
				}
			}),
		);
	}
}

class CityCard extends StatefulWidget {
	final Color BgColor;
	final Color TextColor;
	final String cityName;
	final String cityCountry;
	final String Weather1;
	final String Weather2;
	final String Weather3;
	final String Weather4;
	final String Weather5;
	final String timer1;
	final String timer2;
	final String timer3;
	final String timer4;
	final String timer5;
	final double Temp1;
	final double Temp2;
	final double Temp3;
	final double Temp4;
	final double Temp5;
	final String description1;

	const CityCard(
			this.BgColor,
			this.TextColor,
			this.cityName,
			this.cityCountry,
			this.Weather1,
			this.Weather2,
			this.Weather3,
			this.Weather4,
			this.Weather5,
			this.Temp1,
			this.Temp2,
			this.Temp3,
			this.Temp4,
			this.Temp5,
			this.timer1,
			this.timer2,
			this.timer3,
			this.timer4,
			this.timer5,
			this.description1,
			{super.key});

	@override
	State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.fromLTRB(10, 15, 10, 2),
			child: Card(
				color: widget.BgColor,
				child: SizedBox(
					width: MediaQuery.of(context).size.width * 0.2,
					height: MediaQuery.of(context).size.height * 0.5 - kToolbarHeight,
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: [
							Padding(
								padding: const EdgeInsets.fromLTRB(25, 35, 25, 0),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: [
										Construtor_cidade(widget.Weather1, widget.Temp1),
										Icon(
											Icons.star_border_outlined,
											color: widget.TextColor,
										)
									],
								),
							),
							Column(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: [
									Text(
										widget.cityName,
										style: TextStyle(
											fontSize: 28,
											fontWeight: FontWeight.bold,
											color: widget.TextColor,
										),
									),
									Text(
										widget.description1 + ", " + widget.cityCountry,
										style: TextStyle(
											fontWeight: FontWeight.normal,
											fontSize: 20,
											color: widget.TextColor,
										),
									),
								],
							),
							Padding(
								padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceEvenly,
									children: [
										Construtor_clima(
												widget.Weather1, widget.timer1.split(" ")[1]),
										Construtor_clima(
												widget.Weather2, widget.timer2.split(" ")[1]),
										Construtor_clima(
												widget.Weather3, widget.timer3.split(" ")[1]),
										Construtor_clima(
												widget.Weather4, widget.timer4.split(" ")[1]),
										Construtor_clima(
												widget.Weather5, widget.timer5.split(" ")[1]),
									],
								),
							),
						],
					),
				),
			),
		);
	}

	Widget Construtor_cidade(String Clima, double Temperatura) {
		return Row(
			children: [
				Row(
					children: [
						if (Clima == "Thunderstorm")
							Icon(
								Icons.thunderstorm_rounded,
								color: widget.TextColor,
							),
						if (Clima == "Drizzle")
							Icon(
								Icons.foggy,
								color: widget.TextColor,
							),
						if (Clima == "Rain")
							Icon(
								Icons.cloudy_snowing,
								color: widget.TextColor,
							),
						if (Clima == "Snow")
							Icon(
								Icons.ac_unit,
								color: widget.TextColor,
							),
						if (Clima == "Clear")
							Icon(
								Icons.wb_sunny,
								color: widget.TextColor,
							),
						if (Clima == "Clouds")
							Icon(
								Icons.cloud,
								color: widget.TextColor,
							),
						Text(
							" ${Temperatura.toInt()}ºC",
							style: TextStyle(color: widget.TextColor),
						),
					],
				)
			],
		);
	}

	Widget Construtor_clima(String Clima, String horario) {
		return Column(
			children: [
				if (Clima == "Thunderstorm")
					Icon(
						Icons.thunderstorm_rounded,
						color: widget.TextColor,
					),
				if (Clima == "Drizzle")
					Icon(
						Icons.foggy,
						color: widget.TextColor,
					),
				if (Clima == "Rain")
					Icon(
						Icons.cloudy_snowing,
						color: widget.TextColor,
					),
				if (Clima == "Snow")
					Icon(
						Icons.ac_unit,
						color: widget.TextColor,
					),
				if (Clima == "Clear")
					Icon(
						Icons.wb_sunny,
						color: widget.TextColor,
					),
				if (Clima == "Clouds")
					Icon(
						Icons.cloud,
						color: widget.TextColor,
					),
				Text(horario, style: TextStyle(color: widget.TextColor)),
			],
		);
	}
}

class WetherCard extends StatefulWidget {
	final Color BgColor;
	final Color TextColor;
	final String timer1;
	final String timer2;
	final String timer3;
	final String timer4;
	final String timer5;
	final int Humidity1;
	final int Humidity2;
	final int Humidity3;
	final int Humidity4;
	final int Humidity5;
	final String Weather1;
	final String Weather2;
	final String Weather3;
	final String Weather4;
	final String Weather5;
	final double temp1;
	final double temp2;
	final double temp3;
	final double temp4;
	final double temp5;

	const WetherCard(
			this.BgColor,
			this.TextColor,
			this.timer1,
			this.timer2,
			this.timer3,
			this.timer4,
			this.timer5,
			this.Humidity1,
			this.Humidity2,
			this.Humidity3,
			this.Humidity4,
			this.Humidity5,
			this.Weather1,
			this.Weather2,
			this.Weather3,
			this.Weather4,
			this.Weather5,
			this.temp1,
			this.temp2,
			this.temp3,
			this.temp4,
			this.temp5,
			{super.key});

	@override
	State<WetherCard> createState() => _WetherCardState();
}

class _WetherCardState extends State<WetherCard> {
	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
			child: Card(
					color: widget.BgColor,
					child: SizedBox(
							width: MediaQuery.of(context).size.width * 0.95,
							height: MediaQuery.of(context).size.height * 0.4,
							child: Column(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: [
									Text("Previsão Semanal",
											style: TextStyle(
												fontSize: 28,
												fontWeight: FontWeight.bold,
												color: widget.TextColor,
											)),
									Construtor_Semanal(widget.timer1.split(' ')[0],
											widget.Humidity1, widget.Weather1, widget.temp1),
									Construtor_Semanal(widget.timer2.split(' ')[0],
											widget.Humidity2, widget.Weather2, widget.temp2),
									Construtor_Semanal(widget.timer3.split(' ')[0],
											widget.Humidity3, widget.Weather3, widget.temp3),
									Construtor_Semanal(widget.timer4.split(' ')[0],
											widget.Humidity4, widget.Weather4, widget.temp4),
									Construtor_Semanal(widget.timer5.split(' ')[0],
											widget.Humidity5, widget.Weather5, widget.temp5),
								],
							))),
		);
	}

	Widget Construtor_Semanal(
			String Dia_da_Semana, int Umidade, String Clima, double Temperatura) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: [
				Text(Dia_da_Semana, style: TextStyle(color: widget.TextColor)),
				Row(
					children: [
						Icon(
							Icons.water_drop_outlined,
							color: widget.TextColor,
						),
						Text("$Umidade%", style: TextStyle(color: widget.TextColor)),
					],
				),
				Row(
					children: [
						if (Clima == "Thunderstorm")
							Icon(
								Icons.thunderstorm_rounded,
								color: widget.TextColor,
							),
						if (Clima == "Drizzle")
							Icon(
								Icons.foggy,
								color: widget.TextColor,
							),
						if (Clima == "Rain")
							Icon(
								Icons.cloudy_snowing,
								color: widget.TextColor,
							),
						if (Clima == "Snow")
							Icon(
								Icons.ac_unit,
								color: widget.TextColor,
							),
						if (Clima == "Clear")
							Icon(
								Icons.wb_sunny,
								color: widget.TextColor,
							),
						if (Clima == "Clouds")
							Icon(
								Icons.cloud,
								color: widget.TextColor,
							),
						Text(
							" ${Temperatura.toInt()} °C",
							style: TextStyle(color: widget.TextColor),
						),
					],
				),
			],
		);
	}
}
