import 'package:flutter/material.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:intl/intl.dart';

class ShopCloseCard extends StatelessWidget {
  final double cardHeight;
  final double cardWidth;
  final int index;
  final String getShopAllFilterName;
  final double allAverageScore;
  final DateTime getShopOpenTime;
  final DateTime getShopCloseTime;
  final int totalReview;
  const ShopCloseCard(
      {super.key,
      required this.cardHeight,
      required this.cardWidth,
      required this.index,
      required this.getShopAllFilterName,
      required this.allAverageScore,
      required this.getShopOpenTime,
      required this.getShopCloseTime,
      required this.totalReview});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(width: 1, color: Colors.black.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: cardWidth,
            height: cardHeight,
            child: Image.asset(
              "assets/images/shinji.jpg",
              color: Colors.white.withOpacity(0.3),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionBufferHeight(),
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    getShopAllFilterName.toString(),
                    style: kfontH2InterBlackColorHalfOpacity(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              sectionBufferHeight(),
              RichText(
                // textAlign: TextAlign.center,
                text: TextSpan(children: [
                  const WidgetSpan(
                    child: Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.amber,
                    ),
                  ),
                  //TODO : Need to see how many people score for this shop
                  TextSpan(
                      text:
                          "${allAverageScore.toStringAsFixed(1)} ($totalReview) | 555km"),
                ], style: kfontH3InterBlackColorHalfOpacity()),
              ),
              sectionBufferHeight(bufferSection: 5),
              sectionBufferHeight(bufferSection: 13),
              Text(
                "OPEN: ${DateFormat('HH:mm ').format(getShopOpenTime)} "
                "| "
                "CLOSE: ${DateFormat('HH:mm ').format(getShopCloseTime)} ",
                style: kfontH4InterBlackColorHalfOpacity(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
