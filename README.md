# Expense Tracker

**A new Flutter project.**

## Getting Started

This project is a starting point for a Flutter application.

---

## Step-by-Step Guide to File Creation and Code Explanation

### 1. **Main Entry Point (`main.dart`)**

The `main.dart` file is the entry point of the Flutter application. It initializes the app and sets the `Expenses` widget as the home screen.

```dart
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Expenses(),
    ),
  );
}
```

- **`MaterialApp`**: Wraps the app with Material Design.
- **`Expenses`**: The main widget that displays the expenses screen.

---

### 2. **Expenses Screen (`expenses.dart`)**

The `Expenses` widget is a `StatefulWidget` that manages the state of the expenses list. It displays a chart placeholder, a list of expenses, and an `AppBar` with a title and an action button.

```dart
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Eatery',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Picnic',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.travel),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
```

- **`AppBar`**: Displays a top bar with a title and an action button.
- **`IconButton`**: Adds a clickable icon button (with the `Icons.add` icon) to the `AppBar` for adding new expenses.
- **`showModalBottomSheet`**: Displays a modal bottom sheet when the `IconButton` is pressed.

---

### 3. **New Expense Screen (`new_expense.dart`)**

The `NewExpense` widget is a `StatefulWidget` that allows users to input details for a new expense. It includes validation logic to ensure that all required fields are filled correctly before saving the expense.

#### Validation Logic

The `_submitExpenseData` method validates the user input for the following fields:
1. **Title**: Ensures the title is not empty.
2. **Amount**: Ensures the amount is a valid number greater than 0.
3. **Date**: Ensures a date is selected.

```dart
void _submitExpenseData() {
  final enteredAmount = double.tryParse(_amountController.text);
  final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

  if (_titleController.text.trim().isEmpty ||
      amountIsInvalid ||
      _selectedDate == null) {
    // Show an error message if validation fails
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text(
            'Please make sure a valid title, amount, date, and category are entered.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
    return;
  }

  // If validation passes, save the expense
  print('Title: ${_titleController.text}');
  print('Amount: $enteredAmount');
  print('Date: $_selectedDate');
  print('Category: $_selectedCategory');
}
```

- **Validation Steps**:
  1. **Title**: Checks if the title is empty using `_titleController.text.trim().isEmpty`.
  2. **Amount**: Converts the input to a double using `double.tryParse` and checks if it is `null` or less than or equal to 0.
  3. **Date**: Checks if `_selectedDate` is `null`.

- **Error Handling**:
  - If any validation fails, an `AlertDialog` is displayed with an error message.
  - The dialog includes an "Okay" button to close it.

---

#### Full Widget Code

```dart
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: DateTime.now(),
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date, and category are entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    print('Title: ${_titleController.text}');
    print('Amount: $enteredAmount');
    print('Date: $_selectedDate');
    print('Category: $_selectedCategory');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Amount'),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date selected'
                        : '${_selectedDate!.toLocal()}'.split(' ')[0]),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) return;
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

---

### 4. **How the Code Works Together**

1. **Validation**: Ensures all required fields are filled correctly before saving the expense.
2. **Error Handling**: Displays an error dialog if validation fails.
3. **Save Expense**: Prints the entered data to the console if validation passes.

---

## Installing Required Packages

To use the `uuid` and `intl` packages, run the following commands in your terminal:

```bash
flutter pub add uuid
flutter pub add intl
```

---

---

## Branching Instructions

- **Starter Branch**: Contains the initial setup for the project.
- **Lists Branch**: Contains the implementation of the expenses list.

To switch to the next branch, run:

```bash
git checkout saveexpense
```

**The order of branches from the start of the project  is**
 *starter
 *lists
 *modal
 *datasubmission
 *textController
 *datepicker
 *categorydropdown
 *saveexpense

---