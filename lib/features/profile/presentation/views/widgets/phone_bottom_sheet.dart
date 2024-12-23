import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/widgets/custom_snack_bar.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneBottomSheet {
  static void show(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                ListTile(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: "+201005677471"));
                    CustomSnackBar.show(
                      context: context,
                      message: "Phone Number Copied",
                      isDone: true,
                    );
                    context.pop();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: SvgPicture.asset(AppIcons.coreCommonAssetsIconsCopy),
                  title: Text(
                    "Copy",
                    style: Styles.textStyle16Bold,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    final Uri launchUri = Uri(
                      scheme: 'tel',
                      path: "+201005677471",
                    );

                    if (await canLaunchUrl(launchUri)) {
                      await launchUrl(launchUri);
                    } else {
                      throw 'Could not launch +201005677471';
                    }
                  },
                  splashColor: AppColors.splashColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: SvgPicture.asset(AppIcons.coreCommonAssetsIconsCall),
                  title: Text(
                    "Call",
                    style: Styles.textStyle16Bold,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    final cleanNumber =
                        "+201005677471".replaceAll(RegExp(r'[^\d+]'), '');

                    // Create the WhatsApp URL
                    final whatsappUrl =
                        Uri.parse('whatsapp://send?phone=$cleanNumber');

                    try {
                      if (await canLaunchUrl(whatsappUrl)) {
                        await launchUrl(whatsappUrl);
                      } else {
                        // WhatsApp not installed, try web URL
                        final webWhatsapp =
                            Uri.parse('https://wa.me/$cleanNumber');
                        if (await canLaunchUrl(webWhatsapp)) {
                          await launchUrl(webWhatsapp,
                              mode: LaunchMode.externalApplication);
                        } else {
                          throw 'Could not launch WhatsApp';
                        }
                      }
                    } catch (e) {
                      throw 'Error launching WhatsApp: $e';
                    }
                  },
                  splashColor: AppColors.splashColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading:
                      SvgPicture.asset(AppIcons.coreCommonAssetsIconsWhatsapp),
                  title: Text(
                    "Whatsapp",
                    style: Styles.textStyle16Bold,
                  ),
                ),
                SizedBox(height: 10)
              ],
            ),
          );
        },
      );
}
