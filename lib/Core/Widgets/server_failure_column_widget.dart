import 'package:flutter/material.dart';

class ServerFailureColumnWidget extends StatelessWidget {
  const ServerFailureColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.error,size: 36),
          Text("Something went wrong, try again later.",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
