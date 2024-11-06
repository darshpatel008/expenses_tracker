
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key,required this.onAddExpense});


  final void Function(Expense expense) onAddExpense;      //accepting function as an input

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {

  final textcontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;    //initial value


  @override
  void dispose() {
    textcontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year-1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

 void _showDialog()
 {
   if(Platform.isIOS)
     {
       showCupertinoDialog(context: context, builder: (ctx)
       {
         return CupertinoAlertDialog
           (
             title: Text('Invalid input'),
             content: Text('Please make sure a Title, Amount, Date and Category are entered..'),
             actions: [
               TextButton(onPressed: (){
                 Navigator.of(context).pop();
               }, child: Text('Okay'))
             ]
           );
        }
       );
     }
   else
   {
     showDialog(context: context, builder: (ctx)
     {
       return AlertDialog(
           title: Text('Invalid input'),
           content: Text('Please make sure a Title, Amount, Date and Category are entered..'),
           actions: [
             TextButton(onPressed: (){
               Navigator.of(context).pop();
             }, child: Text('Okay'))
           ]
       );
     },
     );
   }

 }
  void _submitExpenseData()
  {
    final enteredAmount = double.tryParse(amountcontroller.text);
    final amountInvalid = enteredAmount ==null || enteredAmount<=0;
        if(textcontroller.text.trim().isEmpty || amountInvalid || _selectedDate == null)
          {
               _showDialog();
               return;
          }

        widget.onAddExpense(Expense(
            title: textcontroller.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory),
        );
    Navigator.of(context).pop();   //otherwise showmodelbottomsheet will only be showm but expense is save
  }

  @override
  Widget build(BuildContext context) {

    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx,constraints){
      final width = constraints.maxWidth;


       return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16,16,16,keyboardSpace+16),
            child: Column(
              children: [
                if(width>=600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textcontroller,
                            decoration: const InputDecoration(label: Text('Title')),
                          ),
                        ),
                        const SizedBox(width: 25),

                        Expanded(
                          child: TextField(
                            controller: amountcontroller,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                                prefixText: '\$ ',
                                label: Text('Amount')),
                          ),
                        ),
                      ],
                    )
                else
                TextField(
                  controller: textcontroller,
                  decoration: const InputDecoration(label: Text('Title')),
                ),
                if(width>=600)
                  Row(
                   children:
                   [
                     DropdownButton(
                       value: _selectedCategory ,  //specific selected value display on button
                       items: Category.values.map(   //map is used to convert enum into String
                             (category) => DropdownMenuItem(
                           value: category,    //specific value selected by user
                           child: Text(category.name.toUpperCase()),  //name property are must used to convert into String
                         ),
                       ).toList(),

                       onChanged: (value)
                       {   //controller cant be used in dropdownbutton
                         if(value == null)
                         {
                           return;
                         }
                         setState(() {
                           _selectedCategory = value;
                         });
                       },
                     ),
                     const SizedBox(width: 24),

                     Expanded(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(_selectedDate == null
                               ? 'no date selected'
                               : formatter.format(
                               _selectedDate!) //formatter came from expense.dart
                           ),
                           IconButton(
                             onPressed: () {
                               _presentDatePicker();
                             },
                             icon: Icon(Icons.date_range),
                           )
                         ],
                       ),
                     )
                   ],
                  )
                else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: amountcontroller,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount')),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? 'no date selected'
                              : formatter.format(
                              _selectedDate!) //formatter came from expense.dart
                          ),
                          IconButton(
                            onPressed: () {
                              _presentDatePicker();
                            },
                            icon: Icon(Icons.date_range),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                if(width>=600)
                  Row(
                    children:
                    [
                      const  SizedBox(width: 70),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child:const Text('Cancel'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense')),
                    ],
                  )
                else
                Row(
                  children: [

                    DropdownButton(
                      value: _selectedCategory ,  //specific selected value display on button
                      items: Category.values.map(   //map is used to convert enum into String
                            (category) => DropdownMenuItem(
                          value: category,    //specific value selected by user
                          child: Text(category.name.toUpperCase()),  //name property are must used to convert into String
                        ),
                      ).toList(),

                      onChanged: (value)
                      {   //controller cant be used in dropdownbutton
                        if(value == null)
                        {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),

                    const  SizedBox(width: 70),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:const Text('Cancel'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense')),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

  }
}
