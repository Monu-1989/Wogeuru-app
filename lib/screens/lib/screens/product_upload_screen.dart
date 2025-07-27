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
