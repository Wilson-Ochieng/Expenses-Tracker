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

### 7. **Theming and Dark Mode Logic**

The application supports both light and dark themes using `ThemeData` and `ColorScheme`. The `main.dart` file defines the theming logic.

#### Light Theme

The light theme uses a `ColorScheme` generated from a seed color. It customizes the appearance of the app, including the `AppBar`, `Card`, and `ElevatedButton`.

```dart
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

theme: ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: kColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer,
  ),
  cardTheme: const CardTheme().copyWith(
    color: kColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primaryContainer,
    ),
  ),
  textTheme: ThemeData().textTheme.copyWith(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: kColorScheme.onSecondaryContainer,
      fontSize: 16,
    ),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 247, 240, 248),
),
```

#### Dark Theme

The dark theme is also generated from a seed color and includes similar customizations for `Card` and `ElevatedButton`.

```dart
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(225, 5, 99, 125),
);

darkTheme: ThemeData.dark().copyWith(
  useMaterial3: true,
  colorScheme: kDarkColorScheme,
  cardTheme: const CardTheme().copyWith(
    color: kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.primaryContainer,
    ),
  ),
),
```

#### Theme Mode

The app uses `ThemeMode.system` to automatically switch between light and dark themes based on the system settings.

```dart
themeMode: ThemeMode.system,
```

---

### How the Theming Works

1. **Light and Dark Themes**:
   - The `kColorScheme` and `kDarkColorScheme` variables define the color schemes for light and dark modes, respectively.
   - These schemes are applied to the `ThemeData` for light and dark themes.

2. **Customizations**:
   - The `AppBar`, `Card`, and `ElevatedButton` widgets are customized for both themes.
   - The `textTheme` is also customized for the light theme.

3. **Theme Switching**:
   - The `themeMode` property is set to `ThemeMode.system`, which automatically applies the appropriate theme based on the user's system settings.

---

### Code Example for Theming and Dark Mode

Here is the full theming logic from `main.dart`:

```dart
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(225, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 247, 240, 248),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}



### 8. **Chart Logic (`chart.dart`)**

The `Chart` widget provides a visual representation of the expenses grouped by category. It is displayed at the top of the `Expenses` screen.

#### How the Chart is Created

1. **Expense Buckets**:
   - The `Chart` widget uses the `ExpenseBucket` class to group expenses by category (e.g., food, leisure, travel, work).
   - The `buckets` getter creates a list of `ExpenseBucket` objects, one for each category, using the `ExpenseBucket.forCategory` method.

   ```dart
   List<ExpenseBucket> get buckets {
     return [
       ExpenseBucket.forCategory(expenses, Category.food),
       ExpenseBucket.forCategory(expenses, Category.leisure),
       ExpenseBucket.forCategory(expenses, Category.travel),
       ExpenseBucket.forCategory(expenses, Category.work),
     ];
   }
   ```

2. **Maximum Expense**:
   - The `maxTotalExpense` getter calculates the maximum total expense across all categories. This value is used to determine the height of each bar in the chart.

   ```dart
   double get maxTotalExpense {
     double maxTotalExpense = 0;

     for (final bucket in buckets) {
       if (bucket.totalExpenses > maxTotalExpense) {
         maxTotalExpense = bucket.totalExpenses;
       }
     }

     return maxTotalExpense;
   }
   ```

3. **Chart Bars**:
   - The `ChartBar` widget is used to represent each category as a vertical bar. The height of the bar is proportional to the total expenses in that category relative to the maximum expense.

   ```dart
   for (final bucket in buckets)
     ChartBar(
       fill: bucket.totalExpenses == 0
           ? 0
           : bucket.totalExpenses / maxTotalExpense,
     )
   ```

4. **Icons for Categories**:
   - Below the chart bars, icons representing each category are displayed. These icons are styled based on the current theme (light or dark mode).

   ```dart
   Row(
     children: buckets
         .map(
           (bucket) => Expanded(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 4),
               child: Icon(
                 categoryIcons[bucket.category],
                 color: isDarkMode
                     ? Theme.of(context).colorScheme.secondary
                     : Theme.of(context).colorScheme.primary.withOpacity(0.7),
               ),
             ),
           ),
         )
         .toList(),
   )
   ```

5. **Styling**:
   - The chart is styled with a gradient background and rounded corners. The gradient changes based on the theme.

   ```dart
   decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(8),
     gradient: LinearGradient(
       colors: [
         Theme.of(context).colorScheme.primary.withOpacity(0.3),
         Theme.of(context).colorScheme.primary.withOpacity(0.0)
       ],
       begin: Alignment.bottomCenter,
       end: Alignment.topCenter,
     ),
   ),
   ```

---

#### How the Chart is Added to the `Expenses` Widget

1. **Integration in `Expenses`**:
   - The `Chart` widget is added to the `Expenses` widget's `body` property. It is displayed above the list of expenses.

   ```dart
   body: Column(
     children: [
       Chart(expenses: _registeredExpenses),
       Expanded(child: mainContent),
     ],
   ),
   ```

2. **Dynamic Updates**:
   - The `Chart` widget receives the `_registeredExpenses` list as a parameter. Whenever the list is updated (e.g., an expense is added or removed), the chart automatically updates to reflect the changes.

---

### Code Example for Chart Integration

Here is the relevant code from the `Expenses` widget:

```dart
@override
Widget build(context) {
  Widget mainContent = const Center(
    child: Text('No expenses found. Start adding some!'),
  );

  if (_registeredExpenses.isNotEmpty) {
    mainContent = ExpensesList(
      expenses: _registeredExpenses,
      onRemoveExpense: _removeExpense,
    );
  }

  return Scaffold(
    appBar: AppBar(
      title: const Text('Flutter Expense Tracker'),
      actions: [
        IconButton(
          onPressed: _openAddExpenseOverlay,
          icon: const Icon(Icons.add),
        )
      ],
    ),
    body: Column(
      children: [
        Chart(expenses: _registeredExpenses),
        Expanded(child: mainContent),
      ],
    ),
  );
}
```

---

### How the Chart Works Together with Other Widgets

1. **Data Flow**:
   - The `Expenses` widget manages the state of the `_registeredExpenses` list.
   - The `Chart` widget receives this list and calculates the total expenses for each category.

2. **Dynamic Updates**:
   - When an expense is added or removed, the `setState` method in the `Expenses` widget triggers a rebuild, updating both the chart and the list of expenses.

3. **Visual Representation**:
   - The chart provides a quick overview of spending by category, while the list displays detailed information about individual expenses.
```
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
git checkout 
```

---chart

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
- **theming**
- **chart**


---

To switch to the next branch, run:

```bash
git checkout chart
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
 *theming
 *chart
 

---