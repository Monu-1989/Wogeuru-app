// seller_verification_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum VerificationLevel {
  nonGST,
  gstRegistered,
}

class SellerVerificationScreen extends StatefulWidget {
  const SellerVerificationScreen({super.key});

  @override
  State<SellerVerificationScreen> createState() => _SellerVerificationScreenState();
}

class _SellerVerificationScreenState extends State<SellerVerificationScreen> {
  VerificationLevel _selectedLevel = VerificationLevel.nonGST;

  final _formKey = GlobalKey<FormState>();

  // Common Fields
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  File? selfieImage;

  // GST-specific Fields
  final TextEditingController panController = TextEditingController();
  final TextEditingController gstinController = TextEditingController();
  File? shopLicenseImage;

  final ImagePicker _picker = ImagePicker();
