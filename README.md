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

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              // Action for adding a new expense
            },
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
- **`title`**: Displays the title of the app, "Flutter Expense Tracker".
- **`actions`**: A list of widgets displayed on the right side of the `AppBar`.
- **`IconButton`**: Adds a clickable icon button (with the `Icons.add` icon) to the `AppBar` for adding new expenses.

---

### 3. **How the `AppBar` is Added**

The `AppBar` is added to the `Scaffold` widget in the `Expenses` screen. It includes a title and an action button:

```dart
appBar: AppBar(
  title: const Text('Flutter Expense Tracker'),
  actions: [
    IconButton(
      onPressed: () {
        // Action for adding a new expense
      },
      icon: const Icon(Icons.add),
    ),
  ],
),
```

- **`title`**: Displays the app's title in the center of the `AppBar`.
- **`actions`**: Contains an `IconButton` that allows users to perform actions, such as adding a new expense.
- **`IconButton`**: A clickable button with an icon. In this case, it uses the `Icons.add` icon to represent adding a new expense.

The `AppBar` improves the user interface by providing a consistent navigation and action area at the top of the screen.

---

### 4. **Expenses List (`expenses_list.dart`)**

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

### 5. **Expense Item (`expense_item.dart`)**

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
3. **`expense.dart`** defines the structure of an expense and provides utility methods like `formattedDate`.
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

To switch to the `lists` branch, run:

```bash
git checkout lists
```

---

## Checkout to modal branch using git command in terminal

git checkout modal


**The order of branches from the start of the project  is**
 *starter
 *lists
 *modal
 *datasubmission
 *textController
 *datepicker
