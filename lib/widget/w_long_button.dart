import 'package:common_ui/widget/w_arrow.dart';
import 'package:common_ui/widget/w_empty_expanded.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LongButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const LongButton({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          title.text.gray50.make(),
          emptyExpanded,
          const Arrow(color: Colors.white),
        ],
      ),
    );
  }
}
