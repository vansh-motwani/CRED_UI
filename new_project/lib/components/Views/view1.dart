import 'dart:math';

import 'package:flutter/material.dart';

class View1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900], // Navy blue color for the background
      child: Stack(
        children: [
          // Your background widget
          BackgroundWidget(), // You'll need to define this widget
          Positioned(
            top: 170,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(10), // Add padding to the container
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'nikunj, how much do you need?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5), // Add spacing between heading and text
                  Text(
                    'move the dial and set any amount you need upto 487,891',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: WidgetContainer(
              child: CreditWidget(
                creditAmount: 150000, // Initial credit amount
                interestRate: 1.04, // Initial interest rate
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      // Navy blue color for the background
    );
  }
}

class WidgetContainer extends StatelessWidget {
  final Widget child;

  WidgetContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400, // Increase the size of the container
        height: 400, // Increase the size of the container
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 3.0), // Black border
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: child);
  }
}

class CreditWidget extends StatefulWidget {
  final double creditAmount;
  final double interestRate;

  CreditWidget({required this.creditAmount, required this.interestRate});

  @override
  _CreditWidgetState createState() => _CreditWidgetState();
}

class ClickableContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final BorderRadius borderRadius;

  const ClickableContainer({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color = Colors.transparent,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(500.0), // Adjust the radius as needed
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}

class _CreditWidgetState extends State<CreditWidget> {
  double _currentAmount = 150000; // Initial credit amount
  double _currentRate = 1.04; // Initial interest rate
  double _greenangle = pi;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(200, 200),
            painter: CreditPainter(
              creditAmount: _currentAmount,
              interestRate: _currentRate,
              greenArcAngle: _greenangle,
            ),
          ),
          Positioned(
            left: 190, // Adjust the positioning
            bottom: 0,
            child: Container(
              width: 10,
              height: 195,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Credit Amount',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '\₹${_currentAmount.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '@ ${_currentRate.toStringAsFixed(2)}% monthly',
                style: TextStyle(fontSize: 10, color: Colors.green),
              ),
            ],
          ),
          CaptionContainer(
            caption: 'Stash is instant , money will be credited within seconds',
            margin: EdgeInsets.only(left: 20.0, top: 20.0),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }
}

class CreditPainter extends CustomPainter {
  final double creditAmount;
  final double interestRate;
  final double greenArcAngle; // Angle for the green portion

  CreditPainter(
      {required this.creditAmount,
      required this.interestRate,
      required this.greenArcAngle});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.transparent // Set the color to transparent
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = size.width / 2;
    double angle = (creditAmount / 10000) * (2 * pi);

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -pi / 2,
      angle,
      false,
      paint,
    );

    Paint borderPaint = Paint()
      ..color = Colors.black // Set the color to black for border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(
      Offset(radius, radius),
      radius - 2.5, // Adjust the radius for the border
      borderPaint,
    );

    // Draw the green arc
    Paint greenPaint = Paint()
      ..color = Colors.green // Set the color to green
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -pi / 2,
      greenArcAngle, // Use the specified angle for the green portion
      false,
      greenPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CaptionContainer extends StatelessWidget {
  final String caption;
  final EdgeInsets margin;
  final Alignment alignment;

  const CaptionContainer({
    Key? key,
    required this.caption,
    this.margin = const EdgeInsets.all(8.0),
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          caption,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
