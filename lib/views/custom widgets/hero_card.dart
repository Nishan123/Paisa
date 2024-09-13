import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  final double availableBalance;
  final double income;
  final double expenses;

  const HeroCard({
    super.key,
    required this.availableBalance,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.pink, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Available balance",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            availableBalance.toString(),
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Income",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Text(
                    income.toString(),
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                width: 110,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Expenses",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Text(
                    expenses.toString(),
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
