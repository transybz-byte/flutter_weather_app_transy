import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  
  WeatherModel? _weather;
  List<WeatherModel> _forecast = [];
  bool _isLoading = false;
  String _error = '';

  WeatherModel? get weather => _weather;
  List<WeatherModel> get forecast => _forecast;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> getWeather(String city) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final results = await Future.wait([
        _weatherService.fetchCurrentWeather(city),
        _weatherService.fetchForecast(city),
      ]);
      _weather = results[0] as WeatherModel;
      _forecast = results[1] as List<WeatherModel>;
    } catch (e) {
      _error = "Không tìm thấy hoặc lỗi mạng.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}