import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/shipping_address.dart';
import 'package:e_commerce/views/widgets/checkout/shipping_address_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Address',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: StreamBuilder<List<ShippingAddress>>(
            stream: database.getShippingAddresses(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.active) {
                final shippingAddress = asyncSnapshot.data;
                return Column(
                  children: shippingAddress!
                      .map(
                        (shippingAddress) => ShippingAddressComponent(
                          shippingAddress: shippingAddress,
                        ),
                      )
                      .toList(),
                );
              }
              return const Center(child: CircularProgressIndicator.adaptive());
            },
          ),
        ),
      ),
    );
  }
}
