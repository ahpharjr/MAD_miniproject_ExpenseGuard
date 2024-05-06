// ignore_for_file: prefer_const_constructors

import 'package:expenseguard/pages/budget.dart';
import 'package:expenseguard/pages/dashboard.dart';
import 'package:expenseguard/pages/setting.dart';
import 'package:expenseguard/pages/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expenseguard/models/expense_item.dart';
import 'package:provider/provider.dart';
import 'package:expenseguard/data/expense_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    transaction(),
    Budget(),
    Setting()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new expense'),
        contentPadding: EdgeInsets.symmetric(
            vertical: 25, horizontal: 30), // Adjust content padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Adjust dialog shape
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: "Add Expense",
              ),
            ),
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Amount",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Select Category',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: cancel,
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Color.fromARGB(
                    255, 208, 29, 17), // Set cancel button text color
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(
                  14, 106, 117, 1), // Set button background color
              borderRadius: BorderRadius.circular(
                  30), // Adjust the border radius as needed
            ),
            child: MaterialButton(
              onPressed: save,
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white, // Set button text color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// List of categories
  List<String> categories = [
    'Food',
    'Shopping',
    'Bill',
    'Transportation',
    'Other',
  ];

// Selected category
  String? selectedCategory;

  void save() {
    //only save expense if all fields are filled
    if (newExpenseAmountController.text.isNotEmpty &&
        newExpenseNameController.text.isNotEmpty &&
        selectedCategory != null) {
      //create expense item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now(),
        category: selectedCategory!,
      );

      //add the new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }
    // Navigate to the dashboard screen
    Navigator.pop(context);

    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isDarkMode = themeData.brightness == Brightness.dark;
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode
            ? const Color.fromARGB(255, 94, 94, 94)
            : Color.fromRGBO(14, 106, 117, 1),
        onPressed: addNewExpense,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Adjust the value as needed
        ),
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).colorScheme.tertiary,
          // color: const Color.fromARGB(255, 203, 203, 203),
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Dashboard();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: currentTab == 0
                                  ? isDarkMode
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromRGBO(14, 106, 117, 1)
                                  : Color.fromARGB(255, 134, 134, 134),
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                  color: currentTab == 0
                                      ? isDarkMode
                                          ? Color.fromARGB(255, 255, 255, 255)
                                          : Color.fromRGBO(14, 106, 117, 1)
                                      : Color.fromARGB(255, 134, 134, 134),
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = transaction();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: currentTab == 1
                                  ? isDarkMode
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromRGBO(14, 106, 117, 1)
                                  : Color.fromARGB(255, 134, 134, 134),
                            ),
                            Text(
                              'Transaction',
                              style: TextStyle(
                                  color: currentTab == 1
                                      ? isDarkMode
                                          ? Color.fromARGB(255, 255, 255, 255)
                                          : Color.fromRGBO(14, 106, 117, 1)
                                      : Color.fromARGB(255, 134, 134, 134),
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Budget();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: currentTab == 2
                                  ? isDarkMode
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromRGBO(14, 106, 117, 1)
                                  : Color.fromARGB(255, 134, 134, 134),
                            ),
                            Text(
                              'Budget',
                              style: TextStyle(
                                  color: currentTab == 2
                                      ? isDarkMode
                                          ? Color.fromARGB(255, 255, 255, 255)
                                          : Color.fromRGBO(14, 106, 117, 1)
                                      : Color.fromARGB(255, 134, 134, 134),
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Setting();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings,
                              color: currentTab == 3
                                  ? isDarkMode
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromRGBO(14, 106, 117, 1)
                                  : Color.fromARGB(255, 134, 134, 134),
                            ),
                            Text(
                              'Setting',
                              style: TextStyle(
                                  color: currentTab == 3
                                      ? isDarkMode
                                          ? Color.fromARGB(255, 255, 255, 255)
                                          : Color.fromRGBO(14, 106, 117, 1)
                                      : Color.fromARGB(255, 134, 134, 134),
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
