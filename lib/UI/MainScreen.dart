import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_app/Static_models/City.dart';
import 'package:flutter_weather_app/Static_models/Constant.dart';

import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Constant mycolours = Constant();
  double temperature = 0;
  double pressure = 0;
  double maxTemp = 0;
  String weatherState = "Loading...";
  int humidity = 0;
  double windSpeed = 0;

  var currentDate = "Loading...";
  String imageUrl = '';
  String location = "Bangalore";
  var selectedCities = City.getSelectedCities();
  List<String> cities = ['Bangalore'];
  List consolidatedWeatherList = [];

  // API
  String api = "http://api.weatherapi.com/v1/forecast.json?key=4687ce1e6cd34ffa94b115942231609&days=6&aqi=no&alerts=no&q=";

  void fetchdata() async {
    var weatherResult = await http.get(Uri.parse(api + location));
    var result = json.decode(weatherResult.body);
    var consolidate = result['forecast']['forecastday'];

    setState(() {
      for(int i=0; i<7; i++) {
        consolidate.add(consolidate[i]);
      }

      temperature = consolidate[0]['hour'][0]['temp_c'];
      pressure = consolidate[0]['hour'][0]['pressure_mb'];
      humidity = consolidate[0]['hour'][0]['humidity'];
      maxTemp = consolidate[0]['day']['maxtemp_c'];
      weatherState = consolidate[0]['hour'][0]['condition']['text'];
      windSpeed = consolidate[0]['hour'][0]['wind_kph'];

      var date = DateTime.parse(consolidate[0]['date']);
      currentDate = DateFormat("EEEE, d MMMM").format(date);
      imageUrl = weatherState.replaceAll('', '').toLowerCase();
      consolidatedWeatherList = consolidate.toSet().toList();
    });
  }
  @override
  void initState() {
    fetchdata();
    for(int i=0; i<selectedCities.length; i++) {
      cities.add(selectedCities[i].city);
    }
    super.initState();
  }

  final Shader LinearGrad = const LinearGradient(colors: <Color> [
     Color(0xFF9AC6F3)
  ],).createShader(const React.fronLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
    );
  }
}
