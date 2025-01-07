import 'package:flutter/material.dart';

class NoOrdersAddedColumnWidget extends StatelessWidget {
  const NoOrdersAddedColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.info),
          Text("No Orders have been created yet .")
        ],
      ),
    );
  }
}
