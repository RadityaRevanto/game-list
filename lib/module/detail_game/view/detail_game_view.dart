import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:game_list/core.dart';
import '../../../model/favorit_model.dart';
import '../controller/detail_game_controller.dart';

class DetailGameView extends StatefulWidget {
  final id;
  const DetailGameView({Key? key, required this.id}) : super(key: key);

  Widget build(context, DetailGameController controller) {
    controller.view = this;
    FavoriteModel favorite = FavoriteModel(
      image: controller.gameDetail?.backgroundImage.toString() ?? '',
      name: controller.gameDetail?.name.toString() ?? '',
      slug: controller.gameDetail?.slug.toString() ?? '',
      released: controller.gameDetail?.released.toString() ?? '',
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.gameDetail?.nameOriginal ?? "",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        actions:  [

          FutureBuilder<bool>(
            future: controller.isFavorite(favorite),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                bool isFav = snapshot.data!;
                return IconButton(
                  onPressed: () async {
                    if (isFav) {
                      await controller.removeFromFavorite(favorite);
                    } else {
                      await controller.addToFavorites(favorite);
                    }
                    // setState(() {
                    //   // Refresh the UI to update the favorite icon
                    // });
                    // Navigator.pop(context);

                  },
                  icon: Icon(
                    isFav
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: controller.checkExist
                        ? Colors.white
                        : controller.colorChecked,
                  ),
                );
              }
              return Container();
            },
          ),
        ],

      ),
      backgroundColor: Color.fromARGB(255, 255, 220, 220),
      body: SingleChildScrollView(
        child:Center(
          child: Container(
            child:
            controller.gameDetail == null ?
            Container(
              height: 600,
              child: Center(
                  child: CircularProgressIndicator()),
            )
                :
            Column(
              children: <Widget>[
                SizedBox(
                    child: Stack(children: <Widget>[
                  Image.network(
                      controller.gameDetail?.backgroundImage ?? "",
                      fit: BoxFit.contain,
                      ),
                  Container(
                    width: 800,
                    height: 200,
                    color: Color.fromARGB(94, 11, 9, 9),
                  ),
                  Container(
                      width: 750,
                      child: Text(
                          controller.gameDetail?.nameOriginal ?? "",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              height: 8,
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                              color: Colors.white))),
                  Container(
                    width: 750,
                    child: Text(
                      controller.gameDetail?.released ?? "",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          height: 13,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Roboto",
                          color: Colors.white),
                    ),
                  )
                ])),
                SizedBox(height: 15,),
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        color: Colors.transparent,
                      ),
                      Container(
                        padding: EdgeInsets.all(25),
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Color(0xFFF9F9F9),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ImageContainer(
                                      width: 110,
                                      height: 85,
                                      margin: EdgeInsets.all(10.0),
                                      imageUrl: controller.gameDetail?.backgroundImage ?? ""),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.gameDetail?.nameOriginal ?? "",
                                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          controller.gameDetail?.slug ?? "",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 3,),
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: Colors.yellow, size: 15),
                                            SizedBox(width: 4.0,),
                                            Text(  controller.gameDetail?.rating.toString() ?? "0",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Deskripsi : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text(
                                    controller.gameDetail?.descriptionRaw ?? "",
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 5,
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: Text("Developer : ", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.gameDetail?.developers?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final developer = controller.gameDetail!.developers![index];
                                  return Center(
                                    child:Column(
                                      children: [
                                        SizedBox(height: 5),
                                        ImageContainer(
                                          width: 200,
                                          margin: EdgeInsets.all(10.0),
                                          imageUrl: developer.imageBackground ?? "",
                                        ),
                                        Text(
                                          developer.name ?? "",
                                          style: TextStyle(fontSize: 12),
                                          maxLines: 4,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: Text("Genre : ", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.gameDetail?.genres?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final developer = controller.gameDetail!.genres![index];
                                  return Center(
                                    child:Column(
                                      children: [
                                        SizedBox(height: 5),
                                        ImageContainer(
                                          width: 200,
                                          margin: EdgeInsets.all(10.0),
                                          imageUrl: developer.imageBackground ?? "",
                                        ),
                                        Text(
                                          developer.name ?? "",
                                          style: TextStyle(fontSize: 12),
                                          maxLines: 4,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<DetailGameView> createState() => DetailGameController();
}
