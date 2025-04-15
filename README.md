# expense_tracker

**A new Flutter project.**

## Getting Started

**This project is a starting point for a Flutter application.**
## creation of pages

**Create expenses.dart with this code**

import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {

  const Expenses({super.key});

  @override

     State<Expenses> createState() {
      return _ExpensesState();
    
  }
  
}


class _ExpensesState extends State<Expenses> {

  @override

 Widget build( context) {

  return  const  Scaffold(
    body: Column(


      children: [


        Text('The Chart'),

        Text('Expenses List..'),
      ],
    ),




  )


   
  ;}
  
}


## creation of expenses_list folder

  After creation checkout to lists branch



.
