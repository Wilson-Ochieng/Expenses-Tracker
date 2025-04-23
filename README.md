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

#### Full Widget Code

```dart
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final Function(Expense expense) onAddExpense;

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
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
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
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              )
            ],
          )
        ],
      ),
    );
  }
}
```

---

### 4. **How the Code Works Together**

1. **Amount Input Field**:
   - Allows users to input the expense amount.
   - Ensures the input is numeric and formatted with a dollar sign.

2. **Date Picker**:
   - Allows users to select a date for the expense.
   - Displays the selected date or a placeholder if no date is selected.

3. **Validation and Submission**:
   - Validates the inputs and saves the expense if all fields are valid.

---

## Installing Required Packages

To use the `uuid` and `intl` packages, run the following commands in your terminal:

```bash
flutter pub add uuid
flutter pub add intl
```

---

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
git checkout dismissiblewidget
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
 *fullscreenmodal
 *dismissiblewidget
 

---