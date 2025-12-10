import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  final Function(Expense) onExpenseCreated;
  const ExpenseForm({required this.onExpenseCreated, super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void onCreate() {
    // 1 - Create the new expense

    String title = _titleController.text;
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a title")),
      );
      return;
    }

    double amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid amount")),
      );
      return;
    }

    DateTime? date = _selectedDate;
    Category category = _selectedCategory;

    Expense newExpense = Expense(
      title: title,
      amount: amount,
      date: date ?? DateTime.now(),
      category: category,
    );

    // 2  - Forward the new expense to the parent
    widget.onExpenseCreated(newExpense);

    // 3- Close the modal
    Navigator.pop(context);
  }

  void onCancel() {
    Navigator.pop(context);
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add Expense",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),

          // Title Input
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),

          // Amount Input and Date Picker
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(label: Text("Amount")),
                  keyboardType: TextInputType.number,
                  maxLength: 50,
                ),
              ),
              SizedBox(width: 20),
              Text(
                _selectedDate == null
                    ? 'No date selected'
                    : DateFormat.yMMMd().format(_selectedDate!),
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(width: 5),
              IconButton(
                onPressed: _selectDate,
                icon: Icon(Icons.calendar_today),
              ),
            ],
          ),

          SizedBox(height: 20),
          Row(
            children: [
              // Category Dropdown
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<Category>(
                  value: _selectedCategory,
                  items: Category.values.map((Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (Category? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    }
                  },
                ),
              ),
              SizedBox(width: 20),
              // Action Buttons
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                  ),
                  onPressed: onCreate,
                  child: Text("Create", style: TextStyle(color: Colors.grey[800])),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onCancel,
                  child: Text("Cancel", style: TextStyle(color: Colors.grey[800])),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
