import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, disabled }
enum IconPosition { left, right }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Custom button")),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                CustomButton(
                  label: 'Submit', 
                  icon: Icons.check,
                ),
                SizedBox(height: 16),
                CustomButton(
                  label: 'Time', 
                  icon: Icons.access_time,
                  buttonType: ButtonType.secondary,
                  iconPosition: IconPosition.right,
                ),
                SizedBox(height: 16),
                CustomButton(
                  label: 'Account', 
                  icon: Icons.account_tree,
                  buttonType: ButtonType.disabled,
                  iconPosition: IconPosition.right,
                ),
                
                ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconPosition iconPosition;
  final ButtonType buttonType;

  const CustomButton({
    required this.label,
    required this.icon,
    this.iconPosition = IconPosition.left,
    this.buttonType = ButtonType.primary,
    super.key,
  });

  Color get buttonColor {
    switch (buttonType) {
      case ButtonType.primary:
        return Colors.blue;
      case ButtonType.secondary:
        return Colors.green;
      case ButtonType.disabled:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: iconPosition == IconPosition.left
            ? [
                Icon(icon, color: Colors.blueGrey),
                SizedBox(width: 8),
                Text(label, style: const TextStyle(color: Colors.blueGrey, ),),
              ]
            : [
                Text(label, style: const TextStyle(color: Colors.blueGrey,),),
                SizedBox(width: 8),
                Icon(icon, color: Colors.blueGrey),
              ],
      ),
    );
  }
}
