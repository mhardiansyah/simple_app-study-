// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:app_simple/core/Routing/App_route.dart';
import 'package:app_simple/core/models/menu_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuService {
  final CollectionReference _menuCollection =
      FirebaseFirestore.instance.collection('menu');
  Future addMenu(MenuItems menuitems, BuildContext context) async {
    try {
      DocumentReference docRef = await _menuCollection.add(menuitems.toJson());
      print('Document written with ID: ${docRef.id}');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Add Success')));
      context.goNamed(Routes.menu);
      return docRef.id;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Add Failed')));
      print('Error adding document: $e');
    }
  }

  Stream<List<MenuItems>> getMenu() {
    return _menuCollection.snapshots().map(
      (event) {
        return event.docs
            .map((e) =>
                MenuItems.fromJson(e.data() as Map<String, dynamic>, e.id))
            .toList();
      },
    );
  }

  Future updateMenu() async {}
}
