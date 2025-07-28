import 'package:flutter/material.dart';
import '../models/product_model.dart';

List<Product> mockProducts = [
  Product(
    title: "Handcrafted Jutti",
    description: "Made with love by artisans in Punjab.",
    price: 799.0,
    imageUrl: "https://i.imgur.com/8YwXc7W.png",
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WOGEURU'),
      ),
      body: Padding(
  padding: const EdgeInsets.all(12.0),
  child: ListView.builder(
    itemCount: mockProducts.length,
    itemBuilder: (context, index) {
      final product = mockProducts[index];
      return Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              if (product.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                   product.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 12),

              // Product Title
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              // Product Description
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              // Price
              Text(
                '₹${product.price}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple, // You can use maroon here
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Tags
              Wrap(
                spacing: 8,
                children: product.tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    backgroundColor: Colors.pink.shade50,
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              // Emotional Full-Width Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Show product details or share
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[700], // Maroon tone
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    "Show Your Creation 💖",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
),
