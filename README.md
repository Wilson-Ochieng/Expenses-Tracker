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

#### Saving Expense Logic

The `Expenses` widget contains the `_addExpense` function, which is responsible for adding a new expense to the list of registered expenses. This function is passed as an argument to the `NewExpense` widget and executed when the user submits a new expense.

```dart
void __addExpense(Expense expense) {
  setState(() {
    _registeredExpenses.add(expense);
  });
}
```

- **`__addExpense`**:
  - Takes an `Expense` object as an argument.
  - Adds the new expense to the `_registeredExpenses` list using `setState` to update the UI.

---

### 3. **New Expense Screen (`new_expense.dart`)**

The `NewExpense` widget allows users to input details for a new expense. It includes fields for the title, amount, date, and category, and provides validation to ensure all inputs are valid.

#### Amount Input Field

The amount input field allows users to enter the expense amount. It uses a `TextField` with a `TextEditingController` to manage the input.

```dart
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
```

- **`controller`**: Manages the input value for the amount.
- **`prefixText`**: Adds a dollar sign (`$`) before the input to indicate currency.
- **`keyboardType`**: Sets the keyboard type to `TextInputType.number` to allow numeric input.

---

#### Date Picker

The date picker allows users to select a date for the expense. It uses a `Row` widget to display the selected date and an `IconButton` to open the date picker dialog.

```dart
Expanded(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(_selectedDate == null
          ? 'No Date selected'
          : formatter.format(_selectedDate!)),
      IconButton(
        onPressed: _presentDatePicker,
        icon: const Icon(
          Icons.calendar_month,
        ),
      ),
    ],
  ),
),
```

- **`_selectedDate`**:
  - Displays "No Date selected" if no date is selected.
  - Displays the formatted date if a date is selected.
- **`IconButton`**:
  - Opens the date picker dialog when pressed.
  - Uses the `Icons.calendar_month` icon to represent the date picker.

---

### 4. **Expenses List (`expenses_list.dart`)**

The `ExpensesList` widget displays a list of expenses using a `ListView.builder`. It also includes a `Dismissible` widget to allow users to remove expenses by swiping them.

#### Dismissible Widget Logic

The `Dismissible` widget wraps each expense item and allows it to be swiped away. When an item is dismissed, the `onRemoveExpense` function is called to remove the expense from the list.

```dart
return ListView.builder(
  itemCount: expenses.length,
  itemBuilder: (ctx, index) => Dismissible(
    key: ValueKey(expenses[index]),
    onDismissed: (direction) {
      onRemoveExpense(expenses[index]);
    },
    child: ExpenseItem(expenses[index]),
  ),
);
```

- **`Dismissible`**:
  - Wraps each expense item to make it swipeable.
  - **`key`**: A unique key for each item, required for the `Dismissible` widget to track the item.
  - **`onDismissed`**: A callback triggered when the item is swiped away. It calls the `onRemoveExpense` function to remove the expense from the list.

---

#### Full Widget Code

```dart
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
```

- **`onRemoveExpense`**:
  - A function passed from the `Expenses` widget to remove an expense from the list.
  - Called when an item is swiped away.

---

### 5. **How the Code Works Together**

1. **`Dismissible` Widget**:
   - Wraps each expense item in the `ExpensesList` widget.
   - Allows users to swipe an item to remove it.

2. **`onRemoveExpense` Function**:
   - Passed from the `Expenses` widget to the `ExpensesList` widget.
   - Removes the swiped expense from the list and updates the UI.

3. **State Management**:
   - The `Expenses` widget manages the state of the expenses list.
   - The `setState` method is used to update the list when an expense is removed.

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
- **Modal Branch**: Adds the modal bottom sheet for adding expenses.
- **DataSubmission Branch**: Implements data submission logic.
- **TextController Branch**: Adds `TextEditingController` for managing input fields.
- **DatePicker Branch**: Adds the date picker for selecting expense dates.
- **CategoryDropdown Branch**: Adds a dropdown for selecting expense categories.
- **SaveExpense Branch**: Implements the logic for saving expenses.
- **FullscreenModal Branch**: Makes the modal fullscreen and ensures proper padding.
- **DismissibleWidget Branch**: Adds the `Dismissible` widget for removing expenses.

To switch to the next branch, run:

```bash
git checkout dismissiblewidget
```

---