import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';

final destinationProvider =
    NotifierProvider<DestinationController, List<DestinationModel>>(
        DestinationController.new);

class DestinationController extends Notifier<List<DestinationModel>> {
  final ScrollController listScrollController = ScrollController();
  @override
  List<DestinationModel> build() {
    return destinationModel;
  }

  late final List<DestinationModel> destinationModel = [];
}
