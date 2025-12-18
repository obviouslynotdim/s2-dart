// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Forecast',
      home: WeatherForecastApp(),
    ),
  );
}

class WeatherForecastApp extends StatelessWidget {
  const WeatherForecastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.menu, color: Colors.white, size: 28),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          WeatherCard(
            city: 'Phnom Penh',
            minTemp: 10.0,
            maxTemp: 30.0,
            currentTemp: 12.2,
            weatherIcon: 'assets/cloudy.png',
            gradientColors: [Color(0xFFCC8BF7),Color(0xFFA189E9),],
          ),
          WeatherCard(
            city: 'Paris',
            currentTemp: 22.2,
            minTemp: 10.0,
            maxTemp: 40.0,
            weatherIcon: 'assets/sunnyCloudy.png',
            gradientColors: [Color(0xFF77DFBE), Color(0xFF60D3B1)],
          ),
          WeatherCard(
            city: 'Rome',
            currentTemp: 45.2,
            minTemp: 10.0,
            maxTemp: 40.0,
            weatherIcon: 'assets/sunny.png',
            gradientColors: [Color(0xFFF25C8E), Color(0xFFE2628C)],
          ),
          WeatherCard(
            city: 'Toulouse',
            currentTemp: 45.2,
            minTemp: 10.0,
            maxTemp: 40.0,
            weatherIcon: 'assets/veryCloudy.png',
            gradientColors: [Color(0xFFF8B786), Color(0xFFF1A671)],
          ),
        ],
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final String city;
  final double minTemp;
  final double maxTemp;
  final double currentTemp;
  final String weatherIcon;
  final List<Color> gradientColors;

  const WeatherCard({
    required this.city,
    required this.minTemp,
    required this.maxTemp,
    required this.currentTemp,
    required this.weatherIcon,
    required this.gradientColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: PhysicalModel(
        color: Colors.transparent,
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        shadowColor: Colors.black,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Gradient background
            Container(
              height: 110,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // Decorative circle (glow effect)
            Positioned(
              right: -40,
              top: -20,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white.withOpacity(0.9),
                        backgroundImage: AssetImage(weatherIcon),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            city,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Min ${minTemp.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Max ${maxTemp.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '${currentTemp.toStringAsFixed(1)}°C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
