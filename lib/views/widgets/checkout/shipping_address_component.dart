import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ShippingAddressComponent extends StatelessWidget {
  const ShippingAddressComponent({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Ali M Hassaan',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Change',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Text(
              '123 Main Street',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'City, Country',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
