import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/weather_model.dart';

class WeatherService {
  // 1. Lấy thời tiết bằng Tên thành phố
  Future<WeatherModel> fetchCurrentWeather(String city) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}${ApiConfig.currentWeather}?q=$city&appid=${ApiConfig.apiKey}&units=metric&lang=vi'
    );
    return _fetchData(url);
  }

  // 2. Lấy thời tiết bằng Tọa độ GPS (Mới)
  Future<WeatherModel> fetchWeatherByLocation(double lat, double lon) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}${ApiConfig.currentWeather}?lat=$lat&lon=$lon&appid=${ApiConfig.apiKey}&units=metric&lang=vi'
    );
    return _fetchData(url);
  }

  // 3. Lấy dự báo 5 ngày
  Future<List<WeatherModel>> fetchForecast(String city) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}${ApiConfig.forecast}?q=$city&appid=${ApiConfig.apiKey}&units=metric&lang=vi'
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List listData = data['list'];
      return listData.map((e) => WeatherModel.fromJson(e)).toList();
    } else {
      throw Exception('Lỗi tải dự báo: ${response.statusCode}');
    }
  }

  // Hàm phụ để xử lý gọi API chung
  Future<WeatherModel> _fetchData(Uri url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Không tải được dữ liệu');
    }
  }
}