import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:new_project/components/Button/button.dart';

class CustomStackWidget extends StatefulWidget {
  final List<String> ctas;
  final List<Widget> views;
  final bool cycle;

  const CustomStackWidget({
    super.key,
    required this.ctas,
    required this.views,
    required this.cycle,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomStackWidgetState createState() => _CustomStackWidgetState();
}

class _CustomStackWidgetState extends State<CustomStackWidget>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  Widget? previousView;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  bool isAnimating = false;

  void _nextView() {
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    setState(() {
      previousView = widget.views[currentIndex];
      if (widget.cycle) {
        currentIndex = (currentIndex + 1) % widget.views.length;
        _controller.forward(from: 0);
        _fadeController.forward(from: 0);
      } else {
        if (currentIndex < widget.views.length - 1) {
          currentIndex++;
          _controller.forward(from: 0);
          _fadeController.forward(from: 0);
        }
      }
    });
  }

  void _previousView() {
    setState(() {
      previousView = widget.views[currentIndex];
      currentIndex = (currentIndex - 1) % widget.views.length;
    });

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward(from: 0);
    _fadeController.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() {
          isAnimating = true;
        });
      }

      if (status == AnimationStatus.completed) {
        setState(() {
          isAnimating = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (previousView == null)
          Positioned.fill(child: widget.views[currentIndex]),
        if (previousView != null)
          Positioned.fill(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: previousView!,
            ),
          ),
        Positioned.fill(
          child: SlideTransition(
            position: _slideAnimation,
            child: widget.views[currentIndex],
          ),
        ),
        Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: CustomButton(
              onPressed: _nextView,
              text: widget.ctas[currentIndex],
            )),
        if (currentIndex != 0)
          Positioned(
            top: 50.0,
            right: 16.0,
            child: IconButton(
              onPressed: () {
                _previousView();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        if (isAnimating)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.white,
              size: 100,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
