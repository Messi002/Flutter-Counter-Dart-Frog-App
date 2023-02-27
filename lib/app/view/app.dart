import 'package:counter_repository/counter_repository.dart';
import 'package:counterdartfrog/counter/view/counter_page.dart';
import 'package:counterdartfrog/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final CounterRepository _counterRepository;

  @override
  void initState() {
    super.initState();
    _counterRepository = CounterRepository();
  }

  @override
  void dispose() {
    _counterRepository.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(value: _counterRepository, child: const AppView(),);
  }
}


class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CounterPage()
    );
  }
}