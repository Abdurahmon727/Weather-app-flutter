import 'package:flutter/material.dart';

import '../../../../../../core/extension/extension.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../router/app_routes.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        minimum: AppUtils.kPaddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.tr('choose_language'),
              style: context.textTheme.displaySmall,
            ),
            AppUtils.kGap16,
            const LanguageItem(
              assets: 'assets/images/ic_uk.png',
              locale: Locale('en', 'US'),
              title: 'English',
            ),
            AppUtils.kGap8,
            const LanguageItem(
              assets: 'assets/images/ic_ru.png',
              locale: Locale('ru', 'RU'),
              title: 'Русский',
            ),
            AppUtils.kGap8,
            const LanguageItem(
              assets: 'assets/images/ic_uz.png',
              locale: Locale('uz', 'UZ'),
              title: 'O’zbekcha',
            ),
          ],
        ),
      );
}

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    required this.assets,
    required this.locale,
    required this.title,
  });

  final String assets;
  final Locale locale;
  final String title;

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
        leading: Image(
          image: AssetImage(assets),
          width: 37,
          height: 28,
        ),
        title: Text(title),
        onTap: () {
          // ignore: discarded_futures
          localSource.setLocale(locale.languageCode);
          context.setLocale(locale);
          Navigator.pop(context);
        },
        trailing: Radio(
          value: locale.languageCode,
          groupValue: context.locale.languageCode,
          onChanged: (value) {
            if (value == null) return;
            // ignore: discarded_futures
            localSource.setLocale(locale.languageCode);
            context.setLocale(locale);
            Navigator.pop(context);
          },
        ),
      );
}
