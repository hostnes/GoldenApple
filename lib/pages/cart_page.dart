import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../comonents/my_button.dart';
import '../comonents/my_cart_tile.dart';
import 'checkout_page.dart'; // Make sure to import the checkout page

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  List<dynamic> basket = [];

  @override
  void initState() {
    super.initState();
    final box = Hive.box("userInfo");
    basket = box.get('basket', defaultValue: []);
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      basket[index]['quantity'] = newQuantity;
    });
  }

  void _removeItem(int index) {
    setState(() {
      basket.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Корзина"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: basket.length,
              itemBuilder: (context, index) {
                return MyCartTile(
                  cartItem: basket[index],
                  onQuantityChanged: (newQuantity) =>
                      _updateQuantity(index, newQuantity),
                  onRemove: () => _removeItem(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyButton(
              onTap: () {
                // Navigate to the checkout page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(), // Pass basket only
                  ),
                );
              },
              text: "Перейти к оплате",
            ),
          ),
        ],
      ),
    );
  }
}
