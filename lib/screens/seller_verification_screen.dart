import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellerVerificationScreen extends StatefulWidget {
  const SellerVerificationScreen({super.key});

  @override
  State<SellerVerificationScreen> createState() => _SellerVerificationScreenState();
}

class _SellerVerificationScreenState extends State<SellerVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _verificationLevel = 'Level 1 (Non-GST)';
  File? _aadhaarImage;
  File? _panImage;
  File? _gstImage;
  File? _shopLicenseImage;
  File? _selfieImage;
  String? _address;

  final picker = ImagePicker();

  Future<void> _pickImage(Function(File) onPicked) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      onPicked(File(picked.path));
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final isLevel2 = _verificationLevel == 'Level 2 (GST-Registered)';
    if (_aadhaarImage == null || _selfieImage == null || (isLevel2 && (_panImage == null || _gstImage == null || _shopLicenseImage == null))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload all required images.')),
      );
      return;
    }

    // Submit logic placeholder
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification submitted!')),
    );
  }

  Widget _buildImageUpload(String label, File? imageFile, Function(File) onPicked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _pickImage(onPicked),
          child: Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: imageFile != null
                ? Image.file(imageFile, fit: BoxFit.cover)
                : const Center(child: Text('Tap to upload')),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLevel2 = _verificationLevel == 'Level 2 (GST-Registered)';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify as Seller'),
        backgroundColor: const Color(0xFF800000), // Deep maroon
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Verification Level',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _verificationLevel,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'Level 1 (Non-GST)', child: Text('Level 1 (Non-GST)')),
                  DropdownMenuItem(value: 'Level 2 (GST-Registered)', child: Text('Level 2 (GST-Registered)')),
                ],
                onChanged: (value) {
                  setState(() => _verificationLevel = value!);
                },
              ),
              const SizedBox(height: 20),

              _buildImageUpload('Upload Aadhaar Card', _aadhaarImage, (file) => setState(() => _aadhaarImage = file)),
              _buildImageUpload('Take Live Selfie', _selfieImage, (file) => setState(() => _selfieImage = file)),

              if (isLevel2) ...[
                _buildImageUpload('Upload PAN Card', _panImage, (file) => setState(() => _panImage = file)),
                _buildImageUpload('Upload GST Certificate', _gstImage, (file) => setState(() => _gstImage = file)),
                _buildImageUpload('Upload Shop License', _shopLicenseImage, (file) => setState(() => _shopLicenseImage = file)),
              ],

              const Text(
                'Business Address',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter full address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Address is required' : null,
                onChanged: (value) => _address = value,
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF800000),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _submitForm,
                child: const Text(
                  'Be part of WOGEURU',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
