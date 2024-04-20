import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/utils/utils.dart';
import 'package:flutter_clean_architecture/features/home/data/model/city_model.dart';

class WCity extends StatelessWidget {
  const WCity({super.key, required this.model, required this.onTap});

  final CityModel model;
  final void Function(CityModel) onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: AppUtils.kBorderRadius12,
        onTap: () => onTap(model),
        child: Container(
          decoration: BoxDecoration(borderRadius: AppUtils.kBorderRadius12),
          padding: AppUtils.kPaddingAll12,
          child: Row(
            children: [
              Text(model.name ?? ''),
              AppUtils.kSpacer,
              Text(model.country ?? '')
            ],
          ),
        ),
      );
}
