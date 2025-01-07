import 'package:ecommerce_shop/Data/Models/order_model.dart';
import 'package:flutter/material.dart';
import '../../../Core/Constants/app_enum.dart';

class OrderOverviewContainerWidget extends StatelessWidget {
  final OrderModel orderData;
  const OrderOverviewContainerWidget({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
      ),
      child: Row(
        spacing: 16,
        children: [
          Container(
              height: 98,
              width: 98,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.withOpacity(0.25),
              ),
              child: FadeInImage(
                  placeholder: AssetImage("assets/images/error-404.png"),
                  imageErrorBuilder: (context,error,stackTrace)=> Icon(Icons.error),
                  image: NetworkImage(orderData.picture)
              )
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(orderData.buyer,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                Text("\$ ${orderData.price.toStringAsFixed(2)}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(orderData.status,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,decoration: TextDecoration.underline,decorationColor: orderData.status.toLowerCase() == OrderStatus.returned.name ? Colors.red : orderData.status.toLowerCase() == OrderStatus.delivered.name ? Colors.green : Colors.black,color: orderData.status.toLowerCase() == OrderStatus.returned.name ? Colors.red : orderData.status.toLowerCase() == OrderStatus.delivered.name ? Colors.green : Colors.black)),
                    if( !orderData.isActive )
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.1)
                        ),
                        child: Icon(Icons.remove_shopping_cart_outlined,color: Colors.red),
                      )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
