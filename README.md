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

#### Snackbar Logic for Undoing Expense Removal

The `Snackbar` is used to notify the user when an expense is removed and provides an "Undo" action to restore the removed expense to its original position in the list.

```dart
void _removeExpense(Expense expense) {
  final expenseIndex = _registeredExpenses.indexOf(expense); // Store the index of the removed item

  setState(() {
    _registeredExpenses.remove(expense); // Remove the expense from the list
  });

  ScaffoldMessenger.of(context).clearSnackBars(); // Clear any existing SnackBars
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('Expense deleted'), // Notify the user
      duration: const Duration(seconds: 3), // Show the Snackbar for 3 seconds
      action: SnackBarAction(
        label: 'Undo', // Provide an "Undo" action
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense); // Restore the expense
          });
        },
      ),
    ),
  );
}
```

- **`ScaffoldMessenger.of(context).showSnackBar`**:
  - Displays a `Snackbar` at the bottom of the screen.
  - Notifies the user that an expense has been deleted.

- **`SnackBarAction`**:
  - Adds an "Undo" button to the `Snackbar`.
  - When pressed, the removed expense is restored to its original position in the list using `insert`.

- **`clearSnackBars`**:
  - Clears any existing `SnackBar` messages to avoid stacking multiple notifications.

---

### 3. **How the Snackbar Logic Works**

1. **Removing an Expense**:
   - When an expense is removed, its index is stored in the `expenseIndex` variable.
   - The expense is removed from the `_registeredExpenses` list using `remove`.

2. **Displaying the Snackbar**:
   - A `Snackbar` is displayed with a message ("Expense deleted") and an "Undo" action.

3. **Undoing the Removal**:
   - If the "Undo" action is pressed, the removed expense is restored to its original position in the list using `insert`.

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

### 5. **How the Code Works Together**

1. **`Dismissible` Widget**:
   - Wraps each expense item in the `ExpensesList` widget.
   - Allows users to swipe an item to remove it.

2. **`onRemoveExpense` Function**:
   - Passed from the `Expenses` widget to the `ExpensesList` widget.
   - Removes the swiped expense from the list and updates the UI.

3. **Snackbar Logic**:
   - Notifies the user when an expense is removed.
   - Provides an "Undo" action to restore the removed expense.

4. **State Management**:
   - The `Expenses` widget manages the state of the expenses list.
   - The `setState` method is used to update the list when an expense is removed or restored.

---

### 6. **Code Example for Snackbar Logic**

Here is the full updated `_removeExpense` function:

```dart
void _removeExpense(Expense expense) {
  final expenseIndex = _registeredExpenses.indexOf(expense); // Store the index of the removed item

  setState(() {
    _registeredExpenses.remove(expense); // Remove the expense from the list
  });

  ScaffoldMessenger.of(context).clearSnackBars(); // Clear any existing SnackBars
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('Expense deleted'), // Notify the user
      duration: const Duration(seconds: 3), // Show the Snackbar for 3 seconds
      action: SnackBarAction(
        label: 'Undo', // Provide an "Undo" action
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense); // Restore the expense
          });
        },
      ),
    ),
  );
}
```

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
- **Snackbars Branch**: Adds the `Snackbar` logic for undoing expense removal.

To switch to the next branch, run:

```bash
git checkout snackbars
```

---

**The order of branches from the start of the project is:**
- **starter**
- **lists**
- **modal**
- **datasubmission**
- **textController**
- **datepicker**
- **categorydropdown**
- **saveexpense**
- **fullscreenmodal**
- **dismissiblewidget**
- **snackbars**

---

To switch to the next branch, run:

```bash
git checkout snackbars
```

---

**The order of branches from the start of the project  is**
 *starter
 *lists
 *modal
 *datasubmission
 *textController
 *datepicker
 *categorydropdown
 *saveexpense
 *fullscreenmodal
 *dismissiblewidget
 *snackbars
 

---