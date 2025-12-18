import 'package:flutter/material.dart';

void main() {
  runApp(MyHobbies());
}

class MyHobbies extends StatelessWidget {
  const MyHobbies({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("My Hobbies")),
        backgroundColor: Colors.grey[500],
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            children: [
              HobbyCard(
                title: "Travelling",
                icon: Icons.travel_explore, 
                backgroundColor: Colors.green),
              SizedBox(height: 10),
              HobbyCard(
                title: "Skating",
                icon: Icons.skateboarding),
            ],
          ),
        ),
      ),
    );
  }
}

class HobbyCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;

  const HobbyCard({required this.title, required this.icon, this.backgroundColor = Colors.blue ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
