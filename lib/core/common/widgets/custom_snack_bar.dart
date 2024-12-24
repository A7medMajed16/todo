import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/app_animations.dart';
import 'package:todo/core/theme/styles.dart';

class CustomSnackBar extends StatefulWidget {
  final String message;
  final bool isError;
  final bool isDone;

  const CustomSnackBar({
    super.key,
    required this.message,
    this.isError = false,
    this.isDone = false,
  });

  @override
  CustomSnackBarState createState() => CustomSnackBarState();

  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
    bool isDone = false,
  }) {
    final GlobalKey<CustomSnackBarState> snackBarKey = GlobalKey();

    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (context) => CustomSnackBar(
        key: snackBarKey,
        message: message,
        isError: isError,
        isDone: isDone,
      ),
    );

    Overlay.of(context).insert(entry);

    // Delay the disappearance and trigger reverse animation
    Future.delayed(const Duration(seconds: 4), () {
      snackBarKey.currentState?.reverseAnimation(() {
        entry?.remove();
      });
    });
  }
}

class CustomSnackBarState extends State<CustomSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );
    _triggerVibration();

    _controller.forward();
  }

  void _triggerVibration() async {
    await HapticFeedback.vibrate();
  }

  void reverseAnimation(VoidCallback onComplete) {
    _controller.reverse().then((_) => onComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            child: SlideTransition(
              position: _offsetAnimation,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.isError
                        ? AppColors.errorColor
                        : widget.isDone
                            ? AppColors.doneColor
                            : AppColors.primerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isError)
                        LottieBuilder.asset(
                          AppAnimations.coreCommonAssetsAnimationsError,
                          width: 30,
                          height: 30,
                          repeat: false,
                        ),
                      if (widget.isDone)
                        LottieBuilder.asset(
                          AppAnimations.coreCommonAssetsAnimationsDone,
                          width: 25,
                          height: 25,
                          repeat: false,
                        ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          widget.message,
                          maxLines: 3,
                          style: Styles.textStyle14Regular.copyWith(
                            color: AppColors.filledButtonTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
