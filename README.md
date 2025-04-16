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

The `NewExpense` widget is a `StatefulWidget` that allows users to input details for a new expense. It includes a `TextField` for entering the title of the expense and a button for submission.

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
  var _enteredTitle = '';

  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: _saveTitleInput,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print('$_enteredTitle');
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

- **`TextField`**: A widget that allows users to input text.
  - **`onChanged`**: A callback that saves the input value to the `_enteredTitle` variable.
  - **`maxLength`**: Limits the input to 50 characters.
  - **`InputDecoration`**: Adds a label to the `TextField` with the text "Title".
- **`ElevatedButton`**: A button that, when pressed, prints the entered title to the console.

---

### 4. **How the Text Saving and Submission Work**

The `NewExpense` widget includes logic for saving the text input and submitting it:

1. **Saving Input**:
   - The `TextField` uses the `onChanged` callback to save the entered text to the `_enteredTitle` variable.
   - The `_saveTitleInput` method is called whenever the text changes.

   ```dart
   void _saveTitleInput(String inputValue) {
     _enteredTitle = inputValue;
   }
   ```

2. **Submitting Input**:
   - The `ElevatedButton` is used to submit the entered text.
   - When the button is pressed, the current value of `_enteredTitle` is printed to the console.

   ```dart
   ElevatedButton(
     onPressed: () {
       print('$_enteredTitle');
     },
     child: const Text('Save Expense'),
   )
   ```

This logic can be extended to validate the input or pass the entered data to other parts of the app.

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
3. **`new_expense.dart`** provides a `TextField` for users to input the title of a new expense and an `ElevatedButton` for submission.
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

To switch to the `categorydropdown` branch, run:
git checkout categorydropdown

```bash
git checkout lists
```

---