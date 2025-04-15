# expense_tracker

**A new Flutter project.**

## Getting Started

**This project is a starting point for a Flutter application.**
## creation of additional folders and  pages

**Create a folder called widgets.For readability move all components including expenses.dart file to widgets folder**

**Create a folder called model and in it create  an expense.dart file with code below**
```import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMEd();
const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

//use a getter

  String get formattedDate {
    return formatter.format(date);
  }
}
```

🔸 It defines:
A class called Expense that holds:

A title (like "Lunch")

An amount (like 15.50)

A date (when you spent the money)

A category (like food or travel)

A unique ID (automatically created using a package)

🔸 It uses two packages:
uuid

💡 Used to create a unique ID for each expense.

🔧 So each expense can be uniquely identified.

intl

📆 Used to format the date so it looks nice (like "Apr 15, 2025" instead of just numbers).

**🧑‍💻 How to Install the Packages in Flutter**

 * Step 1: Open your terminal
 * Step 2: Run these commands one by one:

 * flutter pub add uuid
 * flutter pub add intl



## creation of expenses_list folder

  After creation checkout to lists branch



.
