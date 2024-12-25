import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/features/profile/presentation/views/widgets/dev_profile/dev_phone_bottom_sheet.dart';
import 'package:todo/features/profile/presentation/views/widgets/dev_profile/dev_profile_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DevProfileViewBody extends StatelessWidget {
  const DevProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.5),
      child: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            SizedBox(height: 16),
            DevProfileWidget(
              title: 'NAME',
              content: "Ahmed Majed El-Sayed Farag",
            ),
            DevProfileWidget(
              title: 'PHONE',
              content: "+201005677471",
              icon: Icons.more_horiz_rounded,
              onTap: () => DevPhoneBottomSheet.show(context, null),
            ),
            DevProfileWidget(
              title: 'LEVEL',
              content: "Can you guess? 🤔",
            ),
            DevProfileWidget(
              title: 'YEARS OF EXPERIENCE',
              content: "Guess my level and experience! 🎯",
            ),
            DevProfileWidget(
              title: 'LOCATION',
              content: "Zagazig, Sharqia, Eypt",
              iconPath: AppIcons.coreCommonAssetsIconsLocation,
              onTap: () async {
                final Uri url = Uri.parse(
                    'https://maps.app.goo.gl/a3v95M5PSaeWnjSw8?g_st=com.google.maps.preview.copy');
                try {
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch maps');
                  }
                } catch (e) {
                  log('Error launching maps: $e');
                }
              },
            ),
            DevProfileWidget(
              title: 'GITHUB',
              content: "A7medMajed16",
              iconPath: AppIcons.coreCommonAssetsIconsGithub,
              onTap: () async {
                final Uri url = Uri.parse('https://github.com/A7medMajed16');
                try {
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch GitHub');
                  }
                } catch (e) {
                  log('Error launching GitHub: $e');
                }
              },
            ),
            DevProfileWidget(
              title: 'GMAIL',
              content: "ahmed.maged.1682@gmail.com",
              iconPath: AppIcons.coreCommonAssetsIconsGmail,
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'ahmed.maged.1682@gmail.com',
                );
                try {
                  if (!await launchUrl(emailLaunchUri)) {
                    throw Exception('Could not launch email');
                  }
                } catch (e) {
                  log('Error launching email: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
