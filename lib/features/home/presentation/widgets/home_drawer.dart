import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/utils/utils.dart';
import 'package:flutter_clean_architecture/core/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:go_router/go_router.dart';

import 'language_bottom_sheet.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SafeArea(
          child: Padding(
            padding: AppUtils.kPaddingHor16Ver4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('salom'),
                IconButton(
                  onPressed: () {
                    context.pop();
                    customModalBottomSheet<void>(
                      context: context,
                      builder: (ctx, _) => const LanguageBottomSheet(),
                    );
                  },
                  icon: Icon(Icons.sunny),
                )
              ],
            ),
          ),
        ),
      );
}
