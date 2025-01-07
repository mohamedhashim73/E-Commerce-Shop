import 'package:ecommerce_shop/Data/Models/orders_statics_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartRowWidget extends StatelessWidget {
  final OrdersStatics ordersStatics;
  const PieChartRowWidget({super.key, required this.ordersStatics});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      height: 150,
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4,
              children: List.generate(4, (index)=> Row(
                spacing: 12,
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(index == 0 ? 0xffFFFFFF : index == 1 ? 0xffF074A6 : index == 2 ? 0xff06C168 : 0xffFF0000)
                    ),
                  ),
                  Expanded(
                    child: Text(index == 0 ? "Total Orders ${ordersStatics.total}" : index == 1 ? "Total Delivered ${ordersStatics.delivered}" : index == 2 ? "Total Ordered ${ordersStatics.ordered}" : "Total Returned ${ordersStatics.returned}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                  ),
                ],
              )),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    titleSunbeamLayout: true,
                    pieTouchData: PieTouchData(
                      enabled: true,
                    ),
                    sections: [
                      PieChartSectionData(
                        value: ordersStatics.returned.toDouble(),
                        title: '${ordersStatics.returned}',
                        color: Colors.red,
                      ),
                      PieChartSectionData(
                        value: ordersStatics.delivered.toDouble(),
                        title: '${ordersStatics.delivered}',
                        color: Colors.green,
                      ),
                      PieChartSectionData(
                        value: ordersStatics.ordered.toDouble(),
                        title: '${ordersStatics.ordered}',
                        color: Colors.blue,
                      ),
                    ],
                    centerSpaceRadius: 40,
                    centerSpaceColor: Colors.white,
                    sectionsSpace: 2,
                  ),
                ),
                Text("Total\n${ordersStatics.total}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),textAlign: TextAlign.center)
              ],
            ),
          )
        ],
      ),
    );
  }
}
