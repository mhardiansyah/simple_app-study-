// ignore_for_file: avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors

import 'dart:typed_data';

import 'package:app_simple/core/models/menu_items.dart';
import 'package:app_simple/service/menu_service.dart';
import 'package:app_simple/service/upload_sevice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class AddMenuScreen extends StatefulWidget {
  @override
  _AddMenuScreenState createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedCategory;
  int? _selectedSpicyLevel;
  bool _isAvailable = false;

  final List<String> _categories = ['Makanan', 'Minuman', 'Snack'];
  final List<int> _spicyLevels = List.generate(10, (index) => index + 1);

  Uint8List? imgData;
  String? imgUrl;
  Future pilihDanUploadImg() async {
    final image = await ImagePickerWeb.getImageAsBytes();
    if (image == null) return;

    setState(() {
      imgData = image;
    });
    final url = await uploadService().uploadImage(image);
    if (url != null) {
      setState(() {
        imgUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Menu'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama menu tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Harga Menu'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga menu tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(labelText: 'Kategori'),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Pilih kategori';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                value: _selectedSpicyLevel,
                decoration: InputDecoration(labelText: 'Spicy Level (1-10)'),
                items: _spicyLevels.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSpicyLevel = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Pilih spicy level';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: Text('Available'),
                value: _isAvailable,
                onChanged: (value) {
                  setState(() {
                    _isAvailable = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => pilihDanUploadImg(),
                child: Text('Upload Image'),
              ),
              SizedBox(height: 20),
              if (imgUrl != null) ...[
                Text("gambar terupload"),
                Image.network(imgUrl!),
                SizedBox(height: 20),
              ],
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    final newMenuitems = MenuItems(
                      name: _nameController.text,
                      price: int.parse(_priceController.text),
                      desc: _descriptionController.text,
                      category: _selectedCategory!,
                      spicyLevel: _selectedSpicyLevel!,
                      isAvailable: _isAvailable,
                      imgUrl: imgUrl,
                    );
                    MenuService().addMenu(newMenuitems, context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
