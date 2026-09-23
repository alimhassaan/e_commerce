import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/views/widgets/home_header.dart';
import 'package:e_commerce/views/widgets/home_list_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeHeader(),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                buildeaderOfList(
                  context: context,
                  title: 'Sale',
                  description: 'Super Summer Sale!',
                  onTap: () {},
                ),
                const Gap(8),
                SizedBox(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: dummyProducts
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HomeListItem(product: e),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Gap(5),
                buildeaderOfList(
                  context: context,
                  title: 'New',
                  description: 'you\'ve never seen it before!',
                  onTap: () {},
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: dummyProducts
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HomeListItem(product: e),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildeaderOfList({
  required BuildContext context,
  required String title,
  GestureTapCallback? onTap,
  required String description,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              'View All',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
      Text(
        description,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(color: Colors.grey),
      ),
    ],
  );
}
