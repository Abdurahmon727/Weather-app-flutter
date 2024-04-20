import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_clean_architecture/core/domain/status.dart";

import "../bloc/home_bloc.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Weather app"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.sunny),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => state.status.switchStatus(
            onPure: () => context
                .read<HomeBloc>()
                .add(HomeEventGetForecastCurrentPosition()),
            onSuccess: () => _successContent(),
            onLoading: () => Center(child: CircularProgressIndicator()),
            onFail: () => Text('${state.message}'),
          ),
        ),
      );

  Widget _successContent() {
    return Text('success');
  }
}
