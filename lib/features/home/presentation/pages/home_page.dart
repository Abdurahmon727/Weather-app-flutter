import "package:flutter/material.dart";

import "package:flutter_clean_architecture/core/utils/utils.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Weather app"),
          actions: const <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.sunny),
            //   onPressed: () {
            //
            //     // context
            //   },
            // ),
          ],
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList.list(
              key: const ObjectKey("list"),
              children: const [

                AppUtils.kGap16,
              ],
            ),
          ],
        ),
      );
}
