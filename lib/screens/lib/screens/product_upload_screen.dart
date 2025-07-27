import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductUploadScreen extends StatefulWidget {
  @override
  _ProductUploadScreenState createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  String? _title, _description, _price, _quantity;
  List<File> _images = [];

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _images.add(File(picked.path));
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // For now, just print values
      print("Title: $_title");
      print("Description: $_description");
      print("Price: $_price");
      print("Quantity: $_quantity");
      print("Images: ${_images.length}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bring it to life'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Title'),
                onSaved: (value) => _title = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter product title' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter product description' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price (₹)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter price' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _quantity = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter quantity' : null,
              ),
              SizedBox(height: 10),
              Text('Upload Images (max 6):'),
              Wrap(
                spacing: 10,
                children: [
                  for (var img in _images)
                    Image.file(img, width: 80, height: 80, fit: BoxFit.cover),
                  if (_images.length < 6)
                    IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: _pickImage,
                    ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Bring it to life"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ProductUploadScreen extends StatefulWidget {
  @override
  _ProductUploadScreenState createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCategory;
  String? selectedSubcategory;

  final List<String> categories = ['Shoes', 'Clothing', 'Bags'];
  final Map<String, List<String>> subcategories = {
    'Shoes': ['Sandals', 'High Heels', 'Loafers'],
    'Clothing': ['Sarees', 'Kurtis', 'Punjabi Suits'],
    'Bags': ['Handmade Bags', 'Jute Bags', 'Laptop Bags'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Product'),
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
                decoration: InputDecoration(labelText: 'Product Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a product title' : null,
              ),

              // Description
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter description' : null,
              ),

              // Price
              TextFormField(
                decoration: InputDecoration(labelText: 'Price (₹)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter product price' : null,
              ),

              // Quantity
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter quantity available' : null,
              ),

              SizedBox(height: 20),

              // Category Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Category'),
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                    selectedSubcategory = null;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),

              // Subcategory Dropdown
              if (selectedCategory != null)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Subcategory'),
                  value: selectedSubcategory,
                  onChanged: (value) {
                    setState(() {
                      selectedSubcategory = value;
                    });
                  },
                  items: subcategories[selectedCategory]!
                      .map((sub) => DropdownMenuItem(
                            value: sub,
                            child: Text(sub),
                          ))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select a subcategory' : null,
                ),

              SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // To be added: Image upload + SEO preview logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Uploading product...')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade800,
                ),
                child: Text('Add to my joy ✨'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// IMAGE & VIDEO PICKING IMPORTS (top of file if not already)
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// INSIDE _ProductUploadScreenState:
List<XFile> _productImages = [];
XFile? _productVideo;
final ImagePicker _picker = ImagePicker();

Future<void> _pickImages() async {
  final List<XFile>? images = await _picker.pickMultiImage();
  if (images != null && images.length <= 6) {
    setState(() {
      _productImages = images;
    });
  }
}

Future<void> _pickVideo() async {
  final XFile? video = await _picker.pickVideo(
    source: ImageSource.gallery,
    maxDuration: const Duration(seconds: 30),
  );
  if (video != null) {
    setState(() {
      _productVideo = video;
    });
  }
}

// SEO Tags Controller
final TextEditingController _seoTagsController = TextEditingController();
final TextEditingController _seoDescriptionController = TextEditingController();

// GOOGLE PREVIEW AUTO FUNCTION
String generateSEOTitle(String title) {
  return '$title - Handcrafted Products Near You';
}

String generateSEODescription(String description) {
  return '$description. Buy directly from verified local artisans on WOGEURU.';
}
void _submitProduct() {
  if (_formKey.currentState!.validate()) {
    if (_selectedCategory == null || _selectedSubCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select category and subcategory')),
      );
      return;
    }

    if (_productImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload at least 1 image')),
      );
      return;
    }

    final Map<String, dynamic> productData = {
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'price': _priceController.text.trim(),
      'quantity': _quantityController.text.trim(),
      'category': _selectedCategory,
      'subcategory': _selectedSubCategory,
      'tags': _selectedTags,
      'seo_tags': _seoTagsController.text.trim(),
      'seo_description': _seoDescriptionController.text.trim(),
      'images': _productImages.map((img) => img.path).toList(),
      'video': _productVideo?.path ?? '',
    };

    // Placeholder for backend API call or local DB save
    print('Product Submitted:\n$productData');

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
