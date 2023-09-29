import 'package:flutter/material.dart';
import '../../../state_util.dart';
import '../../detail_game/view/detail_game_view.dart';
import '../controller/category_controller.dart';

class CategoryView extends StatefulWidget {

  CategoryView({Key? key}) : super(key: key);

  Widget build(context, CategoryController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("PlayStation 5",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 9,
                itemBuilder: (context, index){

                  String gameTitle = "Vampire: The Masquerade - Bloodlines 2";
                  String relase = "Release Date 2021-08-20";
                  String gameImageUrl =
                      "https://images.unsplash.com/photo-1695582341851-8cc6eba24e1a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60";

                  return  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      // onTap: () => Get.to(DetailGameView()),
                      child: Row(
                        children: [
                          // ImageContainer(
                          //     width: 110,
                          //     height: 85,
                          //     margin: EdgeInsets.all(10.0),
                          //     imageUrl: controller.gamesList?.results[index].imageBackground ?? ""),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  // controller.gamesList?.results[index].games[index].name ??
                                      "Grand Theft Auto V",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  // controller.gamesList?.results[index].games[index].slug ??
                                      "grand-theft-auto-v",style: TextStyle(fontSize: 14),),
                                Row(
                                  children: [
                                    Text("Games Count : ",style: TextStyle(fontSize: 14),),
                                    SizedBox(width: 4.0,),
                                    Text(
                                      // controller.gamesList?.results[index].games[index].name.toString() ??
                                          "20057",style: TextStyle(fontSize: 14),),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  State<CategoryView> createState() => CategoryController();
}
