import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class View2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> isSelected = List.generate(6, (index) => false);
  int selectedIndex = -1;
  final List<Color> customColors = [
    Colors.grey,
    Colors.purpleAccent,
    Colors.orange,
    Colors.indigo,
    Colors.amber,
    Colors.teal,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 20,
        ),
        // Container with text layers
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            //color: Color.fromARGB(255, 34, 31, 31),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'how do you wish to repay?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 156, 197, 230),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'choose one of our recommended plans or make your own',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 156, 197, 230),
                ),
              ),
            ],
          ),
        ),
        // Container with selectable squares
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          height: 200, // Adjust height as needed
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              6,
              (index) => _buildSquare(index),
            ),
          ),
        ),
        // Container with customizable button
        GestureDetector(
          onTap: () {
            // Handle button tap
            null;
            print('Button tapped');
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              //color: Colors.blue,
              border: Border.all(color: Color.fromARGB(255, 103, 124, 142)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Create your own plan',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 156, 197, 230),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSquare(int index) {
    int temp = index + 1;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index == selectedIndex ? -1 : index;
        });
      },
      child: Container(
        width: 200,
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[600]!),
          borderRadius: BorderRadius.circular(5),
          color: customColors[index],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedIndex == index
                ? Positioned(
                    child: Icon(
                    Icons.check,
                    color: Colors.blue,
                  ))
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color.fromARGB(255, 31, 22, 22)),
                      color: const Color.fromARGB(255, 195, 190, 190),
                    ),
                    height: 25,
                    width: 25,
                  ),
            SizedBox(width: 8),
            Container(
              width: 70, // Adjust width as needed
              height: 50, // Adjust height as needed
              child: Text(
                'Plan $temp',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
