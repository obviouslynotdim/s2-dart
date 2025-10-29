import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Container(
        margin: EdgeInsets.all(50),
        padding: EdgeInsets.all(40),
        color: Colors.blue[300],
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              "CADT STUDENTS",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );
}
