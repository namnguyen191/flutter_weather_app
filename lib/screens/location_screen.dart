import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;

  const LocationScreen({Key? key, required this.locationWeather})
      : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String weatherMessage = '';
  String cityName = 'Default City Name';

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = 'your location';
        return;
      }

      double temp = weatherData['list'][0]['main']['temp'];
      temperature = temp.toInt();
      int condition = weatherData['cnt'];
      cityName = weatherData['city']['name'];

      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.green.withOpacity(0.95),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: TextButton(
                      onPressed: () async {
                        var weatherData =
                            await weatherModel.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: TextButton(
                      onPressed: () async {
                        var typedCityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CityScreen();
                            },
                          ),
                        );

                        if (typedCityName != null) {
                          var weatherData =
                              await weatherModel.getCityWeather(typedCityName);

                          updateUI(weatherData);
                        }
                      },
                      child: const Icon(
                        Icons.location_city,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
