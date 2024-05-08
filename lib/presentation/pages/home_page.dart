import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/core/styles/texts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: bgDark,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Text(
                        'Hello, Alex',
                        style: titleText.copyWith(),
                      ),
                      Spacer(),
                      Image.asset('assets/icons/profile.png')
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'NOW PLAYING',
                          style: titleText.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 400,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: [1, 2, 3, 4, 5].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(color: accentColor),
                                  child: Text(
                                    'text $i',
                                    style: TextStyle(fontSize: 16.0),
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Top Rated',
                        style: titleText.copyWith(),
                      ),
                      Spacer(),
                      Text(
                        'See More',
                        style: titleText.copyWith(color: accentColor),
                      )
                    ],
                  ),
                ),
                MovieList(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Popular',
                        style: titleText.copyWith(),
                      ),
                      Spacer(),
                      Text(
                        'See More',
                        style: titleText.copyWith(color: accentColor),
                      )
                    ],
                  ),
                ),
                MovieList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: accentColor),
                        child: Text(
                          'text',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text('Sample Name', style: subtitleText.copyWith(

                    ),),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Text('4', style: titleText,),
                        SizedBox(width: 8,),
                        RatingBarIndicator(
                          rating: 4,
                          itemCount: 5,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: accentColor,
                          ),
                          itemSize: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
