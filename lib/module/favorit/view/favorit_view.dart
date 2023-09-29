import 'package:flutter/material.dart';
import 'package:game_list/core.dart';
import '../controller/favorit_controller.dart';

class FavoritView extends StatefulWidget {
  const FavoritView({Key? key}) : super(key: key);

  Widget build(context, FavoritController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorit Game",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: const [],
      ),
      body:  Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 10),
        child: controller.isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : controller.dataListFavorite.length == 0
            ? Center(
          child: Text("Kamu tidak memiliki game Favorit"),
        )
            :RefreshIndicator(
          onRefresh: () async {
            await controller.refresh(); // Panggil fungsi refresh() dari controller
          },
              child: ListView.builder(
          itemCount: controller.dataListFavorite.length,
          itemBuilder: (c, index) {
              final item = controller.dataListFavorite[index];
              return InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(30),
                  width: 315,
                  height: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          offset: Offset(0.0, 4.0), //(x,y)
                          blurRadius: 4.0,
                        ),
                      ]),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.only(right: 30),
                        child: FadeInImage.assetNetwork(
                            placeholder: 'https://images.unsplash.com/photo-1695653423053-64e76a128f1c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60',
                            image: item.image
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              item.name,
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              width: 150,
                              child: Text(
                                item.slug,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w400),

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                "Since : " + item.released,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          controller.showDeleteDialog(context, item.name);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
          },
        ),
            ),
      ),
    );
  }

  @override
  State<FavoritView> createState() => FavoritController();
}
