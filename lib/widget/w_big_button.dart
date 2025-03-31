import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'w_arrow.dart';
import 'w_rounded_container.dart';

class BigButton extends StatelessWidget {
  final String text;
  final VoidCallback onTab;

  const BigButton(this.text, {super.key, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text.text.black.size(20).bold.make(),
          Arrow(),
        ],
      ),
    );
  }
}
