import 'package:flutter/material.dart';

class ChartContent extends StatelessWidget {
  final int weeklyTransact;
  final int monthlyTransact;
  final int total;

  ChartContent(this.weeklyTransact, this.monthlyTransact, this.total);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Total: ",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            (weeklyTransact >= 0)
                ? Text(
                    "\u{20B9}$total",
                    style: const TextStyle(
                      fontSize: 27,
                      color: Colors.green,
                      fontFamily: '',
                    ),
                  )
                : Text(
                    "- \u{20B9}${total.abs()}",
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                      fontFamily: '',
                    ),
                  ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "This Week: ",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            (weeklyTransact >= 0)
                ? Text(
                    "\u{20B9}$weeklyTransact",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontFamily: '',
                    ),
                  )
                : Text(
                    "- \u{20B9}${weeklyTransact.abs()}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontFamily: '',
                    ),
                  ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Last 28 Days: ",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                // fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            (monthlyTransact >= 0)
                ? Text(
                    "\u{20B9}$monthlyTransact",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontFamily: '',
                    ),
                  )
                : Text(
                    "- \u{20B9}${monthlyTransact.abs()}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontFamily: '',
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
