import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                Container(
                  child: CustomCard(inputText: "OOP", color: Colors.blue[100]),
                ),
                Container(
                  child: CustomCard(inputText: "DART", color: Colors.blue[300]),
                ),
                Container(
                  child: CustomCard(
                    inputText: "FLUTTER",
                    cardGradient: LinearGradient(
                      colors: [Colors.blue[300]!, Colors.blue[900]!],
                    ),
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

class CustomCard extends StatelessWidget {
  final String inputText;
  final Color? color;
  final LinearGradient? cardGradient;

  const CustomCard({required this.inputText, this.color = Colors.blue, this.cardGradient, super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: cardGradient,
        color: cardGradient == null ? color:null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          inputText,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
