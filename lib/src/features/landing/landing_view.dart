import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:proceedix_technical_assignment/src/app_asset_images.dart';
import 'package:proceedix_technical_assignment/src/app_theme_colors.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/routing/route_names.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button_type.dart';
import 'package:proceedix_technical_assignment/src/widgets/spacing.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColors.secondary,
      body: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 100, bottom: 30, left: 20, right: 20),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssetImage.landingBackground),
              fit: BoxFit.fill,
            ),
            gradient: LinearGradient(
              begin: Alignment(0, 0),
              end: Alignment(1, 0.1),
              colors: [
                Colors.transparent,
                AppThemeColors.pink,
              ],
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssetImage.logo,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            Column(
              children: [
                Button(
                  label: AppTranslation.company,
                  type: ButtonType.secondary,
                  trailingChevron: true,
                  showIcon: true,
                  icon: FluentIcons.cloud_16_filled,
                  onPressed: () => context.pushNamed(RouteNames.subscribe),
                ),
                const Spacing(),
                Button(
                  label: AppTranslation.login,
                  showIcon: true,
                  icon: FluentIcons.person_arrow_left_16_filled,
                  onPressed: () => context.pushNamed(RouteNames.subscribe),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
