import 'package:flutter/material.dart';

class InternetFailureColumnWidget extends StatelessWidget {
  final Function()? onTap;
  const InternetFailureColumnWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: Icon(Icons.refresh,size: 36),
          ),
          Text("Internet not found, Check it !\ntry again later.",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }
}
