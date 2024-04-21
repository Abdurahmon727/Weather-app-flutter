import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_clean_architecture/constants/constants.dart";
import "package:flutter_clean_architecture/core/domain/status.dart";
import "package:flutter_clean_architecture/core/extension/extension.dart";
import "package:flutter_clean_architecture/core/utils/utils.dart";
import "package:flutter_clean_architecture/core/widgets/custom_cached_network_image.dart";
import "package:flutter_clean_architecture/core/widgets/inputs/custom_text_field.dart";
import "package:flutter_clean_architecture/features/home/data/model/current_and_forecast_model.dart";
import "package:flutter_clean_architecture/router/app_routes.dart";
import "package:go_router/go_router.dart";

import "../bloc/home/home_bloc.dart";
import "../widgets/daily_report.dart";
import "../widgets/home_drawer.dart";
import "../widgets/hourly_report.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          centerTitle: false,
          title: CustomTextField(
            readOnly: true,
            onTap: () => context.pushNamed(Routes.cities),
            contentPadding: AppUtils.kPaddingHor16,
            onChanged: (val) {},
            controller: TextEditingController(),
            focusNode: FocusNode(),
            hintText: context.tr('city'),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(12),
            child: AppUtils.kGap,
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.sunny),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(GetForecast());
            await Future.delayed(Duration(seconds: 1));
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => state.status.switchStatus(
              onPure: () => context.read<HomeBloc>().add(Init()),
              onSuccess: () => _successContent(state.forecastModel!),
              onLoading: () => Center(child: CircularProgressIndicator()),
              onFail: () => Center(child: Text('${state.message}')),
            ),
          ),
        ),
      );

  Widget _successContent(CurrentAndForecastModel model) {
    return CustomScrollView(
      slivers: [
        SliverList.list(
          children: [
            Padding(
              padding: AppUtils.kPaddingHor16,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.current?.temp ?? ''}' + '\u00B0',
                          style: context.textStyle.bodyTitle1,
                        ),
                        Text(
                          '${model.current?.weather?.first.main ?? ''}',
                          style: context.textStyle.bodyTitle2,
                        ),
                        AppUtils.kGap8,
                        Text(
                          (model.timezone ?? '')
                              .split('/')
                              .last
                              .replaceAll('_', ' '),
                          style: context.textStyle.bodyHeadline,
                        ),
                        Text(
                          context.tr('feels_like_%d').replaceFirst(
                              '%d', '${model.current?.feelsLike}\u00B0'),
                          style: context.textStyle.bodyCallout,
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCachedNetworkImage(
                        imageUrl: Urls.image.replaceFirst(
                            '{id}', model.current?.weather?.first.icon ?? ''),
                      ),
                      Text(
                        '${model.current?.weather?.first.description ?? ''}',
                        style: context.textStyle.bodyHeadline,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppUtils.kGap16,
            WHourlyReport(hours: model.hourly!),
            AppUtils.kGap16,
            WDailyReport(days: model.daily!),
          ],
        ),
      ],
    );
  }
}
