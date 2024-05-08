import 'package:flutter/material.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/presentation/pages/bookmark_page.dart';
import 'package:movierse/presentation/pages/home_page.dart';
import 'package:movierse/presentation/pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: buildMyNavBar(context), body: body());
  }

  body() {
    switch (currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return SearchPage();
      case 2:
        return BookmarkPage();
      default:
        return HomePage();
    }
  }

  Padding buildMyNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
            backgroundColor: bgCard,
            currentIndex: currentIndex,
            onTap: (value) {
              print(value);
              setState(() {
                currentIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Icon(
                      Icons.home_sharp,
                      color: currentIndex == 0 ? accentColor : whiteColor,
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Icon(
                    Icons.search,
                    color: currentIndex == 1 ? accentColor : whiteColor,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Icon(
                    Icons.bookmark,
                    color: currentIndex == 2 ? accentColor : whiteColor,
                  ),
                ),
                label: '',
              ),
            ]),
      ),
    );
  }
}
