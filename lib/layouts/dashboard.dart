import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Column(children: [],),
      ),
      onWillPop: () => Future.value(false),
    );
  }
}


// {
//   'status': true,
// "data": {
//     "company1": {"reseiptcount":190, "count": 122},
// "compant2": {},
// },
//
// }
// }