import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/widgets/qr_scanner_bottom_sheet.dart';
import 'package:todo/core/helper/qrcode_helper/qrcode_helper.dart';
import 'package:todo/core/routes/app_router.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/features/home/data/models/task_model.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 14,
        children: [
          AnimatedOpacity(
            opacity: isExpanded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AnimatedSlide(
              offset: isExpanded ? Offset.zero : const Offset(0, 1),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  heroTag: 'qr',
                  onPressed: () {
                    QRScannerBottomSheet.show(
                      context,
                      (String qrCode) {
                        if (qrCode.isNotEmpty) {
                          context.push(AppRouter.kAddNewTask,
                              extra: TaskModel.fromJson(jsonDecode(
                                  QrCodeHelper.convertQrToJson(qrCode))));
                        }
                      },
                    );
                  },
                  backgroundColor: const Color(0xffEBE5FF),
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: SvgPicture.asset(
                    AppIcons.coreCommonAssetsIconsQr,
                    height: 24,
                  ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isExpanded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AnimatedSlide(
              offset: isExpanded ? Offset.zero : const Offset(0, 0.5),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  heroTag: 'add_new_task',
                  onPressed: () => context.push(AppRouter.kAddNewTask),
                  backgroundColor: const Color(0xffEBE5FF),
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: SvgPicture.asset(
                    AppIcons.coreCommonAssetsIconsEdit,
                    height: 24,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 64,
            height: 64,
            child: FloatingActionButton(
              heroTag: 'add',
              onPressed: _toggleExpanded,
              backgroundColor: AppColors.buttonBackgroundColor,
              shape: const CircleBorder(),
              child: RotationTransition(
                turns:
                    Tween(begin: 0.0, end: 0.125).animate(_animationController),
                child: Icon(
                  Icons.add_rounded,
                  color: AppColors.backgroundColor,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
