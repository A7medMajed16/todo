import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/theme/styles.dart';

void showCustomPopOver(BuildContext context) => showPopover(
      context: context,
      radius: 12,
      barrierColor: Colors.transparent,
      arrowDxOffset: 180,
      arrowDyOffset: -80,
      contentDxOffset: -20,
      backgroundColor: Colors.white,
      width: 82,
      arrowWidth: 20,
      arrowHeight: 10,
      shadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.19),
          blurRadius: 16,
          spreadRadius: 0,
          offset: Offset(1, 4),
        ),
      ],
      bodyBuilder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(4),
            splashColor: Colors.transparent,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Text(
                    AppLocalizations.of(context)!.popup_edit,
                    style: Styles.textStyle12Medium,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Divider(color: AppColors.hintTextColor.withValues(alpha: 0.4)),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(4),
            splashColor: Colors.transparent,
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: Text(
                    AppLocalizations.of(context)!.popup_delete,
                    style: Styles.textStyle12Medium
                        .copyWith(color: AppColors.errorColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
