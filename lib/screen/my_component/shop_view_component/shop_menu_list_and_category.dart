// // import 'dart:core';
// // import 'package:flutter_application_1/model/menu.dart';
// // import 'package:intl/intl.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_application_1/utility/my_constant.dart';
// // import 'package:zoom_tap_animation/zoom_tap_animation.dart';


// // class ShopMenuTitleAndCategoryAndListItemAndGridSlideAble extends StatefulWidget{
// //   final String title;
// //   final List<String> categoryList;
// //   final List<Menu>
// //   final Function filterShopListItemByCategoryListName;
// //   const ShopMenuTitleAndCategoryAndListItemAndGridSlideAble({
// //     Key? key,
// //     required this.title, this.categoryList, required this.filterShopListItemByCategoryListName
// //   }): super(key:key);
// //   @override
// //   State<ShopMenuTitleAndCategoryAndListItemAndGridSlideAble> createState() => _ShopMenuTitleAndCategoryAndListItemAndGridSlideAbleState();
  
// // }

// // class _ShopMenuTitleAndCategoryAndListItemAndGridSlideAbleState extends State<ShopMenuTitleAndCategoryAndListItemAndGridSlideAble> {

// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     throw UnimplementedError();
// //   }
// // }

// // class ShopOpenCard extends StatelessWidget {
// //   final double cardHeight;
// //   final double cardWidth;
// //   final int index;
// //   final String getShopAllFilterName;
// //   final double allAverageScore;
// //   final DateTime getShopOpenTime;
// //   final DateTime getShopCloseTime;
// //   final int totalReview;
// //   final VoidCallback navigateToShop;
// //   const ShopOpenCard(
// //       {super.key,
// //       required this.cardHeight,
// //       required this.cardWidth,
// //       required this.index,
// //       required this.getShopAllFilterName,
// //       required this.getShopOpenTime,
// //       required this.getShopCloseTime,
// //       required this.allAverageScore,
// //       required this.totalReview,
// //       required this.navigateToShop});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ZoomTapAnimation(
// //       child: GestureDetector(
// //         onTap: navigateToShop,
// //         child: Container(
// //           // width: MediaQuery.of(context).size.width - cardWidth - 20,
// //           height: cardHeight,
// //           decoration: BoxDecoration(
// //               color: Colors.transparent,
// //               borderRadius: BorderRadius.circular(3),
// //               border: Border.all(width: 2)),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             children: [
// //               Container(
// //                 margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
// //                 width: cardWidth,
// //                 height: cardHeight,
// //                 child: Image.asset(
// //                   "assets/images/shinji.jpg",
// //                 ),
// //               ),
// //               Column(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   sectionBufferHeight(),
// //                   Flexible(
// //                     child: Container(
// //                       width: 200,
// //                       margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
// //                       child: Text(
// //                         getShopAllFilterName.toString(),
// //                         style: kfontH2InterBlackColor(),
// //                         overflow: TextOverflow.ellipsis,
// //                         maxLines: 1,
// //                       ),
// //                     ),
// //                   ),
// //                   sectionBufferHeight(),
// //                   RichText(
// //                     // textAlign: TextAlign.center,
// //                     text: TextSpan(children: [
// //                       const WidgetSpan(
// //                         child: Icon(
// //                           Icons.star,
// //                           size: 20,
// //                           color: Colors.amber,
// //                         ),
// //                       ),
// //                       //TODO : Need to see how many people score for this shop
// //                       TextSpan(
// //                           text:
// //                               "${allAverageScore.toStringAsFixed(1)} ($totalReview) | 555km")
// //                     ], style: kfontH3InterBlackColor()),
// //                   ),
// //                   sectionBufferHeight(bufferSection: 5),
// //                   sectionBufferHeight(bufferSection: 13),
// //                   Text(
// //                     "OPEN: ${DateFormat('HH:mm ').format(getShopOpenTime)} "
// //                     "| "
// //                     "CLOSE: ${DateFormat('HH:mm ').format(getShopCloseTime)} ",
// //                     style: kfontH4InterBlackColor(),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/menu.dart';

// class ShopMenuTitleAndCategoryAndListItemAndListViewBuilder extends StatefulWidget {
//   final String title;
//   final List<String> categoryList;
//   final List<Menu> menuList; // Fix: Add missing parameter type
//   final Function filterShopListItemByCategoryListName;

//   const ShopMenuTitleAndCategoryAndListItemAndListViewBuilder({
//     Key? key,
//     required this.title,
//     required this.categoryList,
//     required this.menuList,
//     required this.filterShopListItemByCategoryListName,
//   }) : super(key: key);

//   @override
//   State<ShopMenuTitleAndCategoryAndListItemAndListViewBuilder> createState() =>
//       _ShopMenuTitleAndCategoryAndListItemAndListViewBuilderState();
// }

// class _ShopMenuTitleAndCategoryAndListItemAndListViewBuilderState
//     extends State<ShopMenuTitleAndCategoryAndListItemAndListViewBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Menu',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Divider(),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 for (String category in widget.categoryList)
//                   ElevatedButton(
//                     onPressed: () {
//                       // Call your filter function here
//                       widget.filterShopListItemByCategoryListName(category);
//                     },
//                     child: Text(category),
//                   ),
//               ],
//             ),
//           ),
//           Divider(),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.menuList.length, // Replace with the actual item count
//               itemBuilder: (context, index) {
//                 // Replace with your actual item widget
//                 return ListTile(
//                   title: Text(widget.menuList[index].menuName),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
