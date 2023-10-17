import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/model/shop.dart';
import 'package:flutter_application_1/utility/my_constant.dart';


class ShopPage extends StatefulWidget {
  const ShopPage({Key? key, required this.shop}) : super(key: key);
  final Shop? shop;

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: kPinkInactiveColor,
            elevation: 0,
            pinned: true,
            centerTitle: false,
            expandedHeight: 300,
            flexibleSpace: const FlexibleSpaceBar(
              background: Image(
                //TODO Image That Shop have
                image: AssetImage("assets/images/shop-wallpaper.jpg"),
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          )
          ,
          SliverToBoxAdapter(
            child: Text("Shop Description Shop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop DescriptionShop Descriptionv"),
          )
        ],
      ),
    );
  }
}
