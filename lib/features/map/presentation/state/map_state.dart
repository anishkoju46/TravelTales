import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map/map.dart';
import 'package:traveltales/features/map/domain/map_model.dart';
import 'package:traveltales/features/map/presentation/controller/map_controller.dart';

final mapProvider = AutoDisposeNotifierProviderFamily<MapStateContoller,
    MapState, MapController>(MapStateContoller.new);
