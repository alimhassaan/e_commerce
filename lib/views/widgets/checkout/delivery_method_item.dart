import 'package:e_commerce/models/delivery_method.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DeliveryMethodItem extends StatelessWidget {
  final DeliveryMethod deliveryMethod;
  const DeliveryMethodItem({super.key,  required this.deliveryMethod});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(deliveryMethod.imgUrl, fit: BoxFit.cover, height: 40, width: 100),
            const Gap(6),
            Text(
              '${deliveryMethod.days} Days Delivery',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
