import 'package:flutter/material.dart';
import 'package:movierse/core/styles/texts.dart';
import 'package:movierse/presentation/widgets/movie_card.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Text(
                      'Your Bookmark',
                      style: titleText.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return MovieCard();
                  },
                  itemCount: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
