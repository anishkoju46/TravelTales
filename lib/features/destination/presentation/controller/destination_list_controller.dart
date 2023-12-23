import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';

final destinationListProvider =
    NotifierProvider<DestinationListController, List<DestinationModel>>(
        DestinationListController.new);

class DestinationListController extends Notifier<List<DestinationModel>> {
  final storage = GetStorage();

  @override
  List<DestinationModel> build() => loadDestination();

  final destinationKey = "destinationKey";

  List<DestinationModel> loadDestination() {
    final destinations = storage.read(destinationKey);
    if (destinations != null) {
      return destinationModelFromJson(destinations);
    }
    return [];
  }

  storeDestinations() {
    storage.write(destinationKey, destinationModelToJson(state));
  }

  addDestination(DestinationModel destination) {
    state = [...state..add(destination)];
    storeDestinations();
  }

  updateDestination(int index, {required DestinationModel destination}) {
    state = [...state..[index] = destination];
    storeDestinations();
  }

  removeDestination(int index) {
    state = [...state..removeAt(index)];
    storeDestinations();
  }

  handelSubmit(DestinationModel destination) {
    final index = state.indexWhere((element) => element.id == destination.id);
    if (index == -1) {
      addDestination(destination);
    } else {
      updateDestination(index, destination: destination);
    }
  }
}
