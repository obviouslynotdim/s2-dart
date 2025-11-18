import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: SeasonsApp()),
);

enum Season { winter, spring, summer, fall }

class SeasonsApp extends StatelessWidget {
  const SeasonsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SEASONS',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Tap a card to advance the season!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SeasonCard(
                    countryName: 'FRANCE',
                    initialSeason: Season.winter,
                  ),
                  SeasonCard(
                    countryName: 'CAMBODIA',
                    initialSeason: Season.summer,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeasonCard extends StatefulWidget {
  const SeasonCard({
    super.key,
    required this.countryName,
    required this.initialSeason,
  });

  final String countryName;
  final Season initialSeason;

  @override
  State<SeasonCard> createState() => _SeasonCardState();
}

class _SeasonCardState extends State<SeasonCard> {
  late Season _currentSeason;

  // season mapping
  static const Map<Season, String> _seasonImages = {
    Season.winter: 'assets/winter.jpg',
    Season.spring: 'assets/spring.jpg',
    Season.summer: 'assets/summer.jpg',
    Season.fall: 'assets/fall.jpg',
  };

  @override
  void initState() {
    super.initState();
    _currentSeason = widget.initialSeason;
  }

  Season _getNextSeason(Season current) {
    const List<Season> customOrder = [
      Season.summer,
      Season.spring,
      Season.winter,
      Season.fall,
    ];
    final int currentIndex = customOrder.indexOf(current);
    return customOrder[(currentIndex + 1) % customOrder.length];
  }

  void _cycleSeason() {
    setState(() {
      _currentSeason = _getNextSeason(_currentSeason);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String seasonImg = _seasonImages[_currentSeason]!;
    const double cardWidth = 150;
    const double cardHeight = 280;

    return GestureDetector(
      onTap: _cycleSeason,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,

          border: Border.all(color: Color(0xFFE0E0E0), width: 1.5),
        ),
        child: Column(
          children: [
            // image
            Expanded(
              child: Image.asset(
                seasonImg,
                width: cardWidth,
                height: cardHeight,
                fit: BoxFit.cover,
              ),
            ),

            // country name (FRANCE, CAMBODIA)
            Container(
              padding: const EdgeInsets.all(12),
              child: Text(
                widget.countryName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
