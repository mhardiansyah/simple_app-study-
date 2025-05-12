import 'package:app_simple/core/models/menu_items.dart';

class CartItems {
  final MenuItems menuItems;
  int quantity;

  CartItems({required this.menuItems, required this.quantity});
}