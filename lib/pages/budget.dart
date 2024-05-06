import 'package:flutter/material.dart';
import 'package:expenseguard/bar_graph/arc_progress_bar.dart';
import 'package:expenseguard/data/expense_data.dart';
import 'package:provider/provider.dart';

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  DateTime today = DateTime.now();
  TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isDarkMode = themeData.brightness == Brightness.dark;
    return Consumer<ExpenseData>(
      builder: (context, expenseData, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Monthly Budget',
                  textAlign: TextAlign.center,
                ),
                const Spacer(), // Add a spacer to push the button to the right
                TextButton(
                  onPressed: () {
                    _showSetBudgetDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    // primary: Color.fromARGB(255, 231, 57, 9),
                    // primary: const Color.fromARGB(255, 34, 132, 212),
                    primary: isDarkMode
                        ? const Color.fromARGB(255, 45, 45, 45)
                        : const Color.fromRGBO(14, 106, 117, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Set',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color.fromARGB(
                          255, 255, 255, 255), // Set the button text color
                    ),
                  ),
                ),
              ],
            ),
            // centerTitle: true,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 22,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 2),
                ArcProgressBarWidget(
                  expenseList: expenseData.getAllExpenseList(),
                  selectedMonth: today,
                  budgetAmount: expenseData.budgetAmount, // Pass budgetAmount
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 5.0, left: 8.0, right: 3.0, top: 3),
                  child: Container(
                    width: 395,
                    height: 60, // Set width to 150
                    padding: const EdgeInsets.all(
                        16), // Padding inside the container
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 52, 52, 52)
                          : const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10), // Border radius
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.2), // Shadow color
                      //     spreadRadius: 5, // Spread radius
                      //     blurRadius: 7, // Blur radius
                      //     offset: const Offset(0, 3), // Offset of the shadow
                      //   ),
                      // ],
                    ),
                    child: Consumer<ExpenseData>(
                      builder: (context, expenseData, child) {
                        double budgetAmount = expenseData.budgetAmount;
                        return Text(
                          'Budget Amount: \$${budgetAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSetBudgetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Theme.of(context)
              .colorScheme
              .primary, // Set dialog background color
          title: const Text(
            "Set Budget",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // color: Color.fromARGB(255, 7, 68, 56),
              fontSize: 20, // Set dialog title text color
            ),
          ),
          content: SizedBox(
            width: double.maxFinite, // Set content width to maximum
            child: TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              controller: budgetController,
              decoration: const InputDecoration(
                hintText: "Enter your budget",
                // Add custom hint text color
                hintStyle: TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                clear();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 208, 29, 17)), // Set cancel button text color
              ),
            ),
            ElevatedButton(
              onPressed: () {
                double budgetAmount =
                    double.tryParse(budgetController.text) ?? 0;
                Provider.of<ExpenseData>(context, listen: false)
                    .saveBudget(budgetAmount);
                Navigator.of(context).pop();
                clear();
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(
                    14, 106, 117, 1), // Set button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 5, // Add elevation
              ),
              child: const Text(
                "Set",
                style: TextStyle(
                  color: Colors.white, // Set button text color
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void clear() {
    budgetController.clear();
  }
}
