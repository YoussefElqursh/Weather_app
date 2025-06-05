import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_check_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'varela',
      ),
      debugShowCheckedModeBanner: false,
      home: const LocationCheckScreen(),
    );
  }
}
