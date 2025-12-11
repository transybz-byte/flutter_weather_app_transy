import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../models/weather_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Mặc định gọi thời tiết "Thu Dau Mot" khi mở app
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().getWeather("Thu Dau Mot");
    });
  }

  // Logic chọn hình nền động
  String _getBackgroundImage(String? description) {
    if (description == null) return 'assets/images/bg_weather.png';
    String desc = description.toLowerCase();

    if (desc.contains('mưa') || desc.contains('rain'))
      return 'assets/images/rainy.png';
    if (desc.contains('mây') || desc.contains('cloud') || desc.contains('âm u'))
      return 'assets/images/cloudy.png';
    if (desc.contains('nắng') ||
        desc.contains('clear') ||
        desc.contains('quang')) return 'assets/images/sunny.png';

    return 'assets/images/bg_weather.png';
  }

  // Hộp thoại tìm kiếm
  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tìm thành phố"),
        content: TextField(
          controller: _searchController,
          decoration:
              const InputDecoration(hintText: "Nhập tên (VD: Hanoi, London)"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (_searchController.text.isNotEmpty) {
                context
                    .read<WeatherProvider>()
                    .getWeather(_searchController.text);
                _searchController.clear();
              }
            },
            child: const Text("Tìm"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final weather = provider.weather;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. Hình nền
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_getBackgroundImage(weather?.description)),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(color: Colors.black38), // Lớp phủ tối

          // 2. Nội dung chính
          SafeArea(
            child: provider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white))
                : provider.error.isNotEmpty
                    ? Center(
                        child: Text(provider.error,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)))
                    : RefreshIndicator(
                        onRefresh: () async {
                          if (weather != null) {
                            await context
                                .read<WeatherProvider>()
                                .getWeather(weather.cityName);
                          }
                        },
                        child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Colors.white, size: 24),
                                        const SizedBox(width: 8),
                                        Text(
                                          weather?.cityName ?? "---",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      DateFormat('EEEE, d MMM')
                                          .format(DateTime.now()),
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 16),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.search,
                                      color: Colors.white, size: 32),
                                  onPressed: _showSearchDialog,
                                )
                              ],
                            ),

                            const SizedBox(height: 40),

                            // Nhiệt độ lớn
                            Center(
                              child: Column(
                                children: [
                                  if (weather?.icon != null)
                                    Image.network(
                                      'https://openweathermap.org/img/wn/${weather!.icon}@4x.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                  Text(
                                    "${weather?.temperature.round() ?? 0}°",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 100,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  Text(
                                    weather?.description.toUpperCase() ?? "",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 40),

                            // --- HÀNG 1: Gió, Ẩm, Mưa ---
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _detailInfo(Icons.air,
                                      "${weather?.windSpeed} m/s", "Gió"),
                                  _detailInfo(Icons.water_drop,
                                      "${weather?.humidity}%", "Độ ẩm"),
                                  _detailInfo(
                                      Icons.umbrella,
                                      provider.forecast.isNotEmpty
                                          ? "${(provider.forecast[0].rainChance * 100).round()}%"
                                          : "0%",
                                      "Mưa"),
                                ],
                              ),
                            ),

                            const SizedBox(height: 15),

                            // --- HÀNG 2 (MỚI): Cảm giác, Mọc, Lặn ---
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _detailInfo(
                                      Icons.thermostat,
                                      "${weather?.feelsLike.round()}°",
                                      "Cảm giác"),
                                  _detailInfo(
                                      Icons.wb_sunny_outlined,
                                      weather != null
                                          ? DateFormat('HH:mm').format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  weather.sunrise * 1000))
                                          : "--:--",
                                      "Mọc"),
                                  _detailInfo(
                                      Icons.nightlight_round,
                                      weather != null
                                          ? DateFormat('HH:mm').format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  weather.sunset * 1000))
                                          : "--:--",
                                      "Lặn"),
                                ],
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Dự báo sắp tới
                            const Text("Dự báo sắp tới",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15),

                            SizedBox(
                              height: 160,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.forecast.length,
                                itemBuilder: (context, index) {
                                  final item = provider.forecast[index];
                                  final time = DateTime.parse(item.dateTime);

                                  return Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 12),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(DateFormat('HH:mm').format(time),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        Text(DateFormat('dd/MM').format(time),
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12)),
                                        const SizedBox(height: 5),
                                        Image.network(
                                            'https://openweathermap.org/img/wn/${item.icon}.png',
                                            width: 40),
                                        const SizedBox(height: 5),
                                        Text("${item.temperature.round()}°",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _detailInfo(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
