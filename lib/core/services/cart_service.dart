import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/home/data/models/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {'product': product.toJson(), 'quantity': quantity};
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  int get totalItems => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => _cartItems.fold(
    0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );

  Future<void> init() async {
    await loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString('cart_items');
    if (cartJson != null) {
      final List<dynamic> decoded = jsonDecode(cartJson);
      _cartItems = decoded.map((e) => CartItem.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> addToCart(ProductModel product) async {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }
    await _saveCart();
    notifyListeners();
  }

  Future<void> updateQuantity(int productId, int delta) async {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      _cartItems[index].quantity += delta;
      if (_cartItems[index].quantity <= 0) {
        _cartItems.removeAt(index);
      }
      await _saveCart();
      notifyListeners();
    }
  }

  Future<void> removeProduct(int productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
    await _saveCart();
    notifyListeners();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(
      _cartItems.map((e) => e.toJson()).toList(),
    );
    await prefs.setString('cart_items', encoded);
  }
}
