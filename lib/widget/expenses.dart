import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widget/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/widget/Expenses-list/expenses_list.dart';
import 'package:expenses_tracker/widget/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter course ',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.99,
        date: DateTime.now(),
        category: Category.leisure) //category is of type Category which is enum
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(
          expense); //value received is added to the _registeredeExpenses list
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense); // for undo
    setState(() {
      _registeredExpenses.remove(
          expense); //value received is added to the _registeredExpenses list
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //if we remove 2 expense at same time then old msg will immediately remove
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 4),
        content: Text('Expense deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No Expense Found Start Adding Some"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            Title(
              color: Colors.black,
              child: const Text('Flutter Expense Tracker',),
            ),
           width<600
               ? SizedBox(width: 200)
               : SizedBox(width:300),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  //full space is occupied
                  context: context,
                  //this context contain metadata like this expense statefull widget information
                  builder:
                      (ctx) //this ctx contain showModalBottomSheet information
                      {
                    return NewExpenses(
                        onAddExpense:
                            _addExpense); //value onAddExpense are received here
                  },
                );
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainContent)
                ],
              ));
  }
}
