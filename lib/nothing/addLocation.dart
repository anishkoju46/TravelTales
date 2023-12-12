//import 'package:crud_login/home.dart';
import 'package:flutter/material.dart';
import 'package:traveltales/nothing/location.dart';
import 'package:traveltales/nothing/validator.dart';

class AddLocation extends StatefulWidget {
  final Location? location;

  const AddLocation({
    super.key,
    this.location,
  });
  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.location != null) {
      _locationController.text = widget.location!.locationName;
      _descriptionController.text = widget.location!.description;
      _longitudeController.text =
          widget.location!.myCoordinates.longitude.toString();
      _latitudeController.text =
          widget.location!.myCoordinates.latitude.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isAdded = widget.location == null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('LOCATIONS'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.00, right: 10.00, top: 5.00, bottom: 0.00),
                    child: TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Location Name',
                        hintText: 'Example: RaRa',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Legit Location Only";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.00, right: 10.00, top: 35.00, bottom: 0.00),
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'About Place',
                        hintText: 'Example:Solo trek',
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "How is that place?";
                        }
                        return null;
                      },
                    ),
                  ),
                  //FOR LONGITUDE AND LATITUDE
                  //longtitude UI
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.00, right: 10.00, top: 35.00, bottom: 0.00),
                    child: TextFormField(
                      controller: _longitudeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Longtitude',
                        hintText: 'provide longtitude',
                      ),
                      validator: doubleValidator,
                    ),
                  ),
                  //latitude UI
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.00, right: 10.00, top: 35.00, bottom: 0.00),
                    child: TextFormField(
                      controller: _latitudeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Latitude',
                        hintText: 'provide latitude',
                      ),
                      validator: doubleValidator,
                    ),
                  ),
                  //ADD BUTTON KO UI
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            _addingLocation();
                            isAdded = !isAdded;
                          },
                          child: Text(isAdded ? 'ADD' : 'EDIT')),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  //ADD BUTTON KO LOGIN

  // void _addingLocation() async {
  //   var form = _formKey.currentState;
  //   if (form!.validate()) {
  //     String newLocationName = _locationController.text;

  //     //Check if the location already exists
  //     bool locationExists = false;
  //     for (var places in widget.location) {
  //       if (listLocation == newLocationName) {}
  //     }
  //   }
  // }

  void _addingLocation() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      //text editing controller le String matra linxa so parse gareko

      double longitude = double.parse(_longitudeController.text);
      double latitude = double.parse(_latitudeController.text);

      //New Addtion of location
      if (widget.location == null) {
        // Navigator.pop(
        //     context,
        //     Location(
        //       locationName: _locationController.text,
        //       description: _descriptionController.text,
        //       myCoordinates:
        //           MyCoordinates(longitude: longitude, latitude: latitude),
        //     ));
      } else {
        Navigator.pop(
            context,
            widget.location?.copyWith(
                locationName: _locationController.text,
                description: _descriptionController.text,
                myCoordinates: widget.location?.myCoordinates
                    .copyWith(latitude: latitude, longitude: longitude)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Information'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

//DIALOUGE BOX HO HAI YO
// bool edit = await showDialog(
//   context: context,
//   builder: (context) => AlertDialog(
//     title: const Text('Are you sure ?'),
//     actions: [
//       TextButton(
//         onPressed: () {
//           Navigator.pop(context, false);
//         },
//         child: const Text(
//           'No',
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.blue),
//         ),
//       ),
//       TextButton(
//         onPressed: () {
//           Navigator.pop(context, true);
//         },
//         child: const Text(
//           'Yes',
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.red),
//         ),
//       ),
//     ],
//   ),
// );
// if (edit == true) {

// }
