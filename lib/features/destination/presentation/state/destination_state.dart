import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_async_list_controller.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_form_controller.dart';

final destinationFormProvider = AutoDisposeNotifierProviderFamily<
    DestinationFormController,
    DestinationModel,
    DestinationModel?>(DestinationFormController.new);

final destinationListProvider = AsyncNotifierProvider.autoDispose<
    DestinationController, List<DestinationModel>>(DestinationController.new);
