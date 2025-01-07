import 'dart:convert';
import 'package:ecommerce_shop/Core/Constants/app_strings.dart';
import 'package:ecommerce_shop/Data/Models/individual_bar_model.dart';
import 'package:ecommerce_shop/Data/Models/order_model.dart';
import 'package:ecommerce_shop/Data/Models/orders_model.dart';
import 'package:ecommerce_shop/Data/Models/orders_statics_model.dart';
import 'package:flutter/services.dart';

class OrdersDataSource{
  Future<OrdersModel> getOrders() async {
    int ordered = 0;
    int delivered = 0;
    int returned = 0;
    double averagePrice = 0;
    List<OrderModel> ordersData = [];
    List<GraphBarModel> graphs = [];
    Map<int,double> mappedGraphsData = {};
    String jsonBody = await rootBundle.loadString("assets/json/orders.json");
    for( var order in jsonDecode(jsonBody) )
    {
      averagePrice += double.parse(order['price'].replaceAll(',', '').replaceAll('\$', ''));
      order['status'] == AppStrings.kReturnedName ? ++returned : order['status'] == AppStrings.kOrderedName ? ++ordered : ++delivered;
      ordersData.add(OrderModel.fromJson(order));
      if ( mappedGraphsData.containsKey(ordersData.last.registered.hour) )
      {
        mappedGraphsData[ordersData.last.registered.hour] = mappedGraphsData[ordersData.last.registered.hour]! + 1;
      }
      else
      {
        mappedGraphsData[ordersData.last.registered.hour] = 1;
      }
    }
    graphs = mappedGraphsData.entries.map((entry) => GraphBarModel(x: entry.key, y: entry.value)).toList();
    graphs.sort((a, b) => a.x.compareTo(b.x));
    return OrdersModel(graphs: graphs,data: ordersData, statics: OrdersStatics(total: ordersData.length, averagePrice: averagePrice, delivered: delivered, ordered: ordered, returned: returned));
  }
}