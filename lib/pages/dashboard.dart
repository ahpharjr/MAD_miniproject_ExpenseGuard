import 'package:flutter/material.dart';
import 'package:expenseguard/component/expense_summary.dart';
import 'package:expenseguard/bar_graph/pie_chart.dart';
import 'package:expenseguard/data/expense_data.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime today = DateTime.now(); // Initialize with current date

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Weekly summary
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),
                const SizedBox(height: 15),

                // Pie chart
                PieChartWidget(
                  expenseList: value.getAllExpenseList(),
                  selectedDate: today,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
