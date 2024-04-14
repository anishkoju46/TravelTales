import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/emergency_numbers/domain/emergency_number_model.dart';
import 'package:traveltales/features/emergency_numbers/presentation/controller/emergency_number_async_list.dart';
import 'package:traveltales/features/emergency_numbers/presentation/controller/emergency_number_form.dart';

final hotlineListProvider = AsyncNotifierProvider.autoDispose<
    HotlineNumberAsyncController,
    List<HotlineNumbersModel>>(HotlineNumberAsyncController.new);

final hotlineFormProvider = AutoDisposeNotifierProviderFamily<
    HotlineNumberController,
    HotlineNumbersModel,
    HotlineNumbersModel?>(HotlineNumberController.new);
