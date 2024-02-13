import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/category/presentation/controller/category_async_list_controller.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';
import 'package:traveltales/utility/validator.dart';

class DestinationForm extends ConsumerWidget {
  const DestinationForm({super.key, this.destination});
  final DestinationModel? destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isAdd = destination == null;
    final destinationFormProviders = destinationFormProvider(destination);
    final destinationFormController =
        ref.read(destinationFormProviders.notifier);
    final destinationFormState = ref.watch(destinationFormProviders);
    // print(destinationFormState.toJson());
    final categories = ref.read(categoryListProvider.notifier).usableCategories;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  color: Theme.of(context).colorScheme.primary,
                  width: double.infinity,
                  child: Row(
                    children: [
                      ArrowBackWidget(),
                      Text(
                        isAdd ? "Add Destination" : "Update Destination",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      )
                    ],
                  )),
              Form(
                key: destinationFormController.formKey,
                child: Column(
                  children: [
                    customTextFormField(
                        initialValue: destinationFormState.name,
                        labelText: "Destination Name",
                        onChanged: (value) {
                          destinationFormController.update(name: value);
                        },
                        validator: destinationNameValidator),
                    customTextFormField(
                        initialValue:
                            (destinationFormState.imageUrl?.first), //TODO
                        labelText: "IMAGE URL HAI",
                        onChanged: (value) {
                          destinationFormController.update(imageUrl: [value]);
                        },
                        validator: imageValidator),
                    customTextFormField(
                        initialValue: destinationFormState.description,
                        labelText: "Description (in short)",
                        onChanged: (value) {
                          destinationFormController.update(description: value);
                        },
                        validator: descriptionValidate),
                    customTextFormField(
                        initialValue: destinationFormState
                            .coordinates?.coordinates!.first
                            .toString(),
                        labelText: "Longitude",
                        onChanged: (value) {
                          destinationFormController.update(
                              longitude:
                                  double.tryParse(value as String) ?? 0.0);
                        },
                        validator: longitudeValidate),
                    customTextFormField(
                        initialValue: destinationFormState
                            .coordinates?.coordinates!.last
                            .toString(),
                        labelText: "Latitude",
                        onChanged: (value) {
                          destinationFormController.update(
                              latitude:
                                  double.tryParse(value as String) ?? 0.0);
                        },
                        validator: latitudeValidate),
                    customTextFormField(
                        initialValue: destinationFormState.region,
                        labelText: "Region (example:Jumla)",
                        onChanged: (value) {
                          destinationFormController.update(region: value);
                        },
                        validator: regionValidator),
                    customTextFormField(
                        initialValue: destinationFormState.duration,
                        labelText: "Duration (In days)",
                        onChanged: (value) {
                          destinationFormController.update(duration: value);
                        },
                        validator: durationValidator),
                    customTextFormField(
                        initialValue: destinationFormState.maxHeight,
                        labelText: "Max Height (in Meters)",
                        onChanged: (value) {
                          destinationFormController.update(maxHeight: value);
                        },
                        validator: maxHeightValidator),
                    customTextFormField(
                        initialValue: destinationFormState.bestSeason,
                        labelText: "Best Season (example:Months)",
                        onChanged: (value) {
                          destinationFormController.update(bestSeason: value);
                        },
                        validator: bestSeasonValidator),
                    customTextFormField(
                        initialValue: destinationFormState.itinerary?.first,
                        labelText: "Itinerary (Day to day plans)",
                        onChanged: (value) {
                          destinationFormController.update(itinerary: [value]);
                        },
                        validator: itineraryValidator),
                    customTextFormField(
                        initialValue:
                            destinationFormState.emergencyContact?.first,
                        labelText: "Emergency Contacts",
                        onChanged: (value) {
                          destinationFormController
                              .update(emergencyContact: [value]);
                        },
                        validator: phoneNumberValidator),
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
                                    child: Text(e.name!),
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
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertBox(
                                confirmText: isAdd ? "Yes, Add" : "Yes, Update",
                                onPressed: () {
                                  Navigator.pop(
                                      context); //So that add button click garesi, alert box close in hos + handleSubmit()

                                  destinationFormController
                                      .handleSubmit(context, isAdd: isAdd);
                                  // if (destinationFormController
                                  //         .formKey.currentState
                                  //         ?.validate() ??
                                  //     false) {
                                  //   destinationFormController
                                  //       .handleSubmit(context, isAdd: isAdd);
                                  // }

                                  // destinationFormController
                                  //     .formKey.currentState!
                                  //     .reset();
                                },
                                title: "Are you sure?");
                          });
                    },

                    // onPressed: () {
                    //   destinationFormController.handleSubmit(context,
                    //       isAdd: isAdd);
                    // },
                    child: Text(isAdd ? "ADD" : "UPDATE")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding customTextFormField(
      {String? initialValue,
      IconData? iconData,
      required String labelText,
      required Function(dynamic) onChanged,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: TextFormField(
        validator: validator,
        maxLines: null,
        initialValue: initialValue,
        onChanged: (value) {
          onChanged(value);
        },
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
