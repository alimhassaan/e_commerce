import 'package:flutter/material.dart';

class AddShippiingAddressPage extends StatefulWidget {
  const AddShippiingAddressPage({super.key});

  @override
  State<AddShippiingAddressPage> createState() =>
      _AddShippiingAddressPageState();
}

class _AddShippiingAddressPageState extends State<AddShippiingAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
          'Add Shipping Address',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    );
  }
}
