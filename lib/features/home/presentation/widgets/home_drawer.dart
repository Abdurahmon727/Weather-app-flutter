import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/extension/extension.dart';
import 'package:flutter_clean_architecture/core/utils/utils.dart';
import 'package:flutter_clean_architecture/core/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'language_bottom_sheet.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String? appVersion;

  @override
  void initState() {
    _getAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: SafeArea(
          child: Padding(
            padding: AppUtils.kPaddingHor16Ver4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GestureDetector(
                //   onTap: () async {
                //     final isLight =
                //         context.theme.brightness == Brightness.light;
                //     final newMode = isLight ? ThemeMode.dark : ThemeMode.light;
                //     await localSource.setThemeMode(newMode);
                //     context.setThemeMode(
                //         newMode);
                //   },
                //   child: ListTile(
                //     title: Text(context.tr('theme')),
                //     trailing: Icon(Icons.sunny),
                //   ),
                // ),
                // AppUtils.kGap8,
                GestureDetector(
                  onTap: () {
                    context.pop();
                    customModalBottomSheet<void>(
                      context: context,
                      builder: (ctx, _) => const LanguageBottomSheet(),
                    );
                  },
                  child: ListTile(
                    title: Text(context.tr('app_language')),
                    trailing: Image(
                      image: AssetImage(
                        _currentLanguageIcon(context.locale.languageCode),
                      ),
                      width: 37,
                      height: 28,
                    ),
                  ),
                ),
                AppUtils.kSpacer,
                Align(child: Text(appVersion ?? ''))
              ],
            ),
          ),
        ),
      );

  String _currentLanguageIcon(String lang) {
    if (lang == 'en') return 'assets/images/ic_uk.png';
    if (lang == 'uz') return 'assets/images/ic_uz.png';
    return 'assets/images/ic_ru.png';
  }

  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;

    appVersion = '$version($buildNumber)';
    setState(() {});
  }
}
