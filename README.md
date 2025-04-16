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

The `NewExpense` widget is a `StatefulWidget` that allows users to input details for a new expense. It includes a dropdown for selecting a category, along with other input fields.

#### Category Dropdown Logic

The `NewExpense` widget includes a dropdown to allow users to select a category for the expense.

```dart
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
      if (value == null) {
        return;
      }
      _selectedCategory = value;
    });
  },
),
```

- **`DropdownButton`**: A widget that displays a dropdown menu.
  - **`value`**: The currently selected category.
  - **`items`**: A list of `DropdownMenuItem` widgets, one for each category.
  - **`onChanged`**: A callback that updates the `_selectedCategory` variable when the user selects a new category.
- **`Category.values`**: An enumeration of all available categories (e.g., `food`, `travel`, `leisure`, `work`).
- **`DropdownMenuItem`**: Represents each selectable item in the dropdown.

---

#### Full Widget Code

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
            decoration: const InputDecoration(
              prefix: Text('\$'),
              label: Text('Amount'),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                _selectedDate == null
                    ? 'No Date Selected'
                    : '${_selectedDate!.toLocal()}'.split(' ')[0],
              ),
              IconButton(
                onPressed: _presentDatePicker,
                icon: const Icon(Icons.calendar_today),
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
                    if (value == null) {
                      return;
                    }
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
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                  print(_selectedDate);
                  print(_selectedCategory);
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

---

### 4. **How the Category Dropdown Works**

1. **Dropdown Initialization**:
   - The `DropdownButton` is initialized with the `_selectedCategory` variable, which holds the currently selected category.

2. **Category Options**:
   - The `items` property of the `DropdownButton` is populated with a list of `DropdownMenuItem` widgets, one for each category in the `Category` enum.

3. **Category Selection**:
   - When the user selects a category, the `onChanged` callback is triggered, updating the `_selectedCategory` variable and refreshing the UI.

4. **Save Button**:
   - The `Save Expense` button prints the selected category along with the title, amount, and date to the console.

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
            const SizedBox(height: 4),
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
3. **`new_expense.dart`** provides input fields for the title, amount, date, and category, and includes buttons for saving or canceling the input.
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

To switch to the next branch, run:

```bash
git checkout nextbranch
```

---