import 'package:flutter/material.dart';

import '../../../../../core/extension/extension.dart';
import '../../../../../core/theme/themes.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/buttons/bottom_navigation_button.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Устройства')),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate(
                child: ColoredBox(
                  color: context.colorScheme.background,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Текущее устройство'),
                        AppUtils.kGap12,
                        DeviceItem(isCurrentDevice: true),
                        AppUtils.kGap24,
                        Text('Другие сессии'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              sliver: SliverList.separated(
                itemBuilder: (_, index) => const DeviceItem(),
                separatorBuilder: (_, index) => AppUtils.kGap12,
                itemCount: 16,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationButton(
          child: CustomButton(
            onPressed: () {},
            label: const Text('Войти в другое устроство с QR'),
            leftIcon: const Icon(AppIcons.qrcode),
          ),
        ),
      );
}

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const SliverHeaderDelegate({
    required this.child,
    this.height = 166,
  });

  final Widget child;
  final double height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      child;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height ;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class DeviceItem extends StatelessWidget {
  const DeviceItem({
    super.key,
    this.isCurrentDevice = false,
  });

  final bool isCurrentDevice;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: const ShapeDecoration(
          color: Color(0xFF343434),
          shape: RoundedRectangleBorder(borderRadius: AppUtils.kBorderRadius4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.phone_android,
              color: context.colorScheme.primary,
            ),
            AppUtils.kGap8,
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IPhone 13',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppUtils.kGap4,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Добавлен:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF909090),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AppUtils.kGap4,
                      Text(
                        '4 июня 2022 | 12:25',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF909090),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!isCurrentDevice) AppUtils.kGap8,
            if (!isCurrentDevice)
              Icon(
                AppIcons.logout,
                color: context.color.whiteOpacity5,
              ),
          ],
        ),
      );
}