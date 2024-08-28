import 'package:flutter/material.dart';

import 'base_components.dart';

class HeadingLogin extends StatelessWidget {
  const HeadingLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextTitle(
            title: "STUDENT\nATTENDANCE",
            align: TextAlign.center,
            fontSize: 30,
            weight: FontWeight.bold,
            color: Colors.white),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
