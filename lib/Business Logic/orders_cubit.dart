import 'package:ecommerce_shop/Data/Models/orders_model.dart';
import 'package:ecommerce_shop/Data/Repositories/orders_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'orders_states.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  final OrdersRepo ordersRepo;
  OrdersCubit({required this.ordersRepo}) : super(OrdersInitialState());

  static OrdersCubit getInstance(BuildContext context) => BlocProvider.of(context);

  OrdersModel? orders;
  Future<void> getOrders({bool? refreshData}) async {
    try{
      emit(GetOrdersDataLoadingState());
      if( orders == null || refreshData != null )
      {
        orders = await ordersRepo.getOrders();
        emit(GetOrdersDataSuccessfullyState());
      }
    }
    catch(e){
      debugPrint("Exception $e");
      emit(FailedToGetOrdersDataState(internetNotFound: await InternetConnectionChecker.createInstance().hasConnection ? true : false));
    }
  }
}