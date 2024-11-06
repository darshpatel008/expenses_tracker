
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';


class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense,{super.key});


  final Expense expense;     //this expense var is different

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Card(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(expense.title,
                style: Theme.of(context).textTheme.titleLarge),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('\$${expense.amount.toStringAsFixed(2)}'),
                  ),
                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(categoryIcons[expense.category]),
                        const SizedBox(width: 8),
                        Text(expense.formattedDatte),
                      ],
                    ),
                  )
                ],
              )
            ],
          )
      ),
    );

  }
}
