// lib/widgets/glass_card.dart
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Màu kính mờ
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.access_time, color: Colors.white70, size: 18),
              SizedBox(width: 8),
              Text("Dự báo 24h tới (Demo)", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 20),
          // Demo 3 ngày (Sau này sẽ lấy từ API thật)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _DailyItem(day: "Hôm nay", temp: "24°/31°", icon: Icons.wb_sunny),
              _DailyItem(day: "Mai", temp: "22°/30°", icon: Icons.cloud),
              _DailyItem(day: "Thứ 7", temp: "23°/29°", icon: Icons.beach_access),
            ],
          ),
        ],
      ),
    );
  }
}

class _DailyItem extends StatelessWidget {
  final String day;
  final String temp;
  final IconData icon;

  const _DailyItem({required this.day, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(day, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 5),
        Text(temp, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}