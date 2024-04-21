import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/domain/status.dart';
import 'package:flutter_clean_architecture/core/extension/extension.dart';
import 'package:flutter_clean_architecture/features/home/data/model/city_model.dart';
import 'package:flutter_clean_architecture/features/home/presentation/pages/widgets/w_city.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';
import '../bloc/cities/cities_bloc.dart';
import '../bloc/home/home_bloc.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextField(
          autofocus: true,
          contentPadding: AppUtils.kPaddingHor16,
          onChanged: (val) {
            if (val.isNotEmpty)
              context.read<CitiesBloc>().add(CitiesEventSearch(val));
          },
          controller: TextEditingController(),
          hintText: context.tr('city'),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(12),
          child: SizedBox.shrink(),
        ),
      ),
      body: BlocBuilder<CitiesBloc, CitiesState>(
        builder: (context, state) => state.status.switchStatus(
          onPure: () {},
          onLoading: () => Center(child: CircularProgressIndicator()),
          onSuccess: () => _successContent(state.cities!, context),
          onFail: () => Center(child: Text(state.message)),
        ),
      ),
    );
  }

  Widget _successContent(List<CityModel> cities, BuildContext context) =>
      ListView.separated(
        padding: AppUtils.kPaddingHor16Ver4,
        itemBuilder: (_, index) => WCity(
          model: cities[index],
          onTap: (city) {
            context.read<HomeBloc>().add(SetCity(city));
            context.pop();
          },
        ),
        separatorBuilder: (_, __) => AppUtils.kGap8,
        itemCount: cities.length,
      );
}
