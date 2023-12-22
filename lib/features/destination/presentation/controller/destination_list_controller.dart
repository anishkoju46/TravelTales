import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';

final destinationListProvider =
    NotifierProvider<DestinationListController, List<DestinationModel>>(
        DestinationListController.new);

class DestinationListController extends Notifier<List<DestinationModel>> {
  @override
  build() {
    throw UnimplementedError();
  }
}
