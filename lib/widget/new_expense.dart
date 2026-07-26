import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  // var _enterTitle = '';

  // void _saveTiteInput(String inputValue) {
  //   _enterTitle = inputValue;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text("Invalid Input"),
          content: Text(
            "Please make sure a valid title, amount, and date were entered.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Invalid Input"),
          content: Text(
            "Please make sure a valid title, amount, and date were entered.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
      _amountController.text,
    ); // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constants) {
        final width = constants.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              labelText: "Title",
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      // onChanged: _saveTiteInput,/
                      controller: _titleController,
                      maxLength: 50,
                      decoration: InputDecoration(label: Text("Title")),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              _selectedCategory = value;
                            });
                          },
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration: InputDecoration(
                              prefixText: "\$",
                              labelText: "Amount",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selectedCategory = value;
                          });
                        },
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: Text("Save Expense"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // return SizedBox(
    //   height: double.infinity,
    //   child: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
    //       child: Column(
    //         children: [
    //           TextField(
    //             // onChanged: _saveTiteInput,/
    //             controller: _titleController,
    //             maxLength: 50,
    //             decoration: InputDecoration(label: Text("Title")),
    //           ),
    //           Row(
    //             children: [
    //               Expanded(
    //                 child: TextField(
    //                   controller: _amountController,
    //                   decoration: InputDecoration(
    //                     prefixText: "\$",
    //                     labelText: "Amount",
    //                   ),
    //                   keyboardType: TextInputType.number,
    //                 ),
    //               ),
    //               SizedBox(width: 16),
    //               Expanded(
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       _selectedDate == null
    //                           ? 'No date selected'
    //                           : formatter.format(_selectedDate!),
    //                     ),
    //                     IconButton(
    //                       onPressed: _presentDatePicker,
    //                       icon: Icon(Icons.calendar_month),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 16),
    //           Row(
    //             children: [
    //               DropdownButton(
    //                 value: _selectedCategory,
    //                 items: Category.values
    //                     .map(
    //                       (category) => DropdownMenuItem(
    //                         value: category,
    //                         child: Text(category.name.toUpperCase()),
    //                       ),
    //                     )
    //                     .toList(),
    //                 onChanged: (value) {
    //                   setState(() {
    //                     if (value == null) {
    //                       return;
    //                     }
    //                     _selectedCategory = value;
    //                   });
    //                 },
    //               ),
    //               Spacer(),
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //                 child: Text("Cancel"),
    //               ),
    //               ElevatedButton(
    //                 onPressed: _submitExpenseData,
    //                 child: Text("Save Expences"),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
