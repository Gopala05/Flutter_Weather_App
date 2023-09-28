import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Static_models/Constant.dart';
import 'package:flutter_weather_app/UI/Welcome.dart';
import 'package:flutter_weather_app/Widgets/Weather_Item.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final List consolidatedWeatherList;
  final int selectedId;
  final String location;
  const DetailPage({Key? key, required this.consolidatedWeatherList, required this.selectedId, required this.location}) : super(key : key );

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constant mycolours = Constant();

    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    int selectedIndex = widget.selectedId;
    var weatherState = widget.consolidatedWeatherList[selectedIndex]['day']['condition']['text'];
    imageUrl = weatherState.replaceAll('','').toLowerCase();
    return Scaffold(
      backgroundColor: mycolours.secondary,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mycolours.secondary,
        elevation: 0.0,
        title: Text(widget.location),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 9.0),
            child: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Welcome()));
                },
                icon: const Icon(Icons.settings)),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 10,
              left: 10,
            child: SizedBox(
              height: 150,
              width: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: widget.consolidatedWeatherList.length,
                  itemBuilder: (BuildContext context, int index){
                  var futureWeatherName = widget.consolidatedWeatherList[selectedIndex]['day']['condition']['text'];
                  var weatherUrl = futureWeatherName.replaceAll('','').toLowerCase();
                  var paresedDate = DateTime.parse(widget.consolidatedWeatherList[index]['date']);
                  var newDate = DateFormat('EEEE').format(paresedDate).substring(0,3);

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    margin: const EdgeInsets.only(right: 20),
                    width: 80,
                    decoration: BoxDecoration(
                      color: index == selectedIndex ? Colors.white : mycolours.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(11)),
                      boxShadow: [
                        BoxShadow(
                          offset:  const Offset(0, 1),
                          blurRadius: 8,
                          color:  Colors.cyanAccent.withOpacity(0.5),
                        )
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.consolidatedWeatherList[index]['hour'][0]['temp_c'].toString()+" C", style: TextStyle(
                          fontSize: 18,
                          color: index == selectedIndex  ? Colors.blueAccent : Colors.white,
                          fontWeight: FontWeight.w500,
                        ),),
                        Image.asset('assets/' + weatherUrl +'.png', width: 40,),
                        Text(newDate, style: TextStyle(
                          fontSize: 18,
                          color: index == selectedIndex ? Colors.blue : Colors.white ,
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    ),
                  );
                  }
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .55,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                )
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                      right: 20,
                      left: 20,
                      child: Container(
                        width: size.width*.7,
                        height: 300,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                              end: Alignment.topCenter,
                              colors:[
                                Color(0XFFA9C1F5),
                                 Color(0XFF6696F5),
                              ]),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(.1),
                              offset: const Offset(0, 25),
                              blurRadius: 3,
                              spreadRadius: -10,
                            ),
                          ]
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -40,
                                left: 20,
                                child: Image.asset('assets/'+imageUrl+'.png', width: 150,),
                            ),
                            Positioned(
                                top: 125,
                                left: 30,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(weatherState, style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                                ),),
                            Positioned(
                                bottom: 20,
                                left: 20,
                                child: Container(
                                  width: size.width * .8,
                                  padding: const  EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      WeatherItem(
                                        text: 'Wind Speed',
                                        value: widget.consolidatedWeatherList[0]['hour'][0]['wind_kph'],
                                        unit: 'km/h',
                                        imageUrl: 'assets/windspeed.png',
                                      ),
                                      WeatherItem(
                                        text: 'Humidity',
                                        value: widget.consolidatedWeatherList[0]['hour'][0]['humidity'].toDouble(),
                                        unit: '%',
                                        imageUrl: 'assets/humidity.png',
                                      ),
                                      WeatherItem(
                                        text: 'Max Temp',
                                        value: widget.consolidatedWeatherList[0]['day']['maxtemp_c'],
                                        unit: 'C',
                                        imageUrl: 'assets/max-temp.png',
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            Positioned(
                                top: 35,
                                right: 20,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.consolidatedWeatherList[selectedIndex]['hour'][0]['temp_c'].toString(), style: TextStyle(
                                      fontSize: 74,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()..shader = linearGradient,
                                    ),),
                                    Text('o', style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()..shader = linearGradient,
                                    ),),
                                  ],
                                ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Positioned(
                    top: 300,
                    child: SizedBox(
                      height: 200,
                      width: size.width ,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget.consolidatedWeatherList.length,
                          itemBuilder: (BuildContext context, int index){
                            var futureWeatherName = widget.consolidatedWeatherList[selectedIndex]['day']['condition']['text'];
                            var futureImageUrl = futureWeatherName.replaceAll('','').toLowerCase();
                            var paresedDate = DateTime.parse(widget.consolidatedWeatherList[index]['date']);
                            var newDate = DateFormat('d MMMM, EEEE').format(paresedDate);
                            return Container(
                              margin: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
                              height: 80,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: mycolours.secondary.withOpacity(.2),
                                      spreadRadius: 5,
                                      blurRadius: 20,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(newDate, style: const TextStyle(
                                      color: Color(0xFF6696F5),
                                    ),),
                                    Row(
                                      children: [
                                        Text(widget.consolidatedWeatherList[0]['day']['maxtemp_c'].toString(), style: const TextStyle(
                                          color: Color(0xFFFFb300),
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                        const Text('/', style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                        Text(widget.consolidatedWeatherList[0]['day']['mintemp_c'].toString(), style: const TextStyle(
                                          color: Color(0xFF1565C0),
                                          fontSize: 21,
                                        ),),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/'+futureImageUrl+'.png', width: 30,),
                                        if(futureWeatherName.toString().toLowerCase() == "patchy rain possible")...[
                                          Text("Patchy rain"),
                                        ] else if(futureWeatherName.toString().toLowerCase() == "thundery outbreaks possible")...[
                                          Text("Thundery outbreaks"),
                                        ]else if(futureWeatherName.toString().toLowerCase() == "light rain shower")...[
                                          Text("light rain"),
                                        ]else...[
                                          Text(futureWeatherName),
                                        ]
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
