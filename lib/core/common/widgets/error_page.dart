import 'package:flutter/material.dart';
import 'package:todo/core/common/widgets/custom_button.dart';
import 'package:todo/core/theme/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.errorMessage, this.onPressed});

  final String? errorMessage;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Text(
              errorMessage ?? appLocalizations.unknown_page_error,
              textAlign: TextAlign.center,
              style: Styles.textStyle19Bold.copyWith(
                color: const Color(0xffbababa),
              ),
            ),
            onPressed != null
                ? CustomButton(
                    title: appLocalizations.try_again,
                    onPressed: onPressed,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
