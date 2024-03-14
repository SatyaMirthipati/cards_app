import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  final String title;
  final String value;

  const RowWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.titleMedium!.copyWith(
            fontSize: 13,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        Text(
          value,
          style: textTheme.bodyMedium!.copyWith(fontSize: 16),
        )
      ],
    );
  }
}
