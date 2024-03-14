import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/images.dart';

class SuccessScreen extends StatefulWidget {
  final Function onProcess;
  final String title;
  final String description;

  const SuccessScreen({
    super.key,
    required this.onProcess,
    required this.title,
    required this.description,
  });

  static Future open(
    BuildContext context, {
    required Function onProcess,
    required String title,
    required String description,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SuccessScreen(
          title: title,
          onProcess: onProcess,
          description: description,
        ),
      ),
    );
  }

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => widget.onProcess());
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset(Images.success, height: 220),
            const SizedBox(height: 10),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge!.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge!.copyWith(
                color: Colors.black.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
