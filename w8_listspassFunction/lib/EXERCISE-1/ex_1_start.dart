import 'package:flutter/material.dart';

List<String> colors = ["red", "blue", "green"];
List<String> numbers = ["Mon", "Tue", "Wed", "Thu"];
List<Widget> getLabels() {
  return colors.map((item) => Text(item)).toList();
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              //Todo
              Label("Method 1: Loop in Array", bold: true),
              Column(
                children: [
                  Text("Start"),
                  // for (var i = 0; i < 10; i++) Text('Item $i'),
                  for (var i = 0; i < colors.length; i++) Text(colors[i]),
                  Text("End"),
                ],
              ),

              Label("Method 2: Map", bold: true),
              Column(
                children: [
                  Text("Start"),
                  // ...numbers.map((item) => Text(item)).toList(),
                  ...colors.map((item) => Text(item)),
                  Text("End"),
                ],
              ),

              Label("Method 23: Dedicated Function", bold: true),
              Column(children: [
                Text("Start"), 
                ...getLabels(), 
                Text("End")]),
            ],
          ),
        ),
      ),
    ),
  );
}

class Label extends StatelessWidget {
  const Label(this.text, {super.key, this.bold = false});

  final bool bold;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: (bold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
