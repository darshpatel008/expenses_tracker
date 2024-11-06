
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';



final formatter = DateFormat().add_yMd();

const uuid = Uuid();

enum Category {food ,travel, leisure, work} //enum is used bcz user can't write any other String value



const categoryIcons =                    //categoryIcons is for expense_item
{
  Category.food : Icons.lunch_dining,
  Category.leisure:Icons.movie,
  Category.work: Icons.work,
  Category.travel: Icons.flight,
};

class Expense {

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Category category;

  String get formattedDatte
  {
    return formatter.format(date);
  }

}


class ExpenseBucket
{
  const ExpenseBucket
      ({
         required this.category,
         required this.expenses
      });


  ExpenseBucket.forCateogary(List<Expense> allExpense, this.category) //used to give a filter of icons for diff expenses
  :expenses = allExpense
      .where((expense)
  {
        return expense.category == category;
  }).toList();


  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0 ;

    for(final expense in expenses)
      {
        sum += expense.amount; //sum = sum + expense.amount
      }
    return sum;
  }

}