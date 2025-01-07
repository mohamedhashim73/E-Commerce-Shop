import 'package:ecommerce_shop/Data/Models/individual_bar_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OrdersGraphScreen extends StatelessWidget {
  final List<GraphBarModel> graphs;

  const OrdersGraphScreen({super.key, required this.graphs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders Graph'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                child: BarChart(
                  BarChartData(
                      maxY: 100,
                      minY: 1,
                      alignment: BarChartAlignment.spaceBetween,
                      barGroups: graphs.map((data){
                        return BarChartGroupData(
                            x: data.x,
                            barRods: [
                              BarChartRodData(toY: data.y,color: Colors.grey)
                            ]
                        );
                      }).toList()
                  ),
                ),
              ),
            ),
            Text("Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue)),
            Text("X : Order Created ( Hour )",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
            Text("Y : Orders Num",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
          ],
        ),
      )
    );
  }
}
