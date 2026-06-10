import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/food_item.dart';

class MenuService {
  final _col = FirebaseFirestore.instance.collection('menu');

  Stream<List<FoodItem>> getMenuItems() {
    return _col.snapshots().map((snap) =>
        snap.docs.map((d) => FoodItem.fromMap(d.id, d.data())).toList());
  }

  Future<void> addItem(FoodItem item) async => await _col.add({
    'name': item.name,
    'description': item.description,
    'price': item.price,
    'category': item.category,
    'imageUrl': item.imageUrl,
    'available': item.available,
  });

  Future<void> updateItem(FoodItem item) async =>
      await _col.doc(item.id).update({
        'name': item.name,
        'description': item.description,
        'price': item.price,
        'category': item.category,
        'imageUrl': item.imageUrl,
        'available': item.available,
      });

  Future<void> deleteItem(String id) async => await _col.doc(id).delete();

  Future<void> seedMenu() async {
    final existing = await _col.limit(1).get();
    if (existing.docs.isNotEmpty) return;

    final items = [
      {
        'name': 'Classic Beef Burger',
        'description': 'Juicy beef patty with lettuce, tomato & cheese',
        'price': 8.99,
        'category': 'Burgers',
        'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
        'available': true,
      },
      {
        'name': 'Pepperoni Pizza',
        'description': 'Loaded with pepperoni on rich tomato sauce',
        'price': 12.99,
        'category': 'Pizza',
        'imageUrl': 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400',
        'available': true,
      },
      {
        'name': 'Crispy French Fries',
        'description': 'Golden crispy fries with sea salt',
        'price': 3.49,
        'category': 'Sides',
        'imageUrl': 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400',
        'available': true,
      }
    ];

    for (final item in items) {
      await _col.add(item);
    }
  }
}