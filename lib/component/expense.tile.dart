import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final String category;
  void Function(BuildContext)? deleteTapped;

  ExpenseTile({
    Key? key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.category,
    required this.deleteTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isDarkMode = themeData.brightness == Brightness.dark;
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          //delete button
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(10),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0, left: 8, right: 8, top: 1),
        child: Container(
          padding: const EdgeInsets.only(top: 3.0),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Color.fromARGB(255, 52, 52, 52)
                : Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Color.fromARGB(255, 32, 32, 32)
                    : Color.fromARGB(255, 225, 225, 225),
                spreadRadius: 4,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              '$name ($category)',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).colorScheme.secondary),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            trailing: Text(
              '\$$amount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
