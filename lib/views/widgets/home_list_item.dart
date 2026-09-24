import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeListItem extends StatelessWidget {
  final Product product;
  const HomeListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imgUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 50,
                  height: 30,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                        child: Text(
                          "${product.discountValue}%",
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(
            product.category,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(3),
          Text(product.title, style: Theme.of(context).textTheme.titleMedium),
          const Gap(3),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${product.price}\$',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                TextSpan(
                  text: ' ${product.price * (product.discountValue) / 100}\$',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
