import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Static_models/Constant.dart';
import 'package:flutter_weather_app/UI/MainScreen.dart';
import '../Static_models/City.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    List<City> cities = City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> selected = City.getSelectedCities();
    Constant mycolors = Constant();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor:mycolors.primary,
        title:  Text("${selected.length} Selected"),
      ),
      body: ListView.builder(
        itemCount: cities.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: size.width,
              height: 70,
              decoration: BoxDecoration(
                border: cities[index].isSelected == true ? Border.all(
                  color: mycolors.secondary.withOpacity(1),
                  width: 1,
                ) : Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: mycolors.primary.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ]
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        cities[index].isSelected =! cities[index].isSelected;
                      });
                    },
                      child: Image.asset(cities[index].isSelected == true ? 'assets/checked.png' : 'assets/unchecked.png', width: 25 )),
                  const SizedBox(width: 10,),
                  Text(cities[index].city, style: TextStyle(
                    fontSize: 18,
                    color: cities[index].isSelected == true ? mycolors.secondary : Colors.black87,
                  ),)
                ],
              ),
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mycolors.secondary,
        child: const Icon(Icons.pin_drop),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
        },
      ),
    );
  }
}
