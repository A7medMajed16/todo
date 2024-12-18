import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/core/common/colors/app_colors.dart';
import 'package:todo/core/common/size/screen_dimensions.dart';
import 'package:todo/core/common/widgets/custom_text_field.dart';
import 'package:todo/core/theme/app_icons.dart';
import 'package:todo/core/theme/styles.dart';

class CustomPhoneNumberTextField extends StatefulWidget {
  const CustomPhoneNumberTextField(
      {super.key,
      required this.controller,
      this.validator,
      required this.countryPhoneCodeUpdateFunction});
  final TextEditingController controller;
  final Function(String?)? countryPhoneCodeUpdateFunction;
  final String? Function(String?)? validator;
  @override
  State<CustomPhoneNumberTextField> createState() =>
      _CustomPhoneNumberTextFieldState();
}

class _CustomPhoneNumberTextFieldState
    extends State<CustomPhoneNumberTextField> {
  String? countryCode;
  String? countryEmoji = "🇪🇬";
  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return CustomTextField(
      textEditingController: widget.controller,
      hintText: localization.mobil_number_hint,
      title: localization.mobil_number,
      keyboardType: TextInputType.phone,
      validator: widget.validator,
      tailWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => showCountryPicker(
                context: context,
                useSafeArea: true,
                exclude: <String>['IL'],
                favorite: <String>["eg"],
                showPhoneCode: true,
                moveAlongWithKeyboard: true,
                countryListTheme: CountryListThemeData(
                  bottomSheetHeight: ScreenDimensions.height / 1.35,
                  borderRadius: BorderRadius.circular(8),
                  searchTextStyle: Styles.textStyle16Bold,
                  textStyle: Styles.textStyle14Regular,
                  inputDecoration: InputDecoration(
                    hintText: localization.search,
                    hintStyle: Styles.textStyle14Regular
                        .copyWith(color: AppColors.hintTextColor),
                    fillColor: AppColors.backgroundColor,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFFB8B8B8),
                        width: 1,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        color: AppColors.primerColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                onSelect: (Country value) {
                  setState(() {
                    countryCode = value.phoneCode;
                    countryEmoji = value.flagEmoji;
                  });
                  widget.countryPhoneCodeUpdateFunction!("+$countryCode");
                },
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    countryEmoji ?? "+880",
                    style: Styles.textStyle19Bold,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "+${countryCode ?? "20"}",
                    style: Styles.textStyle14Bold
                        .copyWith(color: Color(0xff7F7F7F)),
                  ),
                  SvgPicture.asset(
                    height: 20,
                    fit: BoxFit.scaleDown,
                    AppIcons.coreCommonAssetsIconsDownArrow,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
