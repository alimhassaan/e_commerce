import 'package:flutter/material.dart';

class OrderSummaryComponent extends StatelessWidget {
  final String title;
  final String value;
  final FontWeight? fontWeight;
  const OrderSummaryComponent({
    super.key,
    required this.title,
    this.fontWeight,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.black,
            fontWeight: fontWeight,
          ),
        ),
        Text(
          '$value\$',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.black,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
