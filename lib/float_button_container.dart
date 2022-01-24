
import 'dart:ui';
import 'package:flutter/material.dart';

// 悬浮按钮的样式
class TestContainer extends StatefulWidget {
  const TestContainer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TestContainerState();
}


class TestContainerState extends State<TestContainer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => {},
        child: Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.green.withOpacity(0.4)),
          child: const Text(
            "+",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

}




