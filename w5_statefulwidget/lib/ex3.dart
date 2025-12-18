import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: ImageViewerPage()),
  );
}

class ImageViewerPage extends StatefulWidget {
  const ImageViewerPage({super.key});

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  int index = 3;

  final List<String> images = [
    "assets/bird.jpg",
    "assets/bird2.jpg",
    "assets/insect.jpg",
    "assets/girl.jpg",
    "assets/man.jpg",
  ];

  void nextImage() {
    setState(() {
      index = (index + 1) % images.length;
    });
  }

  void previousImage() {
    setState(() {
      index = (index - 1) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image viewer"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: previousImage,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios), 
            onPressed: nextImage
          ),
        ],
      ),

      body: Center(
        child: Image.asset(
          images[index], 
          fit: BoxFit.fill,
          width: double.infinity,
        )),
    );
  }
}
