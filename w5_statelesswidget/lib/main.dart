import 'package:flutter/material.dart';
import 'package:ex1/widgets/gradian_button.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: const [
              GradianButton(inputText: "Hello 1"),
              GradianButton(inputText: "Hello 2"),
              GradianButton(inputText: "Hello 3"),
            ],
          ),
        ),
      ),
    )
  );
}