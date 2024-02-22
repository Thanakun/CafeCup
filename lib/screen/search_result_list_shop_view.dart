import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/screen/customer_shop_view.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/search_view_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchResultView extends StatefulWidget {
  const SearchResultView({Key? key, required this.search}) : super(key: key);

  final String search;

  @override
  State<SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  final _scrollController = ScrollController();

  String selectCustomerGroup = "";
  String selectNoise = "";
  final _list = <String>[];
  int _currentPage = 1;

  SearchCustomerVM _vm = SearchCustomerVM();

  final Map<String, bool> _filterStringList = {
    // "price": false,
    // "facilities": false,
    // "timeOpen": false,
    "singleSeat": false,
    "doubleSeat": false,
    "largeSeat": false,
    "wifi": false,
    "powerPlugs": false,
    "conferenceRoom": false,
  };

  final Map<String, bool> _filterCustomerList = {
    "STUDENT": false,
    "OFFICE_WORKER": false,
    "TOURIST": false,
    "DIGITAL_NOMAD": false,
    "TAKEAWAY": false,
  };

  final Map<String, bool> _filterNoiseList = {
    "QUITE": false,
    "NORMAL": false,
  };

  @override
  void initState() {
    super.initState();
    searchController.text = widget.search;
    _scrollController.addListener(_loadMore);
    _vm = SearchCustomerVM();
    _vm.onUserSearchByNameAndFilterShop(searchController.text);
    // _fetchData(_currentPage);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      // _fetchData(_currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundCustomerImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: backGroundApplication,
                  toolbarHeight: height * 0.08,
                  elevation: 0,
                  leading: Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.black, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  pinned: true,
                  title: _searchBar(),
                  bottom: PreferredSize(
                    preferredSize: height * 0.1 > 50
                        ? const Size.fromHeight(50)
                        : Size.fromHeight(height * 0.1),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  selectCustomerGroup != "" ||
                                          selectNoise != "" ||
                                          _vm.filterMapList.isNotEmpty
                                      ? (setState(() {
                                          selectCustomerGroup = "";
                                          selectNoise = "";
                                          _vm.onUserClearFilter();
                                          _filterStringList
                                              .forEach((key, value) {
                                            _filterStringList[key] = false;
                                          });
                                          _filterCustomerList
                                              .forEach((key, value) {
                                            _filterCustomerList[key] = false;
                                          });
                                          _filterNoiseList
                                              .forEach((key, value) {
                                            _filterNoiseList[key] = false;
                                          });
                                          _vm.onUserSearchByNameAndFilterShop(
                                              searchController.text);
                                        }))
                                      : () {};
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: EdgeInsets.only(left: width * 0.02),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.05,
                                    vertical: height * 0.01,
                                  ),
                                  height: height * 0.04,
                                  decoration: selectCustomerGroup != "" ||
                                          selectNoise != "" ||
                                          _vm.filterMapList.isNotEmpty
                                      ? kdecorationForContainerButton
                                      : kdecorationForContainerbuttonSelectedSearchResultView,
                                  child: selectCustomerGroup != "" ||
                                          selectNoise != "" ||
                                          _vm.filterMapList.isNotEmpty
                                      ? Icon(
                                          Icons.clear_outlined,
                                          size: height * 0.025,
                                        )
                                      : const Icon(Icons.settings_outlined),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: width * 0.02),
                                  height: height * 0.04,
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      ..._filterStringList.entries
                                          .map(
                                            (MapEntry<String, bool> entry) =>
                                                _selectFilterMutipleSection(
                                              width: width,
                                              height: height,
                                              filterText: entry.key,
                                              isSelected: entry.value,
                                              onTap: () {
                                                setState(() {
                                                  _filterStringList[entry.key] =
                                                      !entry.value;
                                                  if (_filterStringList[
                                                      entry.key]!) {
                                                    _vm.onUserTapAddFilter(
                                                        filter: entry.key);
                                                  } else {
                                                    _vm.onUserTapRemoveFilter(
                                                        filter: entry.key);
                                                  }
                                                  _vm.onUserSearchByNameAndFilterShop(
                                                      searchController.text);
                                                });
                                              },
                                            ),
                                          )
                                          .toList(),
                                      _buildFilterCustomerGroups(width, height),
                                      _buildFilterNoiseGroups(width, height)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      FutureBuilder<List<ShopModel>>(
                        future: _vm.listAllFilterShop,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              "ERROR_MESSAGE.ERROR_LOADING_FAIL".tr(),
                              style: kfontH1InterBoldBlackColor(),
                            );
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              !snapshot.hasError) {
                            // Replace the comment with the appropriate code

                            if (snapshot.data!.isEmpty) {
                              return Text(
                                "ERROR_MESSAGE.EMPTY_DATA".tr(),
                                style: kfontH1InterBoldBlackColor(),
                              );
                            }
                            List<ShopModel> shopsList = snapshot.data!;
                            return Column(
                                children: shopsList.map((shop) {
                              return _shopCard(
                                width: width,
                                height: height,
                                onTapShopCard: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustomerShopView(
                                        shopId: shop.iId!,
                                      ),
                                    ),
                                  );
                                },
                                shop: shop,
                              );
                            }).toList());
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _shopCard({
    required double width,
    required double height,
    required Function() onTapShopCard,
    required ShopModel shop,
  }) {
    return GestureDetector(
      onTap: onTapShopCard,
      child: Container(
        width: width,
        height: height * 0.13,
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.005,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5),
              // changes position of shadow
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: constraints.maxWidth * 0.32,
                height: height * 0.13,
                margin: EdgeInsets.only(right: constraints.maxWidth * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    onError: (error, stackTrace) {
                      const AssetImage(imageNotFound);
                    },
                    scale: 2,
                    fit: BoxFit.cover,
                    image: const AssetImage(shopCoverImagePath),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.2,
                          child: Text(
                            shop.name ?? "",
                            // "shop.name!",
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kfontH1InterBoldBlackColor(),
                          ),
                        ),
                        sectionBufferWidth(
                            bufferSection: width * 0.1),
                        Icon(
                          Icons.star,
                          size: constraints.maxWidth * 0.05,
                          color: Colors.amber,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: FittedBox(
                                  child: Text(
                                    "4.7 (5000)",
                                    style: kfontH2InterBoldBlackColor(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: constraints.maxWidth *
                          0.5, // Adjust the width as needed
                      child: Text(
                        "\$\$\$ ${shop.wifi! ? "• Wifi" : ""} • ${shop.noice} ${shop.conferenceRoom! ? "• มีห้องประชุม" : ""} ${shop.powerPlugs! ? "• ปลั๊ก" : ""} ${shop.smokingZone! ? "• สูบบุหรี่" : ""} ${shop.toilet! ? "• ห้องน้ำ" : ""}",

                        // Add your shop details here
                        softWrap: true,
                        style: kfontH2InterBoldBlackColor(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * 0.6,
                      padding:
                          EdgeInsets.only(right: constraints.maxWidth * 0.1),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: constraints.maxHeight * 0.15,
                            color: Colors.black,
                          ),
                          Flexible(
                            child: Text(
                              //TODO SHOP OPEN TIME
                              shop.timeOpen!,
                              // "shop.timeOpen!",
                              style: kfontH2InterBoldBlackColor(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              //TODO SHOP CLOSE TIME

                              " - ${shop.timeClose!}",
                              style: kfontH2InterBoldBlackColor(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  InkWell _selectFilterNoiseGroup(
      {required double width,
      required double height,
      required String filterText,
      required bool isSelected,
      required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: width * 0.02),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.005),
        height: height * 0.04,
        decoration: isSelected
            ? kdecorationButtonSelectedOrange
            : kdecorationButtonUnSelectedOrange,
        child: FittedBox(
          child: Text(
            "CUSTOMER_SEARCH_RESULT.$filterText".tr(),
            style: kfont22w_400black(),
          ),
        ),
      ),
    );
  }

  InkWell _selectFilterCustomerGroup(
      {required double width,
      required double height,
      required String filterText,
      required bool isSelected,
      required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: width * 0.02),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.005),
        height: height * 0.04,
        decoration: isSelected
            ? kdecorationForContainerActiveBeingSelected
            : kdecorationForContainerBackButton,
        child: FittedBox(
          child: Text(
            "CUSTOMER_SEARCH_RESULT.$filterText".tr(),
            style: kfont22w_400black(),
          ),
        ),
      ),
    );
  }

  InkWell _selectFilterMutipleSection(
      {required double width,
      required double height,
      required String filterText,
      required bool isSelected,
      required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: width * 0.02),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.005),
        height: height * 0.04,
        decoration: isSelected
            ? kdecorationForContainerbuttonSelectedSearchResultView
            : kdecorationForContainerSelectSearchBox,
        child: FittedBox(
          child: Text(
            "CUSTOMER_SEARCH_RESULT.$filterText".tr(),
            style: kfont22w_400black(),
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: TextFormField(
          onFieldSubmitted: (value) {
            //Go to search Result View
            setState(() {
              _vm.onUserSearchByNameAndFilterShop(value);
            });
          },
          focusNode: searchFocusNode,
          textInputAction: TextInputAction.go,
          controller: searchController,
          style: kfontH1Inter_400BlackColor(),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search for cafe",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _vm.onUserSearchByNameAndFilterShop(searchController.text);
                });
                //Go to search Result View
              },
              icon: const Icon(Icons.search),
              iconSize: 30,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterCustomerGroups(double width, double height) {
    return Row(
      children: _filterCustomerList.entries.map(
        (MapEntry<String, bool> entry) {
          return _selectFilterCustomerGroup(
            width: width,
            height: height,
            filterText: entry.key,
            isSelected: entry.value,
            onTap: () {
              setState(
                () {
                  selectCustomerGroup = entry.key;

                  // Toggle the selected filter
                  _filterCustomerList[selectCustomerGroup] =
                      !_filterCustomerList[selectCustomerGroup]!;

                  // Clear other filters
                  for (var otherEntry in _filterCustomerList.entries) {
                    if (otherEntry.key != selectCustomerGroup) {
                      _filterCustomerList[otherEntry.key] = false;
                      _vm.onUserTapRemoveFilter(filter: otherEntry.key);
                    }
                  }

                  // If the selected filter is active, add it; otherwise, remove it
                  if (_filterCustomerList[selectCustomerGroup]!) {
                    _vm.onUserTapAddFilter(filter: selectCustomerGroup);
                  } else {
                    _vm.onUserTapRemoveFilter(filter: selectCustomerGroup);
                  }

                  // Perform search with the selected filter
                  _vm.onUserSearchByNameAndFilterShop(searchController.text);
                },
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildFilterNoiseGroups(double width, double height) {
    return Row(
      children: _filterNoiseList.entries.map(
        (MapEntry<String, bool> entry) {
          return _selectFilterNoiseGroup(
            width: width,
            height: height,
            filterText: entry.key,
            isSelected: entry.value,
            onTap: () {
              setState(() {
                selectNoise = entry.key;

                // Toggle the selected filter
                _filterNoiseList[selectNoise] = !_filterNoiseList[selectNoise]!;

                // Clear other filters
                for (var otherEntry in _filterNoiseList.entries) {
                  if (otherEntry.key != selectNoise) {
                    _filterNoiseList[otherEntry.key] = false;
                    _vm.onUserTapRemoveFilter(filter: otherEntry.key);
                  }
                }

                // If the selected filter is active, add it; otherwise, remove it
                if (_filterNoiseList[selectNoise]!) {
                  _vm.onUserTapAddFilter(filter: selectNoise);
                } else {
                  _vm.onUserTapRemoveFilter(filter: selectNoise);
                }

                // Perform search with the selected filter
                _vm.onUserSearchByNameAndFilterShop(searchController.text);
              });
            },
          );
        },
      ).toList(),
    );
  }
}
