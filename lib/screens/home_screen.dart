import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WOGEURU'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Welcome to WOGEURU Seller App!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
import '../models/product_model.dart';

List<Product> mockProducts = [
  Product(
    title: "Handcrafted Jutti",
    description: "Made with love by artisans in Punjab.",
    price: 799.0,
    imageUrl: "https://i.imgur.com/8YwXc7W.png", // replace with your own later
    tags: ["handmade", "eco-friendly"],
  ),
  Product(
    title: "Eco Cotton Saree",
    description: "Sustainable, soft cotton in earthy tones.",
    price: 1299.0,
    imageUrl: "https://i.imgur.com/z1w1i7w.png",
    tags: ["eco-friendly"],
  ),
];
