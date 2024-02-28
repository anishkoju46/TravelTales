import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/search/presentation/controller/search_async_list_controller.dart';

final searchListProvider = AsyncNotifierProvider.autoDispose<
    SearchingController, List<DestinationModel>>(SearchingController.new);
