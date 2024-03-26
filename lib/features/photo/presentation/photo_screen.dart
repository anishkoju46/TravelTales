import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';

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
      //set state garekoxa
    } else {
      print("no image selected");
    }
  }

  Future<void> uploadImage({required String token}) async {
    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    // var uri = Uri.parse('http://localhost:8000/users');
    var uri = Uri.parse('http://10.0.2.2:8000/users/uploadPicture');
    var request = http.MultipartRequest('POST', uri);

    request.headers['x-access-token'] = token;

    request.fields['image'] = 'image';
    var multiport = http.MultipartFile('image', stream, length,
        contentType: MediaType.parse('image/jpg'));
    request.files.add(multiport);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('image uploaded');
    } else {
      print('image upload failed');
    }
  }

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
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
  //                           getImage();
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  onTap: () async {
                    // print(token);
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
}

// uploadImage(String title, File file) async {
//   var request = http.MultipartRequest(
//       "POST", Uri.parse("http://localhost:8000/" + "image"));

//   request.fields['title'] = "testImage";

//   var picture = http.MultipartFile.fromBytes('image',
//       (await rootBundle.load('assets/images/aa.jpg')).buffer.asInt8List(),
//       filename: 'aa.png');

//   request.files.add(picture);

//   var response = await request.send();

//   var responseData = await response.stream.toBytes();

//   var result = String.fromCharCodes(responseData);

//   print(result);
// }
