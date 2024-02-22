import 'package:coffee_application/screen/my_component/bottom_navigationbar_customer.dart';
import 'package:coffee_application/screen/search_result_list_shop_view.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomerSearchView extends StatefulWidget {
  const CustomerSearchView({super.key});

  @override
  State<CustomerSearchView> createState() => _CustomerSearchViewState();
}

class _CustomerSearchViewState extends State<CustomerSearchView> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  List<String> _searchHistoryList = [
    "คาปูชิโน่",
    "ลาเต้",
    "คาราเมล",
    "คาปูชิโน่ 2",
    "ลาเต้ 2",
    "คาราเมล 2",
    "คาปูชิโน่ 2",
    "ลาเต้ 2",
    "คาราเมล 2"
  ];

  List<String> _searchKeyWordSuggest = ["มีที่นั่ง", "ปลั๊ก", "ของเล่น"];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            toolbarHeight: height * 0.08,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: backGroundApplication,
            centerTitle: true,
            title: _searchBar(),
            leading: Container(
              margin: EdgeInsets.only(left: width * 0.03),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      size: 40, color: Colors.black),
                  onPressed: () {
                    //POP
                    Navigator.pop(context);
                  }),
            )),
        bottomNavigationBar: const CustomerNavigationBar(
          pageName: "HOME",
        ),
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundCustomerImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(
                  top: height * 0.03, left: width * 0.07, right: width * 0.07),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _headerSearch(
                      header: "SEARCH_HISTORY".tr(),
                    ),
                    sectionBufferHeight(bufferSection: 16),
                    _searchListWarp(
                        width: width,
                        height: height,
                        searchKeywordList: _searchHistoryList),
                    sectionBufferHeight(bufferSection: 16),
                    _headerSearch(
                      header: "SEARCH_SUGGEST".tr(),
                    ),
                    sectionBufferHeight(bufferSection: 16),
                    _searchListWarp(
                        width: width,
                        height: height,
                        searchKeywordList: _searchKeyWordSuggest),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Wrap _searchListWarp({
    required double width,
    required double height,
    required List<String> searchKeywordList,
  }) {
    return Wrap(
      spacing: width * 0.03,
      runSpacing: width * 0.03,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: searchKeywordList
          .map((e) => _buttonWordSearchText(
              context: context, width: width, height: height, word: e))
          .toList(),
    );
  }

  Container _headerSearch({required String header}) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        header,
        style: kfont26Bold_400(),
      ),
    );
  }

  InkWell _buttonWordSearchText(
      {required BuildContext context,
      required double width,
      required double height,
      required String word}) {
    return InkWell(
      onTap: () {
        setState(() {
          searchController.text = word;
          FocusScope.of(context).requestFocus(searchFocusNode);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.004),
        decoration: kdecorationForContainerSelectSearchBox,
        child: Text(
          word,
          style: kfontH2InterBoldBlackColor(),
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
      // margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchResultView(
                  search: value,
                )
              )
            );
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
                //Go to search Result View
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchResultView(
                      search: searchController.text,
                    ),
                  ),
                );
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
}
