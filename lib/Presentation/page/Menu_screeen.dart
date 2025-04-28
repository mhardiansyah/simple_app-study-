// ignore_for_file: file_names

import 'package:app_simple/core/Routing/App_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuData = [
    {"no": 1, "menu": "Nasi Goreng", "penjualan": 120},
    {"no": 2, "menu": "Mie Ayam", "penjualan": 95},
    {"no": 3, "menu": "Sate Ayam", "penjualan": 150},
    {"no": 4, "menu": "Bakso", "penjualan": 110},
    {"no": 5, "menu": "Es Teh", "penjualan": 200},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Restaurant'),
        actions: [
          IconButton(
              onPressed: () {
                context.goNamed(Routes.home);
              },
              icon: Icon(Icons.arrow_back))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('No')),
              DataColumn(label: Text('Menu')),
              DataColumn(label: Text('Penjualan')),
              DataColumn(label: Text('Action')),
            ],
            rows: menuData.map((data) {
              return DataRow(cells: [
                DataCell(Text(data['no'].toString())),
                DataCell(Text(data['menu'])),
                DataCell(Text(data['penjualan'].toString())),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Tambahkan aksi edit di sini
                        context.goNamed(Routes.editmenu);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Konfirmasi'),
                              content: Text(
                                  'Apakah Anda yakin ingin menghapus menu ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Tutup dialog
                                  },
                                  child: Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Tambahkan aksi delete di sini
                                    Navigator.of(context).pop(); // Tutup dialog
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                )),
              ]);
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan aksi untuk tombol Add di sini
          context.goNamed(Routes.addmenu);
        },
        child: Icon(Icons.add),
        tooltip: 'Add Menu',
      ),
    );
  }
}
