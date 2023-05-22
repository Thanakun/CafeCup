import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/model/shop.dart';

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
      body: Text(widget.shop!.shopId.toString()),
    );
  }
}
