import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Statefull Widget - Button")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonWidget(key: ValueKey('Button1')), 
              SizedBox(height: 20,),
              ButtonWidget(key: ValueKey('Button2')),
              SizedBox(height: 20,),
              ButtonWidget(key: ValueKey('Button3')),
              SizedBox(height: 20,),
              ButtonWidget(key: ValueKey('Button4')),
              
            ],
          )
        ),
      ),
    ),
  );
}

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({super.key});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String buttonText = _isSelected ? "Selected" : "Not Selected";
    final Color textColor = _isSelected ? Colors.white : Colors.black;
    final Color backgroundColor = _isSelected ? Colors.blue.shade500 : Colors.grey.shade300;

    return SizedBox(
      width: 400,
      height: 100,
      child: ElevatedButton(
        onPressed: _toggleSelection,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          textStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
          ),
        ),
      ),
    );
  }
}
