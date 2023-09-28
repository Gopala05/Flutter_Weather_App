import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/UI/DetailPage.dart';
import 'package:flutter_weather_app/Widgets/Weather_Item.dart';
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

  void fetchdata(location) async {
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
    fetchdata(location);
    for(int i=0; i<selectedCities.length; i++) {
      cities.add(selectedCities[i].city);
    }
    super.initState();
  }

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRect(
                // borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset('assets/profile1.png', width: 40, height: 40,),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/pin.png', width: 20,),
                  const SizedBox(width: 4,),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: location,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: cities.map((String location)
                        {
                          return DropdownMenuItem(
                              value: location,
                              child: Text(location)
                          );
                        }).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            location = newValue!;
                            fetchdata(location);
                          });
                        }
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location, style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),),
            Text(currentDate, style: const TextStyle(
              color: Color(0xFF1565C0),
              fontSize: 22,
            ),),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                color: mycolours.primary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: mycolours.primary.withOpacity(.5),
                    offset: const Offset(0, 25),
                    blurRadius: 10,
                    spreadRadius: -12,
                  )
                ]
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -40,
                    left: 20,
                    child: imageUrl == ''? const Text('') : Image.asset('assets/$imageUrl.png', width: 160,),
                  ),
                  Positioned(
                    bottom: 25,
                    left: 20,
                    child: Text(weatherState, style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Positioned(
                    top: 20,
                      right: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                          child: Text(temperature.toString(), style: TextStyle(
                            fontSize: 65,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                          ),),),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('o', style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),),),
                        ],
                      ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherItem(
                    text: 'Wind Speed',
                    value: windSpeed,
                    unit: 'km/h',
                    imageUrl: 'assets/windspeed.png',
                  ),
                  WeatherItem(
                    text: 'Humidity',
                    value: humidity.toDouble(),
                    unit: '%',
                    imageUrl: 'assets/humidity.png',
                  ),
                  WeatherItem(
                    text: 'Max Temp',
                    value: maxTemp,
                    unit: 'C',
                    imageUrl: 'assets/max-temp.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Today", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),),
                Text("Next 7 days", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: mycolours.primary
                ),)
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: consolidatedWeatherList.length,
                itemBuilder: (BuildContext context, int index){
                  String today = DateTime.now().toString().substring(0,10);
                  var selectedDay = consolidatedWeatherList[index]['date'];
                  var futureWeatherName = consolidatedWeatherList[index]['day']['condition']['text'];
                  var weartherUrl = futureWeatherName.replaceAll('','').toLowerCase();

                  var parsedDate = DateTime.parse(consolidatedWeatherList[index]['date']);
                  var newDate = DateFormat('EEE').format(parsedDate).substring(0,3);
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(consolidatedWeatherList: consolidatedWeatherList, selectedId: index, location: location,)));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      margin: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
                      width: 82,
                      decoration: BoxDecoration(
                        color: selectedDay == today ? mycolours.primary : Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 7,
                            color: selectedDay == today ? mycolours.primary : Colors.black87.withOpacity(.2),
                          )
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(consolidatedWeatherList[index]['hour'][0]['temp_c'].toString()+" C", style: TextStyle(
                            fontSize: 18,
                            color: selectedDay == today ? Colors.white : mycolours.primary,
                            fontWeight: FontWeight.w500,
                          ),),
                          Image.asset('assets/' +weartherUrl+'.png', width: 35,),
                          Text(newDate, style: TextStyle(
                            fontSize: 18,
                            color: selectedDay == today ? Colors.white : mycolours.primary,
                            fontWeight: FontWeight.w500,
                          ),)
                        ],
                      ),
                    ),
                  );
                }))
          ],
        ),
      ),
    );
  }
}

