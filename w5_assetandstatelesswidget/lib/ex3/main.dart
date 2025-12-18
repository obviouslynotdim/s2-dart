import 'package:flutter/material.dart';

enum Product {
  dart(
    image: 'lib/images/dart.png',
    title: 'Dart',
    description: 'the best object language',
  ),
  flutter(
    image: 'lib/images/flutter.png',
    title: 'Flutter',
    description: 'the best mobile widget library',
  ),
  firebase(
    image: 'lib/images/firebase.png',
    title: 'Firebase',
    description: 'the best cloud database',
  );

  final String title;
  final String description;
  final String image;

  const Product({
    required this.image,
    required this.title,
    required this.description,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Products")),
        backgroundColor: Colors.blue,
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              ProductCard(product: Product.dart),
              SizedBox(height: 16),
              ProductCard(product: Product.flutter),
              SizedBox(height: 16),
              ProductCard(product: Product.firebase),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product.image, width: 60, height: 60),
            const SizedBox(height: 10),
            Text(
              product.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(product.description, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
