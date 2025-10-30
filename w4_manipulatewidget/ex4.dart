import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String cardText;
  final Color? cardColor; 
  final LinearGradient? cardGradient;

  const CustomCard({required this.cardText, this.cardColor = Colors.blue, this.cardGradient, super.key,});

  @override
  Widget build(BuildContext context) {
    final Decoration cardDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      gradient: cardGradient,
      color: cardGradient == null ? cardColor : null,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: cardDecoration, 
      child: Text(
        cardText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.bold, 
          fontSize: 30
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[350],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                CustomCard(
                  cardText: "OOP",
                  cardColor: Colors.blue[100],
                ),

                CustomCard(
                  cardText: "DART",
                  cardColor: Colors.blue[300],
                ),

                CustomCard(
                  cardText: "FLUTTER",
                  cardGradient: LinearGradient(
                    colors: [
                      Colors.blue[300]!,
                      Colors.blue[900]!, 
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
