import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/auth/data/repository/auth_repository.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/customImageViewer.dart';

class PhotoScreen extends ConsumerWidget {
  PhotoScreen({super.key});

  File? image;
  final _picker = ImagePicker();
  bool showspinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
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
    var uri = Uri.parse('${baseUrl}users/uploadGallery');
    // var uri = Uri.parse('http://localhost:8000/users/uploadPicture');

    var request = http.MultipartRequest('POST', uri);

    request.headers['x-access-token'] = token;

    request.fields['image'] = 'gallery';
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
        return decodedResponse['relativePaths'][0].toString();
      } else {
        print('image upload failed');
        return null;
      }
    } catch (e, s) {
      print("${e} ${s}");
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String baseUrl = "http://10.0.2.2:8000/";
    final user = ref.watch(authNotifierProvider);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gallery",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                IconButton(
                    onPressed: () async {
                      await getImage();

                      if (image != null) {
                        customShowDialog(context, ref);
                      }
                    },
                    icon: Icon(
                      Icons.add_photo_alternate,
                      size: 30,
                    ))
              ],
            ),
          ),
        ),
        Expanded(
          child: MyGridView(user: user, baseUrl: baseUrl),
        ),
      ],
    );
  }

  Future<dynamic> customShowDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Confirm Image',
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              border: Border.all(),
              image: DecorationImage(
                image: FileImage(image!), // Use FileImage for File
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Discard"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Upload image

                    var imageValue = await uploadImage(
                      token: ref.watch(authNotifierProvider)!.token.toString(),
                    );
                    // print(imageValue);
                    if (imageValue != null) {
                      final currentuser = ref.watch(authNotifierProvider);

                      List<String> newGallery =
                          List.from(currentuser!.gallery ?? [])
                            ..add(imageValue);

                      // Update the user's gallery using copyWiths
                      // print(newGallery);
                      ref
                          .read(authNotifierProvider.notifier)
                          .update(currentuser.copyWith(gallery: newGallery));
                    }
                    // print(imageValue);
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Confirm'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MyGridView extends ConsumerWidget {
  const MyGridView({
    super.key,
    required this.user,
    required this.baseUrl,
  });

  final UserModel? user;
  final String baseUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: user?.gallery?.length ?? 0,
      itemBuilder: (context, index) {
        if (user?.gallery != null && index < user!.gallery!.length) {
          return Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black26)),
            child: MyNetworkImage(
              imageUrl: ref
                  .read(authNotifierProvider.notifier)
                  .getGalleryImageUrls(index),
              imageIndex: index,
            ),
          );
        } else {
          return SizedBox(); // Return an empty widget or handle it differently
        }
      },
    );
  }
}

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage({super.key, required this.imageUrl, this.imageIndex});

  final String imageUrl;
  final int? imageIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CustomImageViewer(
              url: imageUrl,
              index: imageIndex,
              // ref
              //     .read(authNotifierProvider.notifier)
              //     .getGalleryImageUrls(index)
            ),
          ),
        );
      },
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        // placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }
}
