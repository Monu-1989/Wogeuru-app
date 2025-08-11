import 'package:flutter/material.dart';
import 'package:wogeuru/theme/theme.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamBackground,
      appBar: AppBar(
        title: const Text('Product Details'),
        // Colors come from global theme; no per-screen random colors
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryMaroon,
              ),
            ),
            const SizedBox(height: 10),

            // Description
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: product.tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: AppColors.creamBackground,
                  labelStyle: const TextStyle(color: AppColors.grayText),
                  shape: StadiumBorder(
                    side: BorderSide(color: AppColors.gold.withOpacity(0.5)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Price
            Text(
              "Price: ₹${product.price.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),

            // Emotional CTA Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("🌸 This creation is admired!"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: AppButtonStyles.primaryButton,
                icon: const Icon(Icons.favorite_border),
                label: const Text("I want this 💝"),
              ),
            ),

            const SizedBox(height: 30),

            // 🔍 SEO Preview (on-brand colors)
            const Text(
              "🔍 SEO Preview",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryMaroon,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.creamBackground),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Result title (styled like a link but brand color)
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.primaryMaroon,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description.length > 120
                        ? "${product.description.substring(0, 117)}..."
                        : product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "www.wogeuru.com/product/${product.slug}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.grayText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // WOGEURU Product Badge
            Row(
              children: [
                const Text(
                  "WOGEURU Badge: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  product.isGstVerified ? "🟢 Fully Verified" : "🟠 Basic Verified",
                  style: TextStyle(
                    fontSize: 16,
                    color: product.isGstVerified
                        ? AppColors.verifiedGreen
                        : AppColors.basicOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Microtags
            const Text(
              "Microtags:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryMaroon,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: product.microTags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: AppColors.creamBackground,
                  labelStyle: const TextStyle(color: AppColors.grayText),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
