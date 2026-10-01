import 'package:flutter/material.dart';

class LoginWith extends StatelessWidget {
  final String photo;
  const LoginWith({super.key,  required this.photo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Center(child: Image.asset(photo, height: 40, width: 40)),
    );
  }
}
