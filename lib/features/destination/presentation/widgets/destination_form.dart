import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/category/presentation/controller/category_controller.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_form_controller.dart';

({String name}) record = (name: "sdf");

class DestinationForm extends ConsumerWidget {
  const DestinationForm({super.key, this.destination});
  final DestinationModel? destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destinationFormController =
        ref.read(destinationFormProvider(destination).notifier);
    final destinationFormState =
        ref.watch(destinationFormProvider(destination));
    final categories = ref.read(CategoryNotifierProvider.notifier).categories;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          "Add Destination",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Form(
              key: destinationFormController.formkey,
              child: Column(
                children: [
                  customTextFormField(
                    labelText: "Destination Name",
                    onChanged: (value) {},
                  ),
                  customTextFormField(
                    labelText: "ImageUrl",
                    onChanged: (value) {},
                  ),
                  customTextFormField(
                    labelText: "Region",
                    onChanged: (value) {},
                  ),
                  customTextFormField(
                    labelText: "Duration",
                    onChanged: (value) {},
                  ),
                  customTextFormField(
                    labelText: "Max Height",
                    onChanged: (value) {},
                  ),
                  customTextFormField(
                    labelText: "Best Season",
                    onChanged: (value) {},
                  ),
                  customTextFormField(
                    labelText: "Itinerary",
                    onChanged: (value) {},
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(23)),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Category: "),
                        DropdownButton(
                          value: categories[1],
                          items: categories
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text("SAVE"))
        ],
      ),
    ));
  }

  Padding customTextFormField(
      {TextEditingController? textEditingController,
      IconData? iconData,
      required String labelText,
      required Function(String) onChanged,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: TextFormField(
        onChanged: (value) {
          onChanged(value);
        },
        controller: textEditingController,
        decoration: InputDecoration(
          suffixIcon: Icon(iconData),
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
