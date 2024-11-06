// just for list view builder this file is created

import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widget/Expenses-list/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
  required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
         itemCount: expenses.length,
        itemBuilder: (context,index)
        {
            return Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),),
              onDismissed: (direction)
              {
                onRemoveExpense(expenses[index]);
              },
                key: ValueKey(expenses[index]),     //to delete correct data
                child: ExpenseItem(expenses[index]),   //giving the access of expenses which has access of _registeredExpenses
            );
        },
    );
  }
}
