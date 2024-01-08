// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:traveltales/features/category/presentation/controller/category_controller.dart';
// import 'package:traveltales/features/destination/domain/destination_model.dart';
// import 'package:traveltales/features/destination/domain/destination_model_new.dart';
// import 'package:traveltales/features/destination/presentation/widgets/add_destination_screen.dart';
// import 'package:traveltales/features/destination/presentation/widgets/destination_detail_screen.dart';
// import 'package:traveltales/features/destination/presentation/widgets/destination_form.dart';
// import 'package:traveltales/utility/list_controller.dart';

// final destinationListProvider =
//     NotifierProvider<DestinationListController, List<DestinationModel>>(
//         DestinationListController.new);

// // class DestinationListController extends Notifier<List<DestinationModel>> {
// //   final ScrollController listScrollController = ScrollController();
// //   final storage = GetStorage();

// //   @override
// //   List<DestinationModel> build() => loadDestination();

// //   final destinationKey = "destinationKey";

// //   List<DestinationModel> loadDestination() {
// //     final destinations = storage.read(destinationKey);
// //     if (destinations != null) {
// //       return destinationModelFromJson(destinations);
// //     }
// //     return [];
// //   }

// //   storeDestinations() {
// //     storage.write(destinationKey, destinationModelToJson(state));
// //   }

// //   addDestination(DestinationModel destination) {
// //     state = [...state..add(destination)];
// //     storeDestinations();
// //   }

// //   updateDestination(int index, {required DestinationModel destination}) {
// //     state = [...state..[index] = destination];
// //     storeDestinations();
// //   }

// //   removeDestination(int index) {
// //     state = [...state..removeAt(index)];
// //     storeDestinations();
// //   }

// //   handelSubmit(DestinationModel destination) {
// //     final index = state.indexWhere((element) => element.id == destination.id);
// //     print(index);
// //     if (index == -1) {
// //       addDestination(destination);
// //       print(state.length);
// //     } else {
// //       updateDestination(index, destination: destination);
// //     }
// //   }

// //   late final List<DestinationModel> destinationModel = [
// //     //first destionation
// //     DestinationModel.generateDestination(
// //         id: "1",
// //         name: "Langtang",
// //         coordinates: Coordinates(longitude: 23, latitude: 234),
// //         description: "Langtang is alskdfj",
// //         itinerary: "alskdfj",
// //         imageUrl: "assets/langtang/langtang1.jpeg",
// //         ratings: 4,
// //         review: [Review(id: "1", comment: "sajkdf", rating: 2)],
// //         category: ref.read(CategoryNotifierProvider.notifier).categories[1],
// //         region: "smth",
// //         duration: "10days",
// //         maxHeight: "5000m",
// //         bestSeason: "summer"),
// //     //second destionation
// //     DestinationModel.generateDestination(
// //         id: "2",
// //         name: "Poon Hill",
// //         coordinates: Coordinates(longitude: 23, latitude: 234),
// //         description: "Poonhill is alskdfj",
// //         itinerary: "alskdfj",
// //         imageUrl: "assets/travelPic/travel1.jpeg",
// //         ratings: 2,
// //         review: [Review(id: "1", comment: "sajkdf", rating: 2)],
// //         category: ref.read(CategoryNotifierProvider.notifier).categories[2],
// //         region: "smth",
// //         duration: "10days",
// //         maxHeight: "5000m",
// //         bestSeason: "summer"),
// //     //third destionation
// //     DestinationModel.generateDestination(
// //         id: "3",
// //         name: "Ghandruk",
// //         coordinates: Coordinates(longitude: 23, latitude: 234),
// //         description: "Ghandruk is alskdfj",
// //         itinerary: "alskdfj",
// //         imageUrl: "assets/travelPic/travel2.jpeg",
// //         ratings: 2,
// //         review: [Review(id: "1", comment: "sajkdf", rating: 2)],
// //         category: ref.read(CategoryNotifierProvider.notifier).categories[1],
// //         region: "smth",
// //         duration: "10days",
// //         maxHeight: "5000m",
// //         bestSeason: "summer"),
// //     //fourth destionation
// //     DestinationModel.generateDestination(
// //         id: "4",
// //         name: "Everest",
// //         coordinates: Coordinates(longitude: 23, latitude: 234),
// //         description: "Langtang is alskdfj",
// //         itinerary: "alskdfj",
// //         imageUrl: "assets/travelPic/travel3.jpeg",
// //         ratings: 2,
// //         review: [Review(id: "1", comment: "sajkdf", rating: 2)],
// //         category: ref.read(CategoryNotifierProvider.notifier).categories[3],
// //         region: "smth",
// //         duration: "10days",
// //         maxHeight: "5000m",
// //         bestSeason: "summer")
// //   ];

// //   showByCategory() {
// //     //yeta provider le provider lai watch gareko
// //     //so uta hamle yo method lai watch garna parena, yetai bata vaira xa
// //     final selectedCategory = ref.watch(CategoryNotifierProvider);
// //     if (selectedCategory.id == "1") {
// //       state = [...destinationModel]..shuffle();
// //     } else if (selectedCategory.id == "5") {
// //       showTopRatedDestination();
// //     } else {
// //       state = [
// //         ...[...destinationModel]
// //           ..removeWhere((e) => e.category.id != selectedCategory.id)
// //       ];
// //     }
// //     if (listScrollController.hasClients) {
// //       listScrollController.animateTo(0,
// //           duration: Duration(microseconds: 10), curve: Curves.linear);
// //     }
// //     return state;
// //   }

// //   showDestinationDetails(
// //       BuildContext context, DestinationModel destinationModel) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) {
// //           return DestinationDetailScreen(destinationModel: destinationModel);
// //         },
// //       ),
// //     );
// //   }

// //   showTopRatedDestination() {
// //     state = [...destinationModel.where((element) => element.ratings >= 3)];
// //   }

// //   // storeDestinationList() {
// //   //   final destinationList =
// //   //       ref.read(destinationProvider.notifier).destinationModel;
// //   //   state = [...state..addAll(destinationList)];
// //   //   storeDestinations();
// //   // }
// // }

// class DestinationListController extends ListController<DestinationModel> {
//   final ScrollController listScrollController = ScrollController();
//   @override
//   String get key => "destinationKey";

//   @override
//   bool findById(DestinationModel element, DestinationModel current) =>
//       element.id == current.id;

//   @override
//   Widget formWidget(DestinationModel? model) =>
//       DestinationForm(destination: model);

//   @override
//   List<DestinationModel> fromStorage(String data) =>
//       destinationModelFromJson(data);

//   @override
//   String toStorage() => destinationModelToJson(state);

//   showDestinationDetails(
//       BuildContext context, DestinationModel destinationModel) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) {
//           return DestinationDetailScreen(destinationModel: destinationModel);
//         },
//       ),
//     );
//   }
// }
