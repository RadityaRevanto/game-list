  import 'package:flutter/material.dart';
  import 'package:game_list/core.dart';
  import 'package:game_list/widget/image_container.dart';
  import '../controller/home_controller.dart';

  class HomeView extends StatefulWidget {
    const HomeView({Key? key}) : super(key: key);

    Widget build(context, HomeController controller) {
      controller.view = this;

      return Scaffold(
        appBar: AppBar(
          title: const Text("Games For You",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          actions: const [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => controller.runFilters(value),
                decoration: InputDecoration(
                  hintText: 'Search',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blueGrey[900],
                  ),

                ),
              ),
              SizedBox(height: 16.0,),
              Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.foundGames.length,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () => Get.to(DetailGameView(id: controller.foundGames[index]['id'].toString(),)),
                        child: Row(
                          children: [
                            ImageContainer(
                                width: 110,
                                height: 85,
                                margin: EdgeInsets.all(10.0),
                                imageUrl: controller.foundGames[index]['image'].toString(),),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.foundGames[index]['name'].toString(),
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(controller.foundGames[index]['slug'].toString(),style: TextStyle(fontSize: 14),),
                                  Row(
                                    children: [
                                      Text("Released : ",style: TextStyle(fontSize: 14),),
                                      SizedBox(width: 4.0,),
                                      Text(controller.foundGames[index]['released'].toString(),style: TextStyle(fontSize: 14),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    @override
    State<HomeView> createState() => HomeController();
  }
