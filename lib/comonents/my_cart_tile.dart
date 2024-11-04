import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'my_quantity_selector.dart';

class MyCartTile extends StatelessWidget {
  final dynamic cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const MyCartTile({
    super.key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final box = Hive.box("userInfo");

    void _updateCartItem() {
      List basket = box.get('basket', defaultValue: []);
      // Find the index of the current cart item
      int index =
          basket.indexWhere((item) => item['title'] == cartItem['title']);
      if (index != -1) {
        basket[index]['quantity'] = cartItem['quantity']; // Update quantity
        box.put('basket', basket); // Save updated basket to Hive
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    cartItem['photo'],
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cartItem['title']),
                    Text(
                      "\$${cartItem['cost'].toString()}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                QuantitySelector(
                  quantity: cartItem['quantity'],
                  onDecrement: () {
                    if (cartItem['quantity'] > 1) {
                      cartItem['quantity']--;
                      _updateCartItem(); // Update item in Hive
                      onQuantityChanged(cartItem[
                          'quantity']); // Notify parent to update quantity
                    } else {
                      onRemove(); // Remove item if quantity is 0
                    }
                  },
                  onIncrement: () {
                    cartItem['quantity']++;
                    _updateCartItem(); // Update item in Hive
                    onQuantityChanged(cartItem[
                        'quantity']); // Notify parent to update quantity
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
