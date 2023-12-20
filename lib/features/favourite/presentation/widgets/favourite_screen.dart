import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //For Tile Travel Tales
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Favourite",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
                //Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SearchBar(
                    onTap: () {},
                    leading: Icon(Icons.search),
                    hintText: "Search for a place",
                  ),
                ),
                //Title: Category
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Categories",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                // Category Navigator Bar
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customCategoryBar(context, categoryOption: "Easy"),
                        customCategoryBar(context, categoryOption: "Moderate"),
                        customCategoryBar(context,
                            categoryOption: "Challenging")
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 150,
                //   child: ListView.separated(
                //       itemBuilder: (context, index) {
                //         return SizedBox();
                //       },
                //       separatorBuilder: (BuildContext context, int index) {
                //         return SizedBox(
                //           height: 20,
                //         );
                //       },
                //       itemCount: 2),
                // )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                destinationShowCase(context,
                    image: "assets/langtang/langtang11.png",
                    destination: "Langtang"),
                destinationShowCase(context,
                    image: "assets/langtang/langtang11.png",
                    destination: "Poon Hill"),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Padding destinationShowCase(BuildContext context,
      {required String image,
      required String destination,
      String explore = "Explore"}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: Stack(
        children: [
          Container(
            height: 150,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(image),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff333C4B),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.star,
                  color: Color(0xffD4A056),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Text(
              destination,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: Text(
              explore,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector customCategoryBar(BuildContext context,
      {required String categoryOption}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: Text(
            categoryOption,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          )),
    );
  }
}
