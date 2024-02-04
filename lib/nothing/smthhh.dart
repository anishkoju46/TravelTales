// import 'package:flutter/material.dart';
// import 'package:thera_mind/features/therapist/domain/therapist_model.dart';
// import 'package:thera_mind/features/therapist/presentation/widgets/therapist_description.dart';
// import 'package:thera_mind/features/therapist/presentation/widgets/therapist_review.dart';

// class TherapistDashboard extends StatelessWidget {
//   const TherapistDashboard({
//     super.key,
//     required this.therapist,
//   });
//   final TherapistModel therapist;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text("Therapist"),
//         ),
//         body: Column(
//           children: [
//             Card(
//               margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               color: Theme.of(context).colorScheme.tertiaryContainer,
//               child: TabBar(
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 tabAlignment: TabAlignment.center,
//                 dividerColor: Colors.transparent,
//                 labelPadding: const EdgeInsets.symmetric(horizontal: 50),
//                 isScrollable: true,
//                 indicator: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Theme.of(context).colorScheme.primary),
//                 tabs: [
//                   Text(
//                     "Details",
//                     style: Theme.of(context)
//                         .textTheme
//                         .labelLarge
//                         ?.copyWith(fontSize: 23),
//                   ),
//                   Text(
//                     "Reviews",
//                     style: Theme.of(context)
//                         .textTheme
//                         .labelLarge
//                         ?.copyWith(fontSize: 23),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   TherapistDescription(
//                     therapist: therapist,
//                   ),
//                   //review wala page
//                   TherapistReview(
//                     therapist: therapist,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }