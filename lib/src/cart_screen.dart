import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;
  final VoidCallback onOrderPlaced;

  const CartScreen({super.key, required this.cart, required this.onOrderPlaced});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: cart.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (ctx, i) => ListTile(title: Text(cart[i]['name'])),
      ),
    );
  }
}