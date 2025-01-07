import 'package:ecommerce_shop/Data/Models/individual_bar_model.dart';
import 'package:ecommerce_shop/Data/Models/order_model.dart';
import 'orders_statics_model.dart';

class OrdersModel{
  final List<OrderModel> data;
  final OrdersStatics statics;
  final List<GraphBarModel> graphs;

  OrdersModel({required this.data,required this.statics,required this.graphs});
}