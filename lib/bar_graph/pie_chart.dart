import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:expenseguard/models/expense_item.dart';

class PieChartWidget extends StatelessWidget {
  final List<ExpenseItem> expenseList;
  final DateTime selectedDate;

  const PieChartWidget({
    required this.expenseList,
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {};
    double totalAmount = 0;

    // Filter expenses for the selected date
    List<ExpenseItem> expensesForSelectedDate = expenseList
        .where((expense) =>
            expense.dateTime.year == selectedDate.year &&
            expense.dateTime.month == selectedDate.month &&
            expense.dateTime.day == selectedDate.day)
        .toList();

    // Calculate total amount for each category
    for (var expense in expensesForSelectedDate) {
      if (dataMap.containsKey(expense.category)) {
        dataMap[expense.category] =
            dataMap[expense.category]! + double.parse(expense.amount);
      } else {
        dataMap[expense.category] = double.parse(expense.amount);
      }
      totalAmount += double.parse(expense.amount);
    }

    // Check if dataMap is empty
    bool isEmptyDataMap = dataMap.isEmpty;

    // If dataMap is empty, render the pie chart with full gray color
    if (isEmptyDataMap) {
      dataMap = {
        'No expense': 1
      }; // Assigning any value to display a single gray slice
    }

    List<List<Color>> gradientList = isEmptyDataMap
        ? [
            [
              const Color.fromARGB(255, 221, 221, 221),
              const Color.fromARGB(255, 221, 221, 221),
            ],
          ]
        : [
            [
              const Color.fromRGBO(0, 149, 150, 1),
              const Color.fromRGBO(0, 149, 150, 1),
            ],
            [
              const Color.fromRGBO(4, 77, 77, 1),
              const Color.fromRGBO(2, 77, 77, 1),
            ],
            [
              const Color.fromRGBO(0, 95, 96, 1),
              const Color.fromRGBO(0, 95, 96, 1),
            ],
            [
              const Color.fromRGBO(115, 197, 197, 1),
              const Color.fromRGBO(115, 197, 197, 1),
            ],
            [
              const Color.fromRGBO(130, 208, 208, 1),
              const Color.fromRGBO(156, 215, 215, 1),
            ],
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total amount
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Daily Total: \$${totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        // Pie chart
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 0, right: 30),
          child: PieChart(
            dataMap: dataMap,
            chartType: ChartType.ring,
            chartRadius: MediaQuery.of(context).size.width / 3,
            ringStrokeWidth: 90,
            initialAngleInDegree: 10,
            animationDuration: const Duration(seconds: 2),
            chartValuesOptions: const ChartValuesOptions(
              showChartValues: true,
              showChartValuesOutside: true,
              showChartValuesInPercentage: true,
              showChartValueBackground: false,
              chartValueStyle: TextStyle(
                color: Colors.white, // Set text color to white
                fontSize: 14, // Adjust font size if needed
              ),
            ),
            chartLegendSpacing: 65,
            legendOptions: const LegendOptions(
              showLegends: true,
              legendTextStyle: TextStyle(fontSize: 10),
              legendPosition: LegendPosition.left,
            ),
            gradientList: gradientList,
          ),
        ),
      ],
    );
  }
}
