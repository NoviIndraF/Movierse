import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movierse/core/constant/constants.dart';
import 'package:movierse/core/routes/routes.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/core/styles/texts.dart';
import 'package:movierse/domain/entities/movie.dart';

class ItemCardMovie extends StatelessWidget {
  final Movie movie;

  ItemCardMovie(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 180,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            DETAIL_MOVIE_ROUTE,
            arguments: movie.id,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                movie.title ?? '...',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: subtitleText.copyWith(),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: movie.voteAverage! / 2,
                    itemCount: 5,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: accentColor,
                    ),
                    itemSize: 24,
                  ),
                  Text('${movie.voteAverage}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
