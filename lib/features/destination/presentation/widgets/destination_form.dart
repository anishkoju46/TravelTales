import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traveltales/features/auth/data/repository/auth_repository.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/category/presentation/controller/category_async_list_controller.dart';
import 'package:traveltales/features/destination/data/respository/destination_repository.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/validator.dart';

import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';

class DestinationForm extends ConsumerWidget {
  DestinationForm({super.key, this.destination});
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

    final imageList = destinationFormController.images;
    final image = destinationFormController.image;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            isAdd ? "Add Destination" : "Update Destination",
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.background),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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

                    // if (image != null)
                    //   Container(
                    //     color:
                    // Colors.red,
                    //     child: Image.file(
                    //       image!,
                    //       width: 80,
                    //       height: 40,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    Column(
                      children: [
                        //This Column is for ADD ONLY:
                        if (isAdd)
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: GestureDetector(
                                  onTap: () async {
                                    await destinationFormController.getImage();
                                  },
                                  child: imageList.isEmpty
                                      ? Container(
                                          width: double
                                              .infinity, // Match the width of the parent
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Upload an Image",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(Icons.add_photo_alternate)
                                              ]),
                                        )
                                      : Wrap(
                                          runSpacing: 8,
                                          spacing: 8,
                                          children: imageList
                                              .map(
                                                (e) => Stack(
                                                  children: [
                                                    Container(
                                                        width: 140,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black38)),
                                                        child: Image.file(
                                                          e,
                                                          fit: BoxFit.cover,
                                                        )),
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: Container(
                                                        // color: Colors.red,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            int index =
                                                                imageList
                                                                    .indexOf(e);
                                                            if (index != -1) {
                                                              ref
                                                                  .read(destinationFormProviders
                                                                      .notifier)
                                                                  .removeImage(
                                                                      index);
                                                            }
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                ),
                              ),
                              //To show an icon to add image even after an image is selected.
                              if (imageList.isNotEmpty)
                                IconButton(
                                  onPressed: () async {
                                    await destinationFormController.getImage();
                                  },
                                  icon: Icon(Icons.add_photo_alternate),
                                )
                            ],
                          ),
                        // This column is for  EDIT DESTINATION  ONLY
                        if (isAdd == false)
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: GestureDetector(
                                  onTap: () async {
                                    await destinationFormController.getImage();
                                    //upload ni garnu paryo

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertBox(
                                            confirmText: "Confirm",
                                            onPressed: () async {
                                              final String? id =
                                                  destinationFormState.id;
                                              // print(id);
                                              if (id != null) {
                                                var imageValue =
                                                    await destinationFormController
                                                        .uploadImage(
                                                            token: ref
                                                                .read(
                                                                    authNotifierProvider)!
                                                                .token
                                                                .toString(),
                                                            id: id);
                                                // print(imageValue);

                                                if (imageValue != null) {
                                                  List<String> newImages =
                                                      List.from(
                                                          destinationFormState
                                                                  .imageUrl ??
                                                              [])
                                                        ..add(imageValue);
                                                  print(newImages);

                                                  await destinationFormController
                                                      .update(
                                                          imageUrl: newImages);

                                                  CustomSnack.success(context,
                                                      message:
                                                          "Image Uploaded");
                                                }
                                              }
                                            },
                                            title: "Upload Image");
                                      },
                                    );
                                  },
                                  child: destinationFormState.imageUrl!.isEmpty
                                      ? Container(
                                          width: double
                                              .infinity, // Match the width of the parent
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Upload an Image",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(Icons.add_photo_alternate)
                                              ]),
                                        )
                                      : Wrap(
                                          runSpacing: 8,
                                          spacing: 8,
                                          children:
                                              destinationFormState.imageUrl!
                                                  .map(
                                                    (e) => Stack(
                                                      children: [
                                                        Consumer(builder:
                                                            (context, ref,
                                                                child) {
                                                          int index =
                                                              destinationFormState
                                                                  .imageUrl!
                                                                  .indexOf(e);
                                                          return Container(
                                                            width: 140,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black38)),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl: ref
                                                                  .read(destinationListProvider
                                                                      .notifier)
                                                                  .parseImage(
                                                                    path: destinationFormState
                                                                            .imageUrl![
                                                                        index],
                                                                  ),
                                                            ),
                                                          );
                                                        }),
                                                        //=========================DELETE BUTTON
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: Container(
                                                            // color: Colors.red,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertBox(
                                                                        confirmText:
                                                                            "Confirm",
                                                                        onPressed:
                                                                            () async {
                                                                          int index = destinationFormState
                                                                              .imageUrl!
                                                                              .indexOf(e);
                                                                          if (index !=
                                                                              -1) {
                                                                            //delete API CALL GARNE
                                                                            final String?
                                                                                id =
                                                                                destinationFormState.id;
                                                                            final path =
                                                                                destinationFormController.getDestinationImageUrlForDeletion(index);

                                                                            // var imageValue =
                                                                            await DestinationRepository(token: ref.read(authNotifierProvider)?.token).deleteDestinationImages(
                                                                                imageUrl: path,
                                                                                id: id!);

                                                                            List<String> updatedImages = List.from(destinationFormState.imageUrl ??
                                                                                [])
                                                                              ..removeAt(index);

                                                                            await destinationFormController.update(imageUrl: updatedImages);

                                                                            Navigator.pop(context);

                                                                            CustomSnack.info(context,
                                                                                message: "Image Deleted");
                                                                          }
                                                                        },
                                                                        title:
                                                                            "Delete Image");
                                                                  },
                                                                );
                                                              },
                                                              child: Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                ),
                              ),
                              //To show an icon to add image even after an image is selected.
                              if (destinationFormState.imageUrl!.isNotEmpty)
                                GestureDetector(
                                  onTap: () async {
                                    await destinationFormController.getImage();

                                    final String? id = destinationFormState.id;
                                    // print(id);
                                    if (id != null) {
                                      var imageValue =
                                          await destinationFormController
                                              .uploadImage(
                                                  token: ref
                                                      .read(
                                                          authNotifierProvider)!
                                                      .token
                                                      .toString(),
                                                  id: id);
                                      // print(imageValue);

                                      if (imageValue != null) {
                                        List<String> newImages = List.from(
                                            destinationFormState.imageUrl ?? [])
                                          ..add(imageValue);
                                        print(newImages);

                                        await destinationFormController.update(
                                            imageUrl: newImages);

                                        CustomSnack.success(context,
                                            message: "Image Uploaded");
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Upload Image",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                        Icon(Icons.add_photo_alternate),
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                      ],
                    ),

                    //==END OF UPLOAD IMAGE UI

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
                                onPressed: () async {
                                  final id = await destinationFormController
                                      .handleSubmit(context, isAdd: isAdd);
                                  // print("IDDDDDDDDDD::::::::: ${id}");

                                  if (id != null && isAdd) {
                                    print(
                                        "Add wala Button ko Upload API got Hit");
                                    destinationFormController.uploadImage(
                                        token: ref
                                            .watch(authNotifierProvider)!
                                            .token
                                            .toString(),
                                        id: id);
                                  }

                                  Navigator.pop(
                                      context); //So that add button click garesi, alert box close in hos + handleSubmit()
                                },
                                title: "Are you sure?");
                          });
                    },
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
