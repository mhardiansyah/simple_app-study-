import 'dart:js_interop';

import 'package:app_simple/Presentation/widget/cardItems.dart';
import 'package:app_simple/core/models/cart_items.dart';
import 'package:app_simple/core/models/menu_items.dart';
import 'package:app_simple/service/menu_service.dart';
import 'package:app_simple/service/transaksi_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransectionScreen extends StatefulWidget {
  @override
  State<TransectionScreen> createState() => _TransectionScreenState();
}

class _TransectionScreenState extends State<TransectionScreen> {
  List<CartItems> listcart = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<MenuItems>>(
          stream: MenuService().getMenu(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No items available.'));
            } else {
              final List<MenuItems> menuItems = snapshot.data!;

              return Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2, // Jumlah item per baris
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(menuItems.length, (index) {
                      final item = menuItems[index];
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            item.imgUrl.toString(),
                                            height: 100,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                item.name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '\$${item.price.toString()}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  try {
                                    final exxisttingItem = listcart.firstWhere(
                                        (element) =>
                                            element.menuItems.id == item.id);
                                    exxisttingItem.quantity += 1;

                                    print("jalannn");
                                  } catch (e) {
                                    final newCartItems = CartItems(
                                      menuItems: item,
                                      quantity: 1,
                                    );
                                    listcart.add(newCartItems);
                                    print("catch");
                                  }
                                });
                              },
                              child: const Text('Add to Cart'),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -3), // Shadow appears above the bar
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                'Items in Cart: ${listcart.fold(0, (sum, items) => sum + items.quantity)}'),
            Text(
              'Total Price: \$${listcart.fold(0, (sum, items) => sum + items.menuItems.price * items.quantity)}',
            ),
            ElevatedButton(
              onPressed: () {
                showdialogpaymet(context);
              },
              child: const Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }

  showdialogpaymet(BuildContext context) {
    final totalPrice = listcart.fold(
        0, (sum, items) => sum + items.menuItems.price * items.quantity);
    final tax = totalPrice * 0.1;
    final grandFinal = totalPrice + tax;
    TextEditingController payment = TextEditingController();
    double kembalian = 0;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                title: Text('Payment'),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('Total Price: \$${totalPrice}'),
                  Text('Tax: \$${tax}'),
                  Text('Grand Total: \$${grandFinal}'),
                  Text('Payment Method'),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: payment,
                    decoration: InputDecoration(
                      labelText: 'Enter Payment',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        kembalian = int.parse(payment.text) - grandFinal;
                      });
                    },
                  ),
                  // ignore: unnecessary_brace_in_string_interps
                  Text('Kembalian: \$${kembalian}'),
                  ElevatedButton(
                      onPressed: () {
                        TransaksiService().savetransaksi(grandFinal, kembalian,
                            int.parse(payment.text), listcart);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Payment Success')),
                        );
                        Navigator.pop(context);
                      },
                      child: Text('Pay')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('cancel')),
                ]));
          },
        );
      },
    );
  }
}
