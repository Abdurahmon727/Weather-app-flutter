import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/utils/utils.dart';
import 'package:flutter_clean_architecture/features/home/data/model/current_and_forecast_model.dart';

import '../../../../../constants/constants.dart';
import '../../../../../core/widgets/custom_cached_network_image.dart';

class WHourlyReport extends StatelessWidget {
  const WHourlyReport({super.key, required this.hours});

  final List<Hourly> hours;

  @override
  Widget build(BuildContext context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:AppUtils.kPaddingHor16,
            child: Text('Hourly report'),
          ),
          AppUtils.kGap8,
          SizedBox(
            height: 120,
            child: ListView.separated(
              padding: AppUtils.kPaddingHor16,
              scrollDirection: Axis.horizontal,
              itemCount: hours.length,
              itemBuilder: (_, index) =>
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: AppUtils.kBorderRadius12,
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Column(
                      children: [
                        CustomCachedNetworkImage(
                          imageUrl: Urls.image.replaceFirst(
                              '{id}', hours[index].weather?.first.icon ?? ''),
                        ),
                        Text(hours[index].weather?.first.main ?? ''),
                        Text('${hours[index].temp ?? ''}\u00B0'),

                      ],
                    ),
                  ),
              separatorBuilder: (_, __) => AppUtils.kGap8,
            ),
          )
        ],
      );
}
