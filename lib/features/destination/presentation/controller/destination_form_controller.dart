import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';

final destinationFormProvider = AutoDisposeNotifierProviderFamily<
    DestinationFormController,
    DestinationModel,
    DestinationModel?>(DestinationFormController.new);

class DestinationFormController
    extends AutoDisposeFamilyNotifier<DestinationModel, DestinationModel?> {
  @override
  DestinationModel build(DestinationModel? arg) {
    return arg ?? DestinationModel.empty();
  }
}
