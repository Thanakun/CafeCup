import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/screen/my_component/bottom_navigationbar_customer.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/customer_shop_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerHomePageView extends StatefulWidget {
  const CustomerHomePageView({super.key});

  @override
  State<CustomerHomePageView> createState() => _CustomerHomePageViewState();
}

class _CustomerHomePageViewState extends State<CustomerHomePageView> {
  late CustomerShopViewModel _vm;
  int _current = 0;
  @override
  void initState() {
    super.initState();
    _vm = CustomerShopViewModel();
    _vm.getUserWhenEnteringTheRegisterPage();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomerNavigationBar(
          pageName: "HOME",
        ),
        body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundCustomerHomeImagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //make app bar here
                shopAppBar(width),
                shopTextFieldForm(),
                Container(
                  margin: EdgeInsets.only(
                      left: width * 0.05, right: width * 0.05, top: 10),
                  child: Column(
                    children: [
                      sectionBufferHeight(bufferSection: 16),
                      headerContainer(header: "CUSTOMER_HOME.CAFE_HOT").tr(),
                      sectionBufferHeight(bufferSection: 16),
                      //Create Carousel Shop Cafe here
                      FutureBuilder(
                        future: _vm.listAllShopFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return CarouselSlider.builder(
                              options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  height: 100,
                                  enableInfiniteScroll: true,
                                  viewportFraction: 0.44,
                                  initialPage: 0,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;

                                      print(_current);
                                      print(index);
                                    });
                                  }),
                              itemCount: 10,
                              itemBuilder: (context, index, realIndex) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.amber,
                                  child: Text(snapshot.data![index].name!),
                                );
                              },
                            );
                          }
                        },
                      ),
                      Container(
                        decoration: kdecorationForContainerApplication,
                        child: Text(
                          "Hello World",
                          style: kfont26_400(),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget shopAppBar(double width) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        // margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: backgroundActiveButton,
        ),
        child: Row(
          //make the Text Center and icon on the left
          children: [
            //make icon
            Icon(
              Icons.coffee,
              size: 40,
            ),
            //make shop name center
            //make icon
            sectionBufferWidth(
              bufferSection: width * 0.29,
            ),
            Align(
              // text not fully height
              alignment: Alignment.center,
              child: FittedBox(
                // text

                fit: BoxFit.fitHeight,
                child: Text(
                  "Cafe Cup",
                  style: GoogleFonts.pacifico(
                    textStyle: kfont32_400(),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                ),
              ),
            ),
            //make icon
          ],
        ));
  }

  //make shoptextformfield()

  Widget shopTextFieldForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        color: backgroundActiveButton,
        border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        width: double.infinity,
        height: 50,
        decoration: kdecorationForContainerApplication,
        //Hide underline textfiled
        child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "SEARCH_HERE".tr(),
                prefixIcon: Icon(
                  IconlyLight.search,
                ))),
        //make search icon
      ),
    );
  }
}
