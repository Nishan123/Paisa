import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paisa/database/database_methods.dart';
import 'package:paisa/views/custom%20widgets/hero_card.dart';
import 'package:paisa/views/custom%20widgets/recent_transactions.dart';
import 'package:paisa/views/screens/add_transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tag = 0;
  String selectedTag = "All";
  List<String> tags = [];
  List<String> options = [
    "All",
    "Income",
    "Expenses",
    "Transfer",
  ];
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddTransactionScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi 👋,",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Username",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const HeroCard(
                availableBalance: 100.00, income: 0.00, expenses: 300.00),
            const Text("Transactions"),
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
            StreamBuilder<QuerySnapshot>(
              stream: DatabaseMethods().getTransactions(selectedTag, userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No transactions found"));
                }

                final transactionList = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: transactionList.length,
                    itemBuilder: (context, index) {
                      final transactions =
                          transactionList[index].data() as Map<String, dynamic>;

                      return RecentTransactions(
                        icon: transactions["transaction type"] == "Income"
                            ? const Icon(
                                Icons.arrow_circle_up,
                                color: Colors.green,
                                size: 30,
                              )
                            : (transactions["transaction type"] == "Expenses"
                                ? const Icon(
                                    Icons.arrow_circle_down,
                                    color: Colors.red,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.compare_arrows_outlined,
                                    size: 30,
                                    color: Colors.blue,
                                  )),
                        transactionName:
                            transactions["expance name"] ?? 'Unknown',
                        time: transactions["time"] ?? 'Unknown',
                        date: transactions["date"] ?? 'Unknown',
                        amount: transactions["amount"].toString(),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
