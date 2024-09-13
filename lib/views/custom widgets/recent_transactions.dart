import 'package:flutter/material.dart';

class RecentTransactions extends StatelessWidget {
  final String transactionName;
  final String time;
  final String date;
  final String amount;
  final Icon icon;
  const RecentTransactions({
    super.key,
    required this.transactionName,
    required this.time,
    required this.date,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactionName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink),
                ),
                Text(
                  time,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                )
              ],
            )
          ],
        ));
  }
}
