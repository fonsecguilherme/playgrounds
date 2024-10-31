import 'package:default_app/data/weather/weather_model.dart';
import 'package:default_app/data/weather/weather_repository.dart';
import 'package:flutter/material.dart';

void main() => runApp(const WeatherPage());

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  late Future<CityWeatherModel> weatherData;
  final WeatherRepository weatherRepository = WeatherRepository();

  @override
  void initState() {
    super.initState();
    weatherData = weatherRepository.getCityWeather(
      woeid: 455880,
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: FutureBuilder<CityWeatherModel>(
            future: weatherData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final result = snapshot.data!.results;
                return Center(
                    child: Text(
                        'O clima em ${result.cityName} é de ${result.temp}'));
              } else if (snapshot.hasError) {
                return const Center(child: Text('erro'));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      );
}
