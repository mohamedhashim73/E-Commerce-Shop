import 'package:ecommerce_shop/Business%20Logic/orders_cubit.dart';
import 'package:ecommerce_shop/Core/Theme/app_theme.dart';
import 'package:ecommerce_shop/Data/Data%20Source/orders_data_source.dart';
import 'package:ecommerce_shop/Data/Repositories/orders_repo.dart';
import 'package:ecommerce_shop/Presentation/Screens/orders_metrics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.kLightTheme,
      home: BlocProvider(
        create: (context)=> OrdersCubit(ordersRepo: OrdersRepo(ordersDataSource: OrdersDataSource())),
        child: OrdersMetricsScreen(),
      ),
    );
  }
}





