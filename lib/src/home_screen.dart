import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'orders_screen.dart';
import 'cart_screen.dart';
import 'auth_service.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  int _index = 0;
  final List<Map<String, dynamic>> _cart = [];

  void _onCartUpdate() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MenuScreen(cart: _cart, onCartUpdate: _onCartUpdate),
      const OrdersScreen(),
      CartScreen(cart: _cart, onOrderPlaced: () => setState(() => _cart.clear())),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }
}