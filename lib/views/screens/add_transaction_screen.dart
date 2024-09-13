import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paisa/database/database_methods.dart';
import 'package:paisa/views/custom%20widgets/custom_button.dart';
import 'package:paisa/views/custom%20widgets/custom_textfield.dart';
import 'package:paisa/views/custom%20widgets/date_time_selector.dart';
import 'package:random_string/random_string.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  int tag = 1;
  String selectedTag = "Expenses";
  List<String> tags = [];
  List<String> options = [
    "Income",
    "Expenses",
    "Transfer",
  ];

  TextEditingController expanceController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String transactionId = randomAlphaNumeric(8);
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String formattedDate =
      "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
  String formattedTime =
      "${TimeOfDay.now().hourOfPeriod.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')} ${TimeOfDay.now().period == DayPeriod.am ? 'AM' : 'PM'}";

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (pickedTime != null) {
      setState(() {
        formattedTime =
            "${pickedTime.hourOfPeriod.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period == DayPeriod.am ? 'AM' : 'PM'}";
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        formattedDate =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add transaction"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChipsChoice.single(
                wrapped: true,
                textDirection: TextDirection.ltr,
                value: tag,
                onChanged: (value) {
                  setState(() {
                    tag = value;
                    selectedTag = options[value];
                  });
                },
                choiceItems: C2Choice.listFrom(
                  source: options,
                  value: (i, v) => i,
                  label: (i, v) => v,
                ),
                choiceActiveStyle: const C2ChoiceStyle(
                  color: Colors.black,
                  backgroundColor: Colors.black12,
                  borderColor: Colors.black,
                ),
                choiceStyle: const C2ChoiceStyle(
                    color: Colors.black, backgroundColor: Colors.black12),
              ),
              CustomTextfield(
                hintText: selectedTag == "Transfer"
                    ? "Transfer to"
                    : "Transaction name",
                controller: expanceController,
                obscureText: false,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextfield(
                hintText: "Amount",
                controller: amountController,
                obscureText: false,
                textInputType: TextInputType.number,
                suffixIcon: const Icon(Icons.money),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Date and time"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DateTimeSelector(
                    text: formattedDate,
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                  DateTimeSelector(
                    text: formattedTime,
                    icon: const Icon(
                      Icons.watch_later_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _selectTime(context);
                    },
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                backgroundColor: Colors.black87,
                onPressed: () {
                  Map<String, dynamic> transactionMap = {
                    "expance name": expanceController.text,
                    "amount": int.tryParse(amountController.text),
                    "date": formattedDate,
                    "time": formattedTime,
                    "transaction type": selectedTag,
                  };

                  DatabaseMethods()
                      .addTransaction(userId, transactionId, transactionMap);
                  expanceController.clear();
                  amountController.clear();
                },
                text: "Add transaction",
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
