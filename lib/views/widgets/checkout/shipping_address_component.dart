import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/shipping_address.dart';
import 'package:e_commerce/utilities/app_routes.dart';
import 'package:e_commerce/utilities/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ShippingAddressComponent extends StatelessWidget {
  final ShippingAddress shippingAddress;
  const ShippingAddressComponent({super.key, required this.shippingAddress});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shippingAddress.fullName,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () => context.pushNamed(
                    AppRoutes.shippingAddressRoute,
                    arguments: database,
                  ),
                  child: const Text(
                    'Change',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Text(
              shippingAddress.address,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${shippingAddress.city}, ${shippingAddress.state}, ${shippingAddress.country}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
