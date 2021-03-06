import 'location.dart';
import 'networking.dart';

const apiKey = '8d2b4aa0df73ae73cd995b44f01e3ce0';
const openWeatherMapApiUrl = 'https://api.openweathermap.org';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location usrLocation = Location();

    await usrLocation.getCurrentPosition();

    String url =
        '$openWeatherMapApiUrl/data/2.5/forecast?lat=${usrLocation.latitude}&lon=${usrLocation.longtitude}&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    String url =
        '$openWeatherMapApiUrl/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url: url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
