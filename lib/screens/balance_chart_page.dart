import 'package:flutter/material.dart';

import '../widgets/balance_chart.dart';

class BalanceChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(
          left: deviceSize.width * .075,
          bottom: 15,
        ),
        child: Text(
          'Your weeks focus at glance:',
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.left,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: deviceSize.width * .075),
        child: Row(
          children: [
            RotatedBox(
              child:
                  Text('Tasks', style: Theme.of(context).textTheme.bodyText1),
              quarterTurns: 3,
            ),
            SizedBox(
              height: 400,
              width: deviceSize.width * .87,
              child: BalanceChart(),
            ),
          ],
        ),
      ),
    ]);
  }
}
