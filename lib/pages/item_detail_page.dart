import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../comonents/my_button.dart';

class ItemDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String photo;
  final int cost;

  ItemDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.photo,
    required this.cost,
  }) : super(key: key);

  final box = Hive.box("userInfo");

  void _addToBasket(BuildContext context) {
    // box.delete('basket');

    List basket = box.get('basket', defaultValue: []);

    Map<String, dynamic> newItem = {
      'title': title,
      'description': description,
      'photo': photo,
      'cost': cost,
      'quantity': 1,
    };

    if (!basket.any((item) => item['title'] == title)) {
      basket.add(newItem); // Add new item to the basket
      box.put('basket', basket); // Save updated basket to Hive
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$title добавлено в корзину!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$title уже в корзине!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(photo, fit: BoxFit.cover),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(description),
                  SizedBox(height: 10),
                  Text(
                    '${cost} руб.',
                    style: TextStyle(fontSize: 20),
                  ),
                  MyButton(
                    text: "В корзину",
                    onTap: () => _addToBasket(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
