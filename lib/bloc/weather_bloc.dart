import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/screens/secret.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        WeatherFactory weatherFactory =
            WeatherFactory(apiKey, language: Language.ENGLISH);
        Weather weather = await weatherFactory.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);

        emit(WeatherSuccessState(weather));
        if (kDebugMode) {
          print(weather);
        }
      } catch (e) {
        emit(
          WeatherFailureState(),
        );
      }
    });

    on<FetchWeatherByCity>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        WeatherFactory weatherFactory =
            WeatherFactory(apiKey, language: Language.ENGLISH);
        Weather weather =
            await weatherFactory.currentWeatherByCityName(event.cityName);
        emit(WeatherSuccessState(weather));
        if (kDebugMode) {
          print(weather);
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(
          WeatherFailureState(),
        );
      }
    });
  }
}
