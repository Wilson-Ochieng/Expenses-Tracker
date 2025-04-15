import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final  _titleController =  TextEditingController();
   final  _amountController =  TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
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

              TextButton(onPressed: () {

                Navigator.pop(context);
              }, child: Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                },
                child: const Text('Save Expense'),
              )
            ],
          )
        ],
      ),
    );
  }
}
