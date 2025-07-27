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
