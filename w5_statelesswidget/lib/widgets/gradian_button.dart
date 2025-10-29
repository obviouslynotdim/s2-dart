import 'package:flutter/material.dart';

class GradianButton extends StatelessWidget {
  final String inputText;

  const GradianButton({required this.inputText ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.all(30),
      
      child: Text(
        inputText,
        style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 78, 125, 245),
            Color.fromARGB(255, 7, 57, 185),
        ])
      ),
    );
  }
}