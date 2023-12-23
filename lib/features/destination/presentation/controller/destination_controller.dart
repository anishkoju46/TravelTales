import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';
import 'package:traveltales/features/category/presentation/controller/category_controller.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_detail_screen.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_form.dart';

final destinationProvider =
    NotifierProvider<DestinationController, List<DestinationModel>>(
        DestinationController.new);

class DestinationController extends Notifier<List<DestinationModel>> {
  final ScrollController listScrollController = ScrollController();
  @override
  List<DestinationModel> build() {
    return showByCategory();
  }

  late final List<DestinationModel> destinationModel = [
    //first destionation
    DestinationModel.generateDestination(
        id: "1",
        name: "Langtang",
        coordinates: Coordinates(longitude: 23, latitude: 234),
        description: "Langtang is alskdfj",
        itinerary: "alskdfj",
        imageUrl: "assets/langtang/langtang1.jpeg",
        ratings: 4,
        review: [Review(id: "1", comment: "sajkdf", rating: 2)],
        category: ref.read(CategoryNotifierProvider.notifier).categories[1],
        region: "smth",
        duration: "10days",
        maxHeight: "5000m",
        bestSeason: "summer"),
    //second destionation
    DestinationModel.generateDestination(
        id: "2",
        name: "Poon Hill",
        coordinates: Coordinates(longitude: 23, latitude: 234),
        description: "Poonhill is alskdfj",
        itinerary: "alskdfj",
        imageUrl: "assets/travelPic/travel1.jpeg",
        ratings: 2,
        review: [Review(id: "1", comment: "sajkdf", rating: 2)],
        category: ref.read(CategoryNotifierProvider.notifier).categories[2],
        region: "smth",
        duration: "10days",
        maxHeight: "5000m",
        bestSeason: "summer"),
    //third destionation
    DestinationModel.generateDestination(
        id: "3",
        name: "Ghandruk",
        coordinates: Coordinates(longitude: 23, latitude: 234),
        description: "Ghandruk is alskdfj",
        itinerary: "alskdfj",
        imageUrl: "assets/travelPic/travel2.jpeg",
        ratings: 2,
        review: [Review(id: "1", comment: "sajkdf", rating: 2)],
        category: ref.read(CategoryNotifierProvider.notifier).categories[1],
        region: "smth",
        duration: "10days",
        maxHeight: "5000m",
        bestSeason: "summer"),
    //fourth destionation
    DestinationModel.generateDestination(
        id: "4",
        name: "Everest",
        coordinates: Coordinates(longitude: 23, latitude: 234),
        description: "Langtang is alskdfj",
        itinerary: "alskdfj",
        imageUrl: "assets/travelPic/travel3.jpeg",
        ratings: 2,
        review: [Review(id: "1", comment: "sajkdf", rating: 2)],
        category: ref.read(CategoryNotifierProvider.notifier).categories[3],
        region: "smth",
        duration: "10days",
        maxHeight: "5000m",
        bestSeason: "summer")
  ];

  showByCategory() {
    //yeta provider le provider lai watch gareko
    //so uta hamle yo method lai watch garna parena, yetai bata vaira xa
    final selectedCategory = ref.watch(CategoryNotifierProvider);
    if (selectedCategory.id == "1") {
      state = [...destinationModel]..shuffle();
    } else if (selectedCategory.id == "5") {
      showTopRatedDestination();
    } else {
      state = [
        ...[...destinationModel]
          ..removeWhere((e) => e.category.id != selectedCategory.id)
      ];
    }
    if (listScrollController.hasClients) {
      listScrollController.animateTo(0,
          duration: Duration(microseconds: 10), curve: Curves.linear);
    }
    return state;
  }

  showDestinationDetails(
      BuildContext context, DestinationModel destinationModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DestinationDetailScreen(destinationModel: destinationModel);
        },
      ),
    );
  }

  showTopRatedDestination() {
    state = [...destinationModel.where((element) => element.ratings >= 3)];
  }

  // navigateToAddOrEditDestinationPage(BuildContext context) {
  //   final destination = ref.read(destinationProvider);
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //               //YETA PASS GARNA PARXA HAI
  //               return DestinationForm(destination:destination,);
  //             }));
  // }
}
