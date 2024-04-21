import 'package:flutter/material.dart';
import 'package:new_project/components/StackFramework/stack_framework.dart';
import 'package:new_project/components/Views/view1.dart';
import 'package:new_project/components/Views/view2.dart';
import 'package:new_project/components/Views/view3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color.fromARGB(255, 23, 23, 47),
      ),
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: CustomStackWidget(
          views: [
            View1(),
            View2(),
            View3(),
          ],
          ctas: const [
            'Proceed to EMI selection',
            'Select your bank account',
            'Tap for 1 click KYC',
          ],
          cycle: false,
        ),
      ),
    );
  }
}
