import 'package:flutter/material.dart';

class DetailsTile extends StatelessWidget {
  final Widget? title;
  final Widget? value;
  final EdgeInsets padding;

  const DetailsTile({
    Key? key,
    this.title,
    this.value,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: textTheme.titleMedium!.copyWith(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
            child: title!,
          ),
          const SizedBox(height: 0),
          DefaultTextStyle(
            style: textTheme.bodyLarge!,
            child: value!,
          ),
        ],
      ),
    );
  }
}
