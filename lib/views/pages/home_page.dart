import 'package:e_commerce/views/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       HomeHeader(),
       const Gap(24),
      ],
    );
  }
}
