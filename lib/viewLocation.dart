import 'package:flutter/material.dart';
import 'package:traveltales/location.dart';

class ViewLocation extends StatefulWidget {
  const ViewLocation({super.key});

  @override
  State<ViewLocation> createState() => _TravelState();
}

class _TravelState extends State<ViewLocation> {
  //int selected = 1;
  final List<Location> myTravelList = [
    //First Thau
    Location(
      locationName: "Vestrahorm",
      myCoordinates: MyCoordinates(longitude: 23, latitude: 23),
      locationCaption: "Feel the freedom",
      description:
          "Iceland is at the juncture of the North Atlantic and Artic Oceans. Explore this area on a sell drive tour in Iceland. Iceland is at the juncture of the North Atlantic and Artic Oceans. Explore this area on a sell drive tour in Iceland.",
      locationTemperature: 17,
      locationRating: 4.9,
      imageURL: "assets/travelPic/travel1.jpeg",
    ),
    //Second Thau
    Location(
      locationName: "Kattegat",
      myCoordinates: MyCoordinates(longitude: 23, latitude: 23),
      locationCaption: "Viking Era",
      description:
          "The city of Kattegat is a setting for the shows Vikings and Vikings: Valhalla, but is Kattegat a real location? Created by Michael Hirst, Vikings debuted on History Channel in 2013 and was originally planned to be a short miniseries. As Vikings season 1 was very well received, there was a change of plans, and it was renewed for season 2, allowing viewers to keep exploring the stories of Ragnar, Lagertha, Rollo, Floki, and more.",
      locationTemperature: 11,
      locationRating: 5.0,
      imageURL: "assets/travelPic/travel2.jpeg",
    ),
    //Third Thau
    Location(
      locationName: "Lofotr",
      myCoordinates: MyCoordinates(longitude: 23, latitude: 23),
      locationCaption: "Grass and Glory",
      description:
          "The Lofotr Viking Museum is a historical museum based on a reconstruction and archaeological excavation of a Viking chieftain's village on the island of Vestvågøya in the Lofoten archipelago in Nordland county, Norway. It is located in the small village of Borg, near Bøstad, in the municipality of Vestvågøy.",
      locationTemperature: 17,
      locationRating: 4.9,
      imageURL: "assets/travelPic/travel3.jpeg",
    ),
    Location(
      locationName: "Sukute",
      myCoordinates: MyCoordinates(longitude: 23, latitude: 23),
      locationCaption: "Grass and Glory",
      description:
          "The Lofotr Viking Museum is a historical museum based on a reconstruction and archaeological excavation of a Viking chieftain's village on the island of Vestvågøya in the Lofoten archipelago in Nordland county, Norway. It is located in the small village of Borg, near Bøstad, in the municipality of Vestvågøy.",
      locationTemperature: 17,
      locationRating: 4.9,
      imageURL: "assets/travelPic/travel4.jpeg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffF7F8F7),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //1ST MAIN ITEM
            Text(
              "People like",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: const Color(0xff494C4E)),
            ),
            //2ND MAIN ITEM
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 40),
              //color: Colors.amber,
              child: SizedBox(
                //Responsive way ma height deko, i.e: 40% of screen khanxa yo sizedbox le
                height: MediaQuery.of(context).size.height * 0.42,
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  //padding: const EdgeInsets.symmetric(vertical: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: myTravelList.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: travelPhoto(myTravelList[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                ),
              ),
            ),
            //3RD MAIN ITEM
            travelDetails(myTravelList.first),
            //4TH MAIN ITEM
            buttomUI()
          ],
        ),
      ),
    ));
  }

  Container travelPhoto(Location travelPhoto) {
    return Container(
      //margin: EdgeInsets.only(bottom: 10),
      //height: 400,
      width: double.infinity,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          image: DecorationImage(
              image: AssetImage(travelPhoto.imageURL), fit: BoxFit.cover)),
      child: Container(
        padding: const EdgeInsets.only(left: 20, bottom: 20),
        //Photo ko overlap ma Description
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                travelPhoto.locationName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 27),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Color(0xffB9C5D0),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    travelPhoto.myCoordinates.longitude.toString() +
                        " " +
                        travelPhoto.myCoordinates.latitude.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: const Color(0xffB9C5D0)),
                  ),
                ],
              )
            ]),
      ),
    );
  }

  Container travelDetails(Location travellocations) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      //color: Colors.blue,
      //margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            travellocations.locationCaption,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            travellocations.description,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          //for 3 ota button vako row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //button ko vitro ko row
              //first button
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xffEDF1F4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(118, 122, 125, 0.4),
                        blurRadius: 1,
                      )
                    ]),
                child: Row(
                  children: [
                    const Icon(
                      Icons.near_me,
                      color: Color(0xff16B3BB),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${travellocations.locationDistance.toInt()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: const Color(0xff767A7D),
                                    fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ".${travellocations.locationDistance.toStringAsFixed(2).split(".").last} KM",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: const Color(0xff767A7D),
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xffEDF1F4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(118, 122, 125, 0.4),
                        blurRadius: 1,
                      )
                    ]),
                child: Row(
                  children: [
                    const Icon(
                      Icons.sunny,
                      color: Color(0xff16B3BB),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${travellocations.locationTemperature.toInt()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: const Color(0xff767A7D),
                                    fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ".${travellocations.locationTemperature.toStringAsFixed(2).split(".").last} °C",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: const Color(0xff767A7D),
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xffEDF1F4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(118, 122, 125, 0.4),
                        blurRadius: 1,
                      )
                    ]),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xff16B3BB),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      travellocations.locationRating.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff767A7D)),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buttomUI() => Container(
        margin: const EdgeInsets.only(top: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xffFFFCFF),
                  // color: Colors.green,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xff9DA4AA),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 7,
                        spreadRadius: 1)
                  ]),
              child: const Icon(
                Icons.favorite,
                color: Color(0xffE05743),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              //Ink Well is alike geture detector
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xff3BC2B2)),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 12),
                      child: Text(
                        "Let's GO trip!",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19),
                      )),
                ),
              ),
            )
          ],
        ),
      );
}
