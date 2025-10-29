import 'package:flutter/material.dart';

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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    "OOP",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.blue[100],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    "DART",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.blue[300],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    "FLUTTER",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    gradient: LinearGradient(colors: [Colors.blue[300]!, Colors.blue[900]!]),
                  
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
