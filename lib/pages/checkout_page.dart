import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the Hive box
    final box = Hive.box("userInfo");
    final List<dynamic> basket = box.get('basket', defaultValue: []);

    int _calculateTotalCost() {
      int total = 0; // Initialize total cost
      for (var item in basket) {
        // Ensure item['cost'] is treated as int
        final int cost =
            (item['cost'] is num) ? (item['cost'] as num).toInt() : 0;
        // Ensure item['quantity'] is treated as int
        final int quantity = (item['quantity'] is int) ? item['quantity'] : 0;

        // Debugging print statement
        print("Item: ${item['title']}, Cost: $cost, Quantity: $quantity");

        total += cost * quantity; // Update total cost
      }
      return total; // Return the total cost
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Оформление заказа"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: basket.length,
              itemBuilder: (context, index) {
                final item = basket[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item['photo'],
                      height: 50,
                      width: 50,
                      fit: BoxFit
                          .cover, // Ensures the image is properly contained
                    ),
                  ),
                  title: Text(item['title']),
                  subtitle: Text('Количество: ${item['quantity']}'),
                  trailing: Text('${item['cost']} руб.'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Итоговая цена: ${_calculateTotalCost()} руб.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
