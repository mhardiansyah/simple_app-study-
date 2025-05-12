// ignore_for_file: avoid_print

import 'package:app_simple/core/models/menu_items.dart';
import 'package:app_simple/service/menu_service.dart';
import 'package:flutter/material.dart';

class EditMenuScreen extends StatefulWidget {
  final MenuItems? menuItems;
  const EditMenuScreen({required this.menuItems, super.key});

  @override
  State<EditMenuScreen> createState() => _EditMenuScreenState();
}

class _EditMenuScreenState extends State<EditMenuScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedCategory;
  int? _selectedSpicyLevel;
  bool _isAvailable = false;

  final List<String> _categories = ['Makanan', 'Minuman', 'Snack'];
  final List<int> _spicyLevels = List.generate(10, (index) => index + 1);

  getData() {
    setState(() {
      _nameController.text = widget.menuItems!.name;
      _priceController.text = widget.menuItems!.price.toString();
      _descriptionController.text = widget.menuItems!.desc;
      _selectedCategory = widget.menuItems!.category;
      _selectedSpicyLevel = widget.menuItems!.spicyLevel;
      _isAvailable = widget.menuItems!.isAvailable;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Menu'),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    final newMenuitems = MenuItems(
                      id: widget.menuItems!.id,
                      name: _nameController.text,
                      price: int.parse(_priceController.text),
                      desc: _descriptionController.text,
                      category: _selectedCategory!,
                      spicyLevel: _selectedSpicyLevel!,
                      isAvailable: _isAvailable,
                    );
                    MenuService().updateMenu(newMenuitems, context);
                    print('Nama Menu: ${_nameController.text}');
                    print('Harga Menu: ${_priceController.text}');
                    print('Deskripsi: ${_descriptionController.text}');
                    print('Kategori: $_selectedCategory');
                    print('Spicy Level: $_selectedSpicyLevel');
                    print('Available: $_isAvailable');
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
