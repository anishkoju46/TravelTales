import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';

class Loader extends ConsumerStatefulWidget {
  const Loader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoaderState();
}

class _LoaderState extends ConsumerState<Loader> {
  @override
  void initState() {
    super.initState();
    ref.read(authNotifierProvider.notifier).loader(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.hiking), Text("TravelTales")],
        ),
      ),
    );
  }
}
