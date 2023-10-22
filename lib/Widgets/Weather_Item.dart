import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    super.key,
    required this.value, required this.text, required this.unit, required this.imageUrl,
  });

  final double value;
  final String text;
  final String unit;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: const TextStyle(
          color: Colors.black,
        ),),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(9.5),
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Color(0xFFFFb300),
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          child: Image.asset(imageUrl),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(value.toString()+" "+ unit, style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),)
      ],
    );
  }
}
