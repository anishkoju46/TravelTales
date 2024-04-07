import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traveltales/features/auth/data/repository/auth_repository.dart';
import 'package:traveltales/features/category/presentation/controller/category_async_list_controller.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/validator.dart';

import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';

class DestinationForm extends ConsumerWidget {
  const DestinationForm({super.key, this.destination});
  final DestinationModel? destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Method for picking uploading Image

    File? image;
    final _picker = ImagePicker();
    bool showspinner = false;

    Future getImage() async {
      final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 100);
      if (pickedFile != null) {
        image = File(pickedFile.path);

        final pickedSize = await pickedFile.length();
        print("pickedFile: ${pickedSize} bytes");
        // print(pickedSize)

        // Uint8List apple;

        final size = await image!.length();
        print("Image: ${size} bytes");

        // setState(() {});
      } else {
        print("no image selected");
      }
    }

    Future<String?> uploadImage({required String token}) async {
      var stream = http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image!.length();
      final baseUrl = AuthRepository().baseUrl;
      var uri = Uri.parse('${baseUrl}/users/uploadPicture');
      // var uri = Uri.parse('http://localhost:8000/users/uploadPicture');

      var request = http.MultipartRequest('POST', uri);

      request.headers['x-access-token'] = token;

      //extracting extension of the uploaded image
      // String extension = image!.path.split('.').last;

      request.fields['image'] = 'image';
      var multiport = http.MultipartFile('image', stream, length,
          contentType: MediaType.parse('image/jpg'));
      request.files.add(multiport);
      var response = await request.send();
      try {
        if (response.statusCode == 200) {
          print('image uploaded');

          String responseBody = await response.stream.bytesToString();

          Map<String, dynamic> decodedResponse = json.decode(responseBody);
          // print(decodedResponse);
          return decodedResponse['filePath'].toString();

          // Map<String, dynamic> decodedResponse = json.decode(response as String);
          // print(decodedResponse);
          // return decodedResponse;
        } else {
          print('image upload failed');
          return null;
        }
      } catch (e, s) {
        print("${e} ${s}");
        return null;
      }
    }

    final bool isAdd = destination == null;
    final destinationFormProviders = destinationFormProvider(destination);
    final destinationFormController =
        ref.read(destinationFormProviders.notifier);
    final destinationFormState = ref.watch(destinationFormProviders);
    // print(destinationFormState.toJson());
    final categories = ref.read(categoryListProvider.notifier).usableCategories;
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
              // Container(
              //     color: Theme.of(context).colorScheme.primary,
              //     width: double.infinity,
              //     child: Row(
              //       children: [
              //         ArrowBackWidget(),
              //         Text(
              //           isAdd ? "Add Destination" : "Update Destination",
              //           style: TextStyle(
              //               color: Theme.of(context).colorScheme.onPrimary),
              //         )
              //       ],
              //     )),
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
