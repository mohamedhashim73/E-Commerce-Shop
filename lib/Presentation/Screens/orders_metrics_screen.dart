import 'package:ecommerce_shop/Business%20Logic/orders_cubit.dart';
import 'package:ecommerce_shop/Business%20Logic/orders_states.dart';
import 'package:ecommerce_shop/Core/Widgets/internet_failure_column_widget.dart';
import 'package:ecommerce_shop/Core/Widgets/no_orders_added_column_widget.dart';
import 'package:ecommerce_shop/Core/Widgets/server_failure_column_widget.dart';
import 'package:ecommerce_shop/Presentation/Screens/orders_graph_screen.dart';
import 'package:ecommerce_shop/Presentation/Widgets/Metrics%20Orders%20Widgets/order_overview_container_widget.dart';
import 'package:ecommerce_shop/Presentation/Widgets/Metrics%20Orders%20Widgets/pie_chart_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersMetricsScreen extends StatelessWidget {
  const OrdersMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersCubit ordersCubit = OrdersCubit.getInstance(context)..getOrders();
    return Scaffold(
      appBar: AppBar(title: Text("Orders Metrics")),
      body: BlocBuilder<OrdersCubit,OrdersStates>(
          buildWhen: (past,current) => current is GetOrdersDataLoadingState || current is GetOrdersDataSuccessfullyState || current is FailedToGetOrdersDataState,
          builder: (context,state){
            if( ordersCubit.orders != null )
              {
                if( ordersCubit.orders!.data.isNotEmpty )
                {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        PieChartRowWidget(ordersStatics: ordersCubit.orders!.statics),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context,index)=> OrderOverviewContainerWidget(orderData: ordersCubit.orders!.data[index]),
                            separatorBuilder: (context,_)=> SizedBox(height: 12),
                            itemCount: ordersCubit.orders!.data.length
                          )
                        ),
                        MaterialButton(
                          onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> OrdersGraphScreen(graphs: ordersCubit.orders!.graphs))),
                          color: Colors.blue,
                          height: 48,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          minWidth: double.infinity,
                          textColor: Colors.white,
                          child: Text("Show Orders Graph",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
                        )
                      ],
                    ),
                  );
                }
                else
                  {
                    return NoOrdersAddedColumnWidget();
                  }
              }
            else if ( state is FailedToGetOrdersDataState )
              {
                if( state.internetNotFound )
                  {
                    return InternetFailureColumnWidget(onTap: ()=> ordersCubit.getOrders());
                  }
                else
                  {
                    return ServerFailureColumnWidget();
                  }
              }
            else
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          }
      ),
    );
  }
}
