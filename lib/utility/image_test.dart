import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';

class ImageTest extends StatefulWidget {
  const ImageTest({super.key});

  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  File? image;
  final _picker = ImagePicker();
  bool showspinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print("no image selected");
    }
  }

  Future<void> uploadImage({required String token}) async {
    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('http://10.0.2.2:8000/users/uploadPicture');
    // var uri = Uri.parse('http://localhost:8000/users/uploadPicture');

    var request = http.MultipartRequest('POST', uri);

    request.headers['x-access-token'] = token;

    request.fields['image'] = 'image';
    var multiport = http.MultipartFile('image', stream, length,
        contentType: MediaType.parse('image/jpg'));
    request.files.add(multiport);
    var response = await request.send();
    try {
      if (response.statusCode == 200) {
        print('image uploaded');
      } else {
        print('image upload failed');
      }
    } catch (e, s) {
      print("${e} ${s}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.yellow),
                  child: const Text("Pick an image"),
                ),
              ),
              Container(
                child: image == null
                    ? const Text('Pick an image')
                    : Image.file(
                        File(image!.path).absolute,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
              ),
              Consumer(builder: (context, ref, child) {
                String? token = ref.watch(authNotifierProvider)?.token;
                return GestureDetector(
                  onTap: () {
                    uploadImage(token: token!);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle, color: Colors.green),
                    child: Text('Upload'),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     // padding: EdgeInsets.symmetric(vertical: 10),
  //     child: Column(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 20),
  //           child: Column(
  //             children: [
  //               Container(
  //                 padding: EdgeInsets.symmetric(vertical: 10),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       "Gallery",
  //                       style: Theme.of(context)
  //                           .textTheme
  //                           .headlineLarge
  //                           ?.copyWith(fontWeight: FontWeight.w800),
  //                     ),
  //                     IconButton(
  //                         onPressed: () {
  //                           // getImage();
  //                           //uploadImage("test", File('assets/images/aa.jpg'));
  //                         },
  //                         icon: Icon(
  //                           Icons.add_photo_alternate,
  //                           size: 30,
  //                         ))
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
