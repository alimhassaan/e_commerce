import 'package:e_commerce/views/widgets/order_summary_component.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CheckoutOrderDetails extends StatelessWidget {
  const CheckoutOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderSummaryComponent(
          title: 'Order',
          value: '125',
          fontWeight: FontWeight.w300,
        ),
        const Gap(8),
        OrderSummaryComponent(
          title: 'Delivery',
          value: '15',
          fontWeight: FontWeight.w300,
        ),
        const Gap(8),
        OrderSummaryComponent(
          title: 'Summary',
          value: '140',
          fontWeight: FontWeight.w300,
        ),
      ],
    );
  }
}
