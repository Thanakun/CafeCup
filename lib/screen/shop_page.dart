import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/model/shop.dart';
import 'package:flutter_application_1/utility/my_constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
// import 'package:geolocator/geolocator.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key, required this.shop}) : super(key: key);
  final Shop? shop;

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  //TODO Show Google Map
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  List<LatLng> savedLocations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Center(
                  child: Text(widget.shop?.shopId.toString() ?? "No Shop Id"),
                ),
                Center(
                  child: Text(widget.shop?.shopName ?? "No Shop"),
                ),
                Container(
                  height: 20,
                  child: Center(
                    child: Text(
                      "Detail",
                      style: kfontH1InterBlackColor(),
                    ),
                  ),
                ),
                sectionBufferHeight(),
                // Container(
                //TODO SHOW GOOGLE MAP OF THE SHOP
                // height: 200,
                // child: GoogleMap(
                //   onMapCreated: (GoogleMapController controller) {
                //     _controller = controller;
                //   },
                //   initialCameraPosition: CameraPosition(
                //     target: LatLng(37.7749, -122.4194), // Set the initial map location (San Francisco, for example)
                //     zoom: 12.0, // Set the initial zoom level
                //   ),
                //   markers: _markers,
                //   onTap: _handleMapTap,
                // ),
                // ),
                Container(
                    child: Text(
                        widget.shop?.shopDescription ?? " No Description")),
                Container(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.access_time_outlined,
                                size: 14,
                              ),
                            ),
                            TextSpan(
                              text:
                                  " ${DateFormat('HH:mm ').format(widget.shop!.shopOpenTime)} - ${DateFormat('HH:mm ').format(widget.shop!.shopCloseTime)}",
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.location_on,
                              size: 14,
                            ),
                          ),
                          TextSpan(text: widget.shop!.shopLocationText)
                        ]),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleMapTap(LatLng tapLocation) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(tapLocation.toString()),
          position: tapLocation,
          infoWindow: InfoWindow(title: 'Shop Marker'),
        ),
      );
    });
  }

  void _clearMarkers() {
    setState(() {
      _markers.clear();
    });
  }
}
