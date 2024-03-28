import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/controller/profile_controller.dart';
import 'package:traveltales/features/User/Presentation/widgets/change_password_screen.dart';
import 'package:traveltales/features/User/Presentation/widgets/emergency_contacts_screen.dart';
import 'package:traveltales/features/User/Presentation/widgets/imageViewer.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/custom_list_tile.dart';

import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // String baseUrl = "http://10.0.2.2:8000/";
    return Consumer(builder: (context, ref, child) {
      // final user = ref.watch(authNotifierProvider);

      // String userProfilePath = user!.imageUrl!;

      // if (userProfilePath.isNotEmpty && userProfilePath.contains('\\')) {
      //   userProfilePath = userProfilePath.replaceAll('\\', '/');
      // }

      return Column(children: [
        //Profile Part 1
        Expanded(
          flex: 4,
          child: Container(
            color: Color(0xff798CAB),
            padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "PROFILE",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      // if (user != null)
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   // image: user!.imageUrl!.isEmpty
                            //   //     ? AssetImage("assets/images/default2.jpeg")
                            //   //     : CachedNetworkImageProvider(
                            //   //             "${baseUrl}${user.imageUrl!.replaceAll('\\', '/')}")
                            //   //         as ImageProvider<Object>,
                            // ),
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(100),
                            //color: Colors.amber,
                            border: Border.all()),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CustomNetworkImage(
                              url: ref
                                  .read(authNotifierProvider.notifier)
                                  .getImageUrl(),
                              // user: user
                            )
                            // user?.imageUrl != null &&
                            //         user!.imageUrl!.isNotEmpty
                            //     ? CustomNetworkImage(
                            //         Url: ref
                            //             .read(authNotifierProvider.notifier)
                            //             .getImageUrl(),
                            //         user: user)
                            //     : Image.asset("assets/images/default2.jpeg"),
                            ),
                      ),
                      //This is the Edit button that is on Stack.
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary),
                          child: Consumer(builder: (context, ref, child) {
                            return IconButton(
                              onPressed: () async {
                                await getImage(); // Pick an image
                                // customShowDialog(context, ref);
                                if (image != null) {
                                  // If image is picked, show alert dialog
                                  customShowDialog(context, ref);
                                } else {
                                  // Handle case where no image is picked
                                  print('No image selected');
                                }
                              },
                              icon: Icon(Icons.edit),
                              color: Theme.of(context).colorScheme.onPrimary,
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Consumer(builder: (context, ref, child) {
                    final authController = ref.watch(authNotifierProvider);

                    return Column(
                      children: [
                        Text(
                          "${authController?.fullName}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${authController?.email}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
        ),
        //Profile Part 2
        Expanded(
          flex: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Consumer(builder: (context, ref, child) {
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customListTile(context,
                            leadingIcon: Icons.person,
                            title: "Edit Profile", onTap: () {
                          ref.read(profileProvider.notifier).edit(context);
                        }),
                        customListTile(context,
                            leadingIcon: Icons.key,
                            title: "Change Password", onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ChangePasswordScreen();
                            },
                          ));
                        }),
                        customListTile(context,
                            leadingIcon: Icons.phone,
                            title: "Emergency Contacts", onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return EmergencyContactsScreen();
                            },
                          ));
                        }),
                        customListTile(context,
                            leadingIcon: Icons.info,
                            title: "About Us",
                            onTap: () {}),
                        customListTile(context,
                            leadingIcon: Icons.exit_to_app,
                            title: "Sign Out",
                            color: Theme.of(context)
                                .colorScheme
                                .tertiaryContainer, onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertBox(
                                  confirmText: "Sign Out",
                                  onPressed: () {
                                    ref
                                        .watch(authNotifierProvider.notifier)
                                        .logout(context);
                                  },
                                  title: "Sign Out?");
                            },
                          );
                        })
                      ],
                    ),
                  ),
                  Text("Version 1.1.0")
                ],
              );
            }),
          ),
        )
      ]);
    });
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
              border: Border.all(),
              shape: BoxShape.circle,
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
                    if (imageValue != null) {
                      final currentUser = ref.read(authNotifierProvider);
                      ref
                          .read(authNotifierProvider.notifier)
                          .update(currentUser!.copyWith(imageUrl: imageValue));
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

  File? image;
  final _picker = ImagePicker();
  bool showspinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
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
    var uri = Uri.parse('http://10.0.2.2:8000/users/uploadPicture');
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
}

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.url,
    this.allowFullScreen = true,
    this.color,
    // required this.authController,
  });

  final String url;
  final bool allowFullScreen;
  final Color? color;

  // final UserModel? authController;

  @override
  Widget build(BuildContext context) {
    final assetImage = Image.asset("assets/images/default2.jpeg");

    return GestureDetector(
      onTap: () {
        if (allowFullScreen)
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ImageViewer(url: url),
          ));
      },
      child: CachedNetworkImage(
        colorBlendMode: BlendMode.colorBurn,
        color: color,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return assetImage;
        },
        imageUrl: url,
        errorWidget: (context, url, error) => assetImage,
      ),
    );
  }
}
