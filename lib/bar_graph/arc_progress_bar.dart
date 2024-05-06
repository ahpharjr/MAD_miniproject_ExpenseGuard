import 'package:flutter/material.dart';
import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:expenseguard/models/expense_item.dart';
import 'dart:math';

class ArcProgressBarWidget extends StatelessWidget {
  final List<ExpenseItem> expenseList;
  final DateTime selectedMonth;
  final double budgetAmount;

  const ArcProgressBarWidget({
    required this.expenseList,
    required this.selectedMonth,
    required this.budgetAmount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double monthlySpentAmount = _calculateMonthlySpentAmount();
    double yearlySpentAmount = _calculateYearlySpentAmount();

    double monthlyProgressPercentage =
        (monthlySpentAmount / budgetAmount) * 100;
    monthlyProgressPercentage = min(
        monthlyProgressPercentage, 100); // Limit progress percentage to 100%

    Color progressBarColor =
        _calculateProgressBarColor(monthlyProgressPercentage);

    String monthlyRemainingOrExceededAmount = (monthlySpentAmount >
            budgetAmount)
        ? 'Exceeded: \$${(monthlySpentAmount - budgetAmount).toStringAsFixed(2)}'
        : 'Remain: \$${(budgetAmount - monthlySpentAmount).toStringAsFixed(2)}';

    Color monthlyTextColor = (monthlySpentAmount > budgetAmount)
        ? const Color.fromARGB(255, 246, 51, 37)
        : const Color.fromARGB(255, 17, 202, 23);

    ThemeData themeData = Theme.of(context);
    bool isDarkMode = themeData.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Monthly Progress Bar
        Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color.fromARGB(255, 27, 26, 26)
                : const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? const Color.fromARGB(255, 214, 214, 214).withOpacity(0.3)
                    : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: const Offset(2, 5),
              ),
            ],
          ),
          child: ArcProgressBar(
            percentage: monthlyProgressPercentage,
            arcThickness: 14,
            backgroundColor: isDarkMode
                ? const Color.fromARGB(255, 48, 48, 48)
                : const Color.fromARGB(255, 218, 218, 218),
            // foregroundColor: isDarkMode
            //     ? const Color.fromARGB(255, 255, 255, 255)
            //     : Color.fromRGBO(0, 95, 96, 1),
            foregroundColor: progressBarColor,
            bottomCenterWidget: Text(
              monthlyRemainingOrExceededAmount,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: monthlyTextColor,
              ),
            ),
            centerWidget: Text(
              '\n\n\n \$${monthlySpentAmount.toStringAsFixed(2)}/ \$${budgetAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 30),
          child: Container(
            width: 395,
            height: 60,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color.fromARGB(255, 52, 52, 52)
                  : const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Yearly Spent: \$${yearlySpentAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 3),
          child: Container(
            width: 395,
            height: 60,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color.fromARGB(255, 52, 52, 52)
                  : const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Monthly Spent: \$${monthlySpentAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Calculate Monthly Spent Amount
  double _calculateMonthlySpentAmount() {
    double spentAmount = 0;

    List<ExpenseItem> expensesForSelectedMonth = expenseList
        .where((expense) =>
            expense.dateTime.year == selectedMonth.year &&
            expense.dateTime.month == selectedMonth.month)
        .toList();

    for (var expense in expensesForSelectedMonth) {
      spentAmount += double.parse(expense.amount);
    }

    return spentAmount;
  }

  // Calculate Yearly Spent Amount
  double _calculateYearlySpentAmount() {
    double spentAmount = 0;

    List<ExpenseItem> expensesForSelectedYear = expenseList
        .where((expense) => expense.dateTime.year == selectedMonth.year)
        .toList();

    for (var expense in expensesForSelectedYear) {
      spentAmount += double.parse(expense.amount);
    }

    return spentAmount;
  }

  // Calculate Progress Bar Color based on monthly spent amount
  Color _calculateProgressBarColor(double percentage) {
    if (percentage < 40) {
      // Green color for low spent amount
      return Color.fromRGBO(14, 106, 117, 1);
    } else if (percentage < 55) {
      // Yellow color for moderate spent amount
      return Color.fromRGBO(15, 132, 89, 1);
    } else if (percentage < 65) {
      // Yellow color for moderate spent amount
      return Color.fromARGB(255, 216, 158, 33);
    } else if (percentage < 80) {
      // Yellow color for moderate spent amount
      return Color.fromARGB(255, 226, 76, 50);
    } else {
      // Red color for high spent amount
      return const Color.fromARGB(255, 252, 57, 43);
    }
  }
}
