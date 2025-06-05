import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/weather.dart' as w;
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/secret.dart';
import 'package:weather_app/services/shared_preferences_service/shared_preferences_service.dart';
import 'package:weather_app/widget/build_weather_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextEditingController textEditingController = TextEditingController();
w.WeatherFactory weatherFactory = w.WeatherFactory(apiKey);

Widget getWeatherCode(int code) {
  switch (code) {
    case >= 300 && <= 321:
      return LottieBuilder.asset(
        'assets/animations/thunder.json',
        height: 250,
      );
    case >= 500 && <= 531:
      return LottieBuilder.asset(
        'assets/animations/rainy.json',
        height: 250,
      );
    case >= 600 && <= 622:
      return LottieBuilder.asset(
        'assets/animations/snow.json',
        height: 250,
      );
    case >= 801 && <= 804:
      return LottieBuilder.asset(
        'assets/animations/clouds.json',
        height: 250,
      );
    case >= 800:
      return LottieBuilder.asset(
        'assets/animations/sunny.json',
        height: 250,
      );
    default:
      return LottieBuilder.asset(
        'assets/animations/mist.json',
        height: 250,
      );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Scale sizes based on screen dimensions
    double scaleWidth(double size) => size * screenWidth / 375; // Base width
    double scaleHeight(double size) => size * screenHeight / 812; // Base height

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleWidth(20))
              .copyWith(top: 20),
          child: SizedBox(
            height: screenHeight,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: scaleHeight(300),
                    width: scaleWidth(300),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(3, -0.3),
                  child: Container(
                    height: scaleHeight(300),
                    width: scaleWidth(300),
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-3, -0.3),
                  child: Container(
                    height: scaleHeight(300),
                    width: scaleWidth(300),
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherSuccessState) {
                      final customWeather = mapToCustomWeather(state.weather);
                      SharedPreferencesService.saveWeatherData(customWeather);
                      var currentHour = state.weather.date!.hour;
                      String greeting;
                      if (currentHour >= 5 && currentHour < 12) {
                        greeting = "Good Morning !";
                      } else if (currentHour >= 12 && currentHour < 17) {
                        greeting = "Good Afternoon !";
                      } else if (currentHour >= 17 && currentHour < 21) {
                        greeting = "Good Evening !";
                      } else {
                        greeting = "Good Night !";
                      }

                      return SizedBox(
                        height: screenHeight,
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        var city =
                                            textEditingController.text.trim();
                                        debugPrint("Searched City: $city");
                                        if (city.isNotEmpty) {
                                          context
                                              .read<WeatherBloc>()
                                              .add(FetchWeatherByCity(city));
                                          textEditingController.text = '';
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text("Enter a location"),
                                            ),
                                          );
                                        }
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.search,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        Position position = await Geolocator
                                            .getCurrentPosition();
                                        // ignore: use_build_context_synchronously
                                        context
                                            .read<WeatherBloc>()
                                            .add(FetchWeather(position));
                                        textEditingController.text = '';
                                      },
                                      icon: const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                hintText: 'Enter the location',
                                hintStyle: const TextStyle(color: Colors.white),
                                focusedBorder: const OutlineInputBorder(
                                  gapPadding: 12,
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  gapPadding: 12,
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  gapPadding: 12,
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: scaleHeight(20),
                            ),
                            Text(
                              '📍${state.weather.areaName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: scaleWidth(16),
                              ),
                            ),
                            SizedBox(height: scaleHeight(6)),
                            Text(
                              greeting,
                              style: TextStyle(
                                fontSize: scaleWidth(22),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: scaleHeight(35)),
                            Center(
                              child: getWeatherCode(
                                  state.weather.weatherConditionCode!),
                            ),
                            SizedBox(height: scaleHeight(15)),
                            Center(
                              child: Text(
                                '${state.weather.temperature!.celsius!.round()}°C',
                                style: TextStyle(
                                  fontSize: scaleWidth(40),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${state.weather.weatherMain}',
                                style: TextStyle(
                                  fontSize: scaleWidth(25),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                DateFormat('EEEE dd *')
                                    .add_jm()
                                    .format(state.weather.date!),
                                style: TextStyle(
                                  fontSize: scaleWidth(14),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: scaleHeight(25)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildWeatherInfo(
                                  icon: Icons.sunny,
                                  color: Colors.yellow,
                                  label: "Sunrise",
                                  value: DateFormat()
                                      .add_jm()
                                      .format(state.weather.sunrise!),
                                  iconSize: scaleWidth(40),
                                  fontSize: scaleWidth(15),
                                ),
                                buildWeatherInfo(
                                  icon: CupertinoIcons.cloud_sun,
                                  color: Colors.orange,
                                  label: "Sunset",
                                  value: DateFormat()
                                      .add_jm()
                                      .format(state.weather.sunset!),
                                  iconSize: scaleWidth(45),
                                  fontSize: scaleWidth(15),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: scaleHeight(5),
                              ),
                              child: const Divider(
                                color: Colors.grey,
                                thickness: 0.3,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildWeatherInfo(
                                  icon: CupertinoIcons.thermometer_sun,
                                  color: Colors.redAccent,
                                  label: "Temp max",
                                  value:
                                      '${state.weather.tempMax!.celsius!.round()}° C',
                                  iconSize: scaleWidth(45),
                                  fontSize: scaleWidth(15),
                                ),
                                buildWeatherInfo(
                                  icon: CupertinoIcons.thermometer_snowflake,
                                  color: Colors.blue,
                                  label: "Temp min",
                                  value:
                                      '${state.weather.tempMin!.celsius!.round()}° C',
                                  iconSize: scaleWidth(45),
                                  fontSize: scaleWidth(15),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Made by Joo with ❤️',
                                  style: TextStyle(
                                    fontSize: scaleWidth(13),
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (state is WeatherLoadingState) {
                      return const Center(
                        child: Text(
                          'Please Wait',
                        ),
                      );
                    } else if (state is WeatherFailureState) {
                      return FutureBuilder<Weather?>(
                        future: SharedPreferencesService.getLastWeatherData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: Text('Loading last known data...'));
                          } else if (snapshot.hasData) {
                            final lastWeather = snapshot.data!;
                            var currentHour = lastWeather.date.hour;
                            String greeting;
                            if (currentHour >= 5 && currentHour < 12) {
                              greeting = "Good Morning !";
                            } else if (currentHour >= 12 && currentHour < 17) {
                              greeting = "Good Afternoon !";
                            } else if (currentHour >= 17 && currentHour < 21) {
                              greeting = "Good Evening !";
                            } else {
                              greeting = "Good Night !";
                            }
                            return Column(
                              children: [
                                SizedBox(
                                  height: screenHeight - 55,
                                  width: screenWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: const Text(
                                  '🚫No internet connection. Showing last known data🚫',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: scaleHeight(20),
                                      ),
                                      Text(
                                        '📍${lastWeather.areaName}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: scaleWidth(16),
                                        ),
                                      ),
                                      SizedBox(height: scaleHeight(6)),
                                      Text(
                                        greeting,
                                        style: TextStyle(
                                          fontSize: scaleWidth(22),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: scaleHeight(35)),
                                      Center(
                                        child: getWeatherCode(
                                          lastWeather.weatherConditionCode,
                                        ),
                                      ),
                                      SizedBox(height: scaleHeight(15)),
                                      Center(
                                        child: Text(
                                          '${lastWeather.temperatureCelsius.round()}°C',
                                          style: TextStyle(
                                            fontSize: scaleWidth(40),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          lastWeather.weatherMain,
                                          style: TextStyle(
                                            fontSize: scaleWidth(25),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          DateFormat('EEEE dd *')
                                              .add_jm()
                                              .format(lastWeather.date),
                                          style: TextStyle(
                                            fontSize: scaleWidth(14),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: scaleHeight(25)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          buildWeatherInfo(
                                            icon: Icons.sunny,
                                            color: Colors.yellow,
                                            label: "Sunrise",
                                            value: DateFormat()
                                                .add_jm()
                                                .format(lastWeather.sunrise),
                                            iconSize: scaleWidth(40),
                                            fontSize: scaleWidth(15),
                                          ),
                                          buildWeatherInfo(
                                            icon: CupertinoIcons.cloud_sun,
                                            color: Colors.orange,
                                            label: "Sunset",
                                            value: DateFormat()
                                                .add_jm()
                                                .format(lastWeather.sunset),
                                            iconSize: scaleWidth(45),
                                            fontSize: scaleWidth(15),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: scaleHeight(5),
                                        ),
                                        child: const Divider(
                                          color: Colors.grey,
                                          thickness: 0.3,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          buildWeatherInfo(
                                            icon:
                                                CupertinoIcons.thermometer_sun,
                                            color: Colors.redAccent,
                                            label: "Temp max",
                                            value:
                                                '${lastWeather.tempMaxCelsius.round()}° C',
                                            iconSize: scaleWidth(45),
                                            fontSize: scaleWidth(15),
                                          ),
                                          buildWeatherInfo(
                                            icon: CupertinoIcons
                                                .thermometer_snowflake,
                                            color: Colors.blue,
                                            label: "Temp min",
                                            value:
                                                '${lastWeather.tempMinCelsius.round()}° C',
                                            iconSize: scaleWidth(45),
                                            fontSize: scaleWidth(15),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Made by Joo with ❤️',
                                            style: TextStyle(
                                              fontSize: scaleWidth(13),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                                child: Text('Unable to load data'));
                          }
                        },
                      );
                    } else {
                      return const Center(child: Text('Please wait..'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
