import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/extension/date_time.dart';
import 'package:flutter_clean_architecture/core/extension/extension.dart';

import '../../../../../constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/custom_cached_network_image.dart';
import '../../../data/model/current_and_forecast_model.dart';

class WDailyReport extends StatelessWidget {
  const WDailyReport({super.key, required this.days});

  final List<Daily> days;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppUtils.kPaddingHor16,
            child: Text(context.tr('daily_report')),
          ),
          AppUtils.kGap8,
          SizedBox(
            height: 135,
            child: ListView.separated(
              padding: AppUtils.kPaddingHor16,
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (_, index) {
                final day = days[index];
                return InkWell(
                  onTap: () {},
                  borderRadius: AppUtils.kBorderRadius12,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: AppUtils.kBorderRadius12,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade700, Colors.blue.shade300],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Column(
                      children: [
                        CustomCachedNetworkImage(
                          imageUrl: Urls.image.replaceFirst(
                              '{id}', day.weather?.first.icon ?? ''),
                        ),
                        Text(
                          day.weather?.first.main ?? '',
                          style: context.textStyle.regularCallout,
                        ),
                        Text('${day.temp?.day ?? ''}\u00B0'),
                        AppUtils.kSpacer,
                        Text(
                          '${day.dt!.toDay(context.locale.languageCode)}',
                          style: context.textStyle.regularBody,
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => AppUtils.kGap8,
            ),
          )
        ],
      );
}
