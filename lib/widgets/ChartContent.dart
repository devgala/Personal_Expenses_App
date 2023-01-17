import 'package:flutter/material.dart';

class ChartContent extends StatelessWidget {
  final int weeklyTransact;
  final int monthlyTransact;
  ChartContent(this.weeklyTransact, this.monthlyTransact);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "This Week: ",
                  style: TextStyle(
                    fontSize: 18,
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
                          fontSize: 35,
                          color: Colors.green,
                        ),
                      )
                    : Text(
                        "- \u{20B9}${weeklyTransact.abs()}",
                        style: const TextStyle(
                          fontSize: 35,
                          color: Colors.red,
                          fontFamily:  '',
                        ),
                      ),
              ],
            ),
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Last 28 Days: ",
                style: TextStyle(
                  fontSize: 18,
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
                  fontSize: 35,
                  color: Colors.green,
                  fontFamily: '',
                ),
              )
                  : Text(
                "- \u{20B9}${monthlyTransact.abs()}",
                style: const TextStyle(
                  fontSize: 35,
                  color: Colors.red,
                  fontFamily: '',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
