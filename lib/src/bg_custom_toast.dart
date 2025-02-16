import 'package:flutter/material.dart';

/// Enum to define the toast position
enum ToastPosition { top, center, bottom }

/// Enum to define different toast animations
enum ToastAnimation { slide, dynamicIsland, fade, bounce, flip, rotate }

/// BGCustomToast: A customizable toast widget
///
/// This widget provides dynamic toast notifications with multiple animation options.
class BGCustomToast {
  static void show({
    required BuildContext context,
    required String message,
    ToastPosition position = ToastPosition.top,
    ToastAnimation animation = ToastAnimation.slide,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    double borderRadius = 16.0,
    double padding = 16.0,
    double margin = 20.0,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        position: position,
        animation: animation,
        backgroundColor: backgroundColor,
        textColor: textColor,
        borderRadius: borderRadius,
        padding: padding,
        margin: margin,
      ),
    );

    overlay.insert(overlayEntry);

    // Remove toast after the specified duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}

/// Internal Toast Widget class
class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastPosition position;
  final ToastAnimation animation;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double padding;
  final double margin;

  const _ToastWidget({
    Key? key,
    required this.message,
    required this.position,
    required this.animation,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.padding,
    required this.margin,
  }) : super(key: key);

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset>? _slideAnimation;
  late Animation<double>? _scaleAnimation;
  late Animation<double>? _opacityAnimation;
  late Animation<double>? _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final curvedAnimation =
    CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    switch (widget.animation) {
      case ToastAnimation.slide:
        _slideAnimation = Tween<Offset>(
          begin: Offset(0, widget.position == ToastPosition.top ? -1.0 : 1.0),
          end: Offset.zero,
        ).animate(curvedAnimation);
        break;

      case ToastAnimation.dynamicIsland:
        _scaleAnimation =
            Tween<double>(begin: 0.1, end: 1.0).animate(curvedAnimation);
        break;

      case ToastAnimation.fade:
        _opacityAnimation =
            Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.easeIn,
            ));
        break;

      case ToastAnimation.bounce:
        _scaleAnimation =
            Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.bounceOut,
            ));
        break;

      case ToastAnimation.flip:
        _rotationAnimation =
            Tween<double>(begin: -0.5, end: 0).animate(curvedAnimation);
        break;

      case ToastAnimation.rotate:
        _rotationAnimation =
            Tween<double>(begin: -0.2, end: 0).animate(curvedAnimation);
        break;
    }

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Widget toastContent = Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(widget.padding),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Text(
          widget.message,
          style: TextStyle(color: widget.textColor, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );

    Widget animatedToast;

    switch (widget.animation) {
      case ToastAnimation.slide:
        animatedToast =
            SlideTransition(position: _slideAnimation!, child: toastContent);
        break;

      case ToastAnimation.dynamicIsland:
        animatedToast =
            ScaleTransition(scale: _scaleAnimation!, child: toastContent);
        break;

      case ToastAnimation.fade:
        animatedToast =
            FadeTransition(opacity: _opacityAnimation!, child: toastContent);
        break;

      case ToastAnimation.bounce:
        animatedToast =
            ScaleTransition(scale: _scaleAnimation!, child: toastContent);
        break;

      case ToastAnimation.flip:
        animatedToast =
            RotationTransition(turns: _rotationAnimation!, child: toastContent);
        break;

      case ToastAnimation.rotate:
        animatedToast =
            RotationTransition(turns: _rotationAnimation!, child: toastContent);
        break;
    }

    return Positioned(
      top: widget.position == ToastPosition.top
          ? 50
          : widget.position == ToastPosition.center
          ? MediaQuery.of(context).size.height / 2 - 25
          : null,
      bottom: widget.position == ToastPosition.bottom ? 50 : null,
      left: widget.margin,
      right: widget.margin,
      child: animatedToast,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
