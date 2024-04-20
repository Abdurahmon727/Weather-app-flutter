import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: CustomTextField(
              autofocus: true,
              contentPadding: AppUtils.kPaddingHor16,
              onChanged: (val) {},
              controller: TextEditingController(),
              focusNode: FocusNode(),
              hintText: 'city',
            ),
          ),
          SliverList.list(children: []),
        ],
      ),
    );
  }
}
