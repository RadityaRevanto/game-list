
import 'package:flutter/material.dart';
import 'package:game_list/core.dart';
import '../controller/main_navigation_controller.dart';

class MainNavigationView extends StatefulWidget {
    const MainNavigationView({Key? key}) : super(key: key);

    Widget build(context, MainNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
        length: 4,
        initialIndex: controller.selectedIndex,
        child: Scaffold(
            body: IndexedStack(
                index: controller.selectedIndex,
                children: [
                    HomeView(),
                    FavoritView()
                ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.selectedIndex,
                onTap: (newIndex) => controller.updateIndex(newIndex),
                type: BottomNavigationBarType.fixed,
                items: const [
                    BottomNavigationBarItem(
                        icon: Icon(
                            Icons.home_filled,
                        ),
                        label: "Home",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                            Icons.favorite,
                        ),
                        label: "Favorite",
                    ),
                ],
            ),
        ),
    );
    }

    @override
    State<MainNavigationView> createState() => MainNavigationController();
}
    