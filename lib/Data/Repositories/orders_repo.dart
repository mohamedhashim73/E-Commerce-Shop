import 'package:ecommerce_shop/Data/Models/orders_model.dart';
import '../Data Source/orders_data_source.dart';

class OrdersRepo{
  final OrdersDataSource ordersDataSource;

  OrdersRepo({required this.ordersDataSource});

  Future<OrdersModel> getOrders() async {
    return await ordersDataSource.getOrders();
  }
}