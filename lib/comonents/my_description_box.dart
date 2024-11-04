import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  final String photo;
  const MyDescriptionBox({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    var myPrimaryTextStyle =
        TextStyle(color: Theme.of(context).colorScheme.inversePrimary);
    var mySecondaryTextStyle =
        TextStyle(color: Theme.of(context).colorScheme.primary);

    return Container(
      height: 130,
        width: 320,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Image.network(
        photo,
        fit: BoxFit.cover,
      ),
    );
  }
}
