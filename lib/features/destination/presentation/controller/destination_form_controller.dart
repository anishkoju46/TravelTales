import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traveltales/features/auth/data/repository/auth_repository.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/category/domain/category_model_new.dart';
import 'package:traveltales/features/category/presentation/controller/category_async_list_controller.dart';
import 'package:traveltales/features/destination/data/respository/destination_repository.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/form_controller.dart';

import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';

class DestinationFormController extends FormController<DestinationModel> {
  @override
  DestinationModel build(DestinationModel? arg) {
    final category = ref.read(categoryListProvider.notifier).usableCategories;
    return arg ??
        DestinationModel(category: category.isEmpty ? null : category.first);
  }

  @override
  update({
    String? name,
    String? description,
    List<String>? itinerary,
    List<String>? imageUrl,
    String? region,
    String? duration,
    String? maxHeight,
    String? bestSeason,
    double? latitude,
    double? longitude,
    CategoryModel? category,
    List<String>? emergencyContact,
  }) {
    state = state.copyWith(
        name: name ?? state.name,
        description: description ?? state.description,
        itinerary: itinerary ?? state.itinerary,
        imageUrl: imageUrl ?? state.imageUrl,
        region: region ?? state.region,
        duration: duration ?? state.duration,
        maxHeight: maxHeight ?? state.maxHeight,
        bestSeason: bestSeason ?? state.bestSeason,
        coordinates: state.coordinates != null
            ? state.coordinates?.copyWith(coordinates: [
                longitude ?? state.coordinates!.coordinates!.first,
                latitude ?? state.coordinates!.coordinates!.last
              ])
            : Coordinates(coordinates: [longitude ?? 0.0, latitude ?? 0.0]),
        category: category ?? state.category,
        emergencyContact: emergencyContact ?? state.emergencyContact);
  }

  @override
  Future<String?> handleSubmit(BuildContext context,
      {bool isAdd = false}) async {
    if (isValidated) {
      // print(state.length);
      if (state != arg) {
        try {
          final repository = DestinationRepository(
              token: ref.watch(authNotifierProvider)?.token);
          if (isAdd) {
            final destination =
                await repository.addDestination(destination: state);
            ref
                .read(destinationListProvider.notifier)
                .handleSubmit(destination);
            CustomSnack.success(context, message: "Destination Added");
            state = DestinationModel();

            await Future.delayed(Duration(milliseconds: 10), () {
              resetForm();
              // print("Destinaation IDDD:: ${destination.id}");
              return destination.id;
            });
            return destination.id;
          } else {
            final destination =
                await repository.editDestination(destination: state);
            ref
                .read(destinationListProvider.notifier)
                .handleSubmit(destination);
            CustomSnack.success(context, message: "Destination Edited");
            //Refresh ko lagi use gareko method
            // ref
            //     .watch(destinationListProvider.notifier)
            //     .setDestination(destination.id!);
          }
        } catch (e, s) {
          CustomSnack.error(context, message: e.toString());
          print(e);
          print(s);
          return null;
        }
        //Navigator.pop(context);
      } else {
        CustomSnack.info(context, message: "No changes Made");
        return null;
      }
    }
    return null;
  }

  String getDestinationImageUrl(int index) {
    final baseUrl = DestinationRepository().baseUrl;
    return "${baseUrl}${state.imageUrl![index].replaceAll('\\', '/')}";
  }

  String getDestinationImageUrlForDeletion(int index) {
    return "${state.imageUrl![index]}";
  }

  @override
  updateState() {
    // TODO: implement updateState
    throw UnimplementedError();
  }

  List<File> images = [];

  File? image;
  final _picker = ImagePicker();

  Future getImage() async {
    var file = await getImageFile();
    if (file != null) {
      images.add(file);
      state = state.copyWith();
    } else {
      print("no image selected");
    }
  }

  Future<File?> getImageFile() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  void removeImage(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
      state = state.copyWith();
    }
  }

  Future<String?> uploadImage(
      {required String token, required String id, List<File>? files}) async {
    final baseUrl = AuthRepository().baseUrl;
    var uri = Uri.parse('${baseUrl}destinations/addDestinationImage/${id}');

    var request = http.MultipartRequest('POST', uri);

    request.headers['x-access-token'] = token;

    for (var file in files ?? images) {
      var stream = http.ByteStream(file.openRead());
      stream.cast();
      var length = await file.length();
      var multiport = http.MultipartFile('image', stream, length,
          contentType: MediaType.parse('image/jpg'));
      request.files.add(multiport);
    }
    //extracting extension of the uploaded image
    // String extension = image!.path.split('.').last;

    request.fields['image'] = 'image';

    var response = await request.send();
    try {
      if (response.statusCode == 200) {
        print('image uploaded');

        String responseBody = await response.stream.bytesToString();

        Map<String, dynamic> decodedResponse = json.decode(responseBody);
        // print(decodedResponse);
        images.clear();

        return decodedResponse['relativePaths'][0].toString();

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
}
