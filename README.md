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
      builder: (ctx) => const Text('Modal bottom sheet'),
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

The `NewExpense` widget is a `StatefulWidget` that allows users to input details for a new expense. It uses `TextEditingController` to manage the input fields and includes a `Cancel` button to close the modal.

```dart
import 'package:flutter/material.dart';

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
          TextField(
            controller: _amountController,
            maxLength: 50,
            decoration: const InputDecoration(
              prefix: Text('\$'),
              label: Text('Amount'),
            ),
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                },
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

- **`TextEditingController`**: Used to manage the input fields for the title and amount.
  - **`_titleController`**: Manages the title input field.
  - **`_amountController`**: Manages the amount input field.
- **`dispose`**: Disposes of the controllers when the widget is removed from the widget tree to free up resources.
- **`TextButton`**: A button labeled "Cancel" that closes the modal using `Navigator.pop(context)`.
- **`ElevatedButton`**: A button labeled "Save Expense" that prints the entered title and amount to the console.

---

### 4. **How the `TextEditingController` and `Cancel` Button Work**

1. **`TextEditingController`**:
   - The `TextEditingController` is assigned to the `controller` property of the `TextField`.
   - It allows you to retrieve the current value of the input field using `.text`.

   ```dart
   final _titleController = TextEditingController();
   final _amountController = TextEditingController();
   ```

   - The values are accessed when the "Save Expense" button is pressed:

   ```dart
   ElevatedButton(
     onPressed: () {
       print(_titleController.text);
       print(_amountController.text);
     },
     child: const Text('Save Expense'),
   )
   ```

2. **`Cancel` Button**:
   - The `Cancel` button uses `Navigator.pop(context)` to close the modal bottom sheet when pressed.

   ```dart
   TextButton(
     onPressed: () {
       Navigator.pop(context);
     },
     child: const Text('Cancel'),
   )
   ```

This logic ensures that users can either save their input or cancel the operation and close the modal.

---

### 5. **Expenses List (`expenses_list.dart`)**

The `ExpensesList` widget displays a list of expenses using a `ListView.builder`.

```dart
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => ExpenseItem(expenses[index]));
  }
}
```

- **`ListView.builder`**: Efficiently builds the list of expenses.
- **`ExpenseItem`**: A widget that displays individual expense details.

---

### 6. **Expense Item (`expense_item.dart`)**

The `ExpenseItem` widget displays the details of a single expense in a card format.

```dart
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Icon(categoryIcons[expense.category]),
                const SizedBox(width: 8),
                Text(expense.formattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

- **`Card`**: Displays the expense details in a card layout.
- **`Row`**: Aligns the amount, category icon, and formatted date horizontally.

---

## How the Code Works Together

1. **`main.dart`** initializes the app and sets `Expenses` as the home screen.
2. **`expenses.dart`** manages the state of the expenses list, displays the chart placeholder, the list of expenses, and includes an `AppBar` with a title and an action button.
3. **`new_expense.dart`** provides input fields for the title and amount using `TextEditingController` and includes a `Cancel` button to close the modal.
4. **`expenses_list.dart`** builds the list of expenses using `ExpenseItem`.
5. **`expense_item.dart`** displays the details of a single expense in a card format.

---

## Installing Required Packages

To use the `uuid` and `intl` packages, run the following commands in your terminal:

```bash
flutter pub add uuid
flutter pub add intl
```

---

## Branching Instructions

- **Starter Branch**: Contains the initial setup for the project.
- **Lists Branch**: Contains the implementation of the expenses list.


## To checkout to the next branch use the following git command:
git checkout datepicker


**The order of branches from the start of the project  is**
 *starter
 *lists
 *modal
 *datasubmission
 *textController
 *datepicker
```

---