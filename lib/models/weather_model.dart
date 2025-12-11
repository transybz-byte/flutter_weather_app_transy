class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final double rainChance;
  final String dateTime;
  
  // Các trường mới cho chức năng nâng cao
  final double feelsLike;
  final int sunrise;
  final int sunset;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    this.rainChance = 0.0,
    this.dateTime = '',
    required this.feelsLike,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '01d',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      rainChance: (json['pop'] as num?)?.toDouble() ?? 0.0,
      dateTime: json['dt_txt'] ?? '',
      // Lấy dữ liệu nâng cao
      feelsLike: (json['main']['feels_like'] as num?)?.toDouble() ?? 0.0,
      sunrise: json['sys']?['sunrise'] ?? 0,
      sunset: json['sys']?['sunset'] ?? 0,
    );
  }
}