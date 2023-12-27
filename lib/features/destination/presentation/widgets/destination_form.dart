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
    final categories =
        ref.read(CategoryNotifierProvider.notifier).usableCategories;
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: destinationFormController.formKey,
                child: Column(
                  children: [
                    customTextFormField(
                      labelText: "Destination Name",
                      onChanged: (value) {
                        destinationFormController.update(name: value);
                      },
                    ),
                    customTextFormField(
                      labelText: "IMAGE URL HAI",
                      onChanged: (value) {
                        destinationFormController.update(imageUrl: value);
                      },
                    ),
                    customTextFormField(
                      labelText: "Description (in short)",
                      onChanged: (value) {
                        destinationFormController.update(description: value);
                      },
                    ),
                    customTextFormField(
                      labelText: "Longitude",
                      onChanged: (value) {
                        destinationFormController.update(
                            longitude: double.tryParse(value as String) ?? 0.0);
                      },
                    ),
                    customTextFormField(
                      labelText: "Latitude",
                      onChanged: (value) {
                        destinationFormController.update(
                            latitude: double.tryParse(value as String) ?? 0.0);
                      },
                    ),
                    // customTextFormField(
                    //   labelText: "ImageUrl",
                    //   onChanged: (value) {},
                    // ),
                    customTextFormField(
                      labelText: "Region (example:Jumla)",
                      onChanged: (value) {
                        destinationFormController.update(region: value);
                      },
                    ),
                    customTextFormField(
                      labelText: "Duration (In days)",
                      onChanged: (value) {
                        destinationFormController.update(duration: value);
                      },
                    ),
                    customTextFormField(
                      labelText: "Max Height (in Meters)",
                      onChanged: (value) {
                        destinationFormController.update(maxHeight: value);
                      },
                    ),
                    customTextFormField(
                      labelText: "Best Season (example:Months)",
                      onChanged: (value) {
                        destinationFormController.update(bestSeason: value);
                      },
                    ),
                    customTextFormField(
                      labelText: "Itinerary (Day to day plans)",
                      onChanged: (value) {
                        destinationFormController.update(itinerary: value);
                      },
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
                            value: destinationFormState.category,
                            items: categories
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              destinationFormController.update(category: value);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                    onPressed: () {
                      destinationFormController.handleSubmit(context);
                    },
                    child: Text("ADD Destination")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding customTextFormField(
      {TextEditingController? textEditingController,
      IconData? iconData,
      required String labelText,
      required Function(dynamic) onChanged,
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
//USE STEPPER WIDGET IN FUTURE!
