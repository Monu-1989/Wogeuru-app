import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductUploadScreen extends StatefulWidget {
  @override
  _ProductUploadScreenState createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _seoTagsController = TextEditingController();
  final TextEditingController _seoDescriptionController = TextEditingController();

  // Category + Subcategory
  String? _selectedCategory;
  String? _selectedSubCategory;

  final List<String> _categories = ['Shoes', 'Clothing', 'Bags'];
  final Map<String, List<String>> _subCategories = {
    'Shoes': ['Sandals', 'High Heels', 'Loafers'],
    'Clothing': ['Sarees', 'Kurtis', 'Punjabi Suits'],
    'Bags': ['Handmade Bags', 'Jute Bags', 'Laptop Bags'],
  };

  // Tags
  List<String> _selectedTags = [];

  // Images & Video
  final ImagePicker _picker = ImagePicker();
  List<XFile> _productImages = [];
  XFile? _productVideo;

  Future<void> _pickImages() async {
    final images = await _picker.pickMultiImage();
    if (images != null && images.length <= 6) {
      setState(() => _productImages = images);
    }
  }

  Future<void> _pickVideo() async {
    final video = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 30),
    );
    if (video != null) {
      setState(() => _productVideo = video);
    }
  }

  String generateSEOTitle(String title) {
    return '$title - Handcrafted Products Near You';
  }

  String generateSEODescription(String description) {
    return '$description. Buy directly from verified local artisans on WOGEURU.';
  }
  void _submitProduct() {
  // Basic field validations
  if (_titleController.text.isEmpty ||
      _descriptionController.text.isEmpty ||
      _priceController.text.isEmpty ||
      _quantityController.text.isEmpty ||
      selectedCategory == null ||
      selectedSubCategory == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please fill all required fields")),
    );
    return;
  }

  // At least 1 image required
  if (_imageFiles.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please upload at least one product image")),
    );
    return;
  }

  // Simulate backend save (you can replace this with real API later)
  print("📦 Uploading Product...");
  print("Title: ${_titleController.text}");
  print("Description: ${_descriptionController.text}");
  print("Price: ₹${_priceController.text}");
  print("Quantity: ${_quantityController.text}");
  print("Category: $selectedCategory");
  print("Subcategory: $selectedSubCategory");
  print("Tags: $_selectedTags");
  print("Images: ${_imageFiles.length}");
  print("Video: ${_videoFile != null ? 'Yes' : 'No'}");

  // Show success feedback
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Your product has been submitted 🎉")),
  );

  // Clear form (optional)
  _titleController.clear();
  _descriptionController.clear();
  _priceController.clear();
  _quantityController.clear();
  setState(() {
    selectedCategory = null;
    selectedSubCategory = null;
    _selectedTags.clear();
    _imageFiles.clear();
    _videoFile = null;
  });
}

  
      };

      print("Product Submitted:\n$productData");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🌸 Your creation is now ready to bloom on WOGEURU!'),
          duration: Duration(seconds: 3),
        ),
      );

      _formKey.currentState!.reset();
      setState(() {
        _selectedCategory = null;
        _selectedSubCategory = null;
        _selectedTags.clear();
        _productImages.clear();
        _productVideo = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bring it to life'),
        backgroundColor: Colors.deepPurple.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Product Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a product title' : null,
              ),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter description' : null,
              ),

              // Price
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price (₹)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter product price' : null,
              ),

              // Quantity
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter quantity available' : null,
              ),

              const SizedBox(height: 20),

              // Category
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category'),
                value: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                    _selectedSubCategory = null;
                  });
                },
                items: _categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),

              // Subcategory
              if (_selectedCategory != null)
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Subcategory'),
                  value: _selectedSubCategory,
                  onChanged: (value) {
                    setState(() => _selectedSubCategory = value);
                  },
                  items: _subCategories[_selectedCategory]!
                      .map((sub) =>
                          DropdownMenuItem(value: sub, child: Text(sub)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select a subcategory' : null,
                ),

              const SizedBox(height: 20),

              // IMAGE PICKER SECTION
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Upload up to 6 images:'),
                  ElevatedButton(
                    onPressed: _pickImages,
                    child: const Text('Pick Product Images'),
                  ),
                  Wrap(
                    spacing: 8,
                    children: _productImages
                        .map((img) => Image.file(File(img.path),
                            width: 80, height: 80, fit: BoxFit.cover))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  const Text('Optional: Upload a video (under 30 sec):'),
                  ElevatedButton(
                    onPressed: _pickVideo,
                    child: const Text('Pick Product Video'),
                  ),
                  if (_productVideo != null)
                    Text('Video selected: ${_productVideo!.name}'),
                ],
              ),

              const SizedBox(height: 20),

              // SEO Tags
              TextFormField(
                controller: _seoTagsController,
                decoration: const InputDecoration(
                    labelText: 'SEO Micro-Tags (comma-separated)'),
              ),
              TextFormField(
                controller: _seoDescriptionController,
                decoration: const InputDecoration(
                    labelText: 'Meta Description for SEO'),
              ),

              const SizedBox(height: 20),

              // GOOGLE PREVIEW
              const Text(
                '🔍 Google Result Preview:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                generateSEOTitle(_titleController.text),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              Text(
                'wogeuru.com/${_selectedCategory?.toLowerCase()}/${_selectedSubCategory?.toLowerCase()}/${_titleController.text.toLowerCase().replaceAll(' ', '-')}\n',
                style: const TextStyle(color: Colors.blue),
              ),
              Text(
                generateSEODescription(_seoDescriptionController.text),
                style: const TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 30),

              // SUBMIT BUTTON
              ElevatedButton(
  onPressed: _submitProduct,
  child: Text("Bring it to life"),
    style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade800            
)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
