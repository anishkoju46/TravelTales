import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/favourite/presentation/controller/favourite_controller.dart';

class UserHomeController extends Notifier {
  @override
  build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  refresh() async {
    final refreshedUser = ref.refresh(userListProvider);
    final refreshedDestination = ref.refresh(destinationListProvider);
  }
}
