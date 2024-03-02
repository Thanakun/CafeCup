import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_application/data/widget/button_selection_animate.dart';
import 'package:coffee_application/data/widget/dropdown_button_search_list.dart';
import 'package:coffee_application/provider/customer-provider.dart';
import 'package:coffee_application/provider/shop_provider.dart';
import 'package:coffee_application/screen/customer_register_third_view.dart';
import 'package:coffee_application/screen/shop_register/shop_register_third_view.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/register_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomerRegisterSecond extends StatefulWidget {
  const CustomerRegisterSecond({super.key});

  @override
  State<CustomerRegisterSecond> createState() => _CustomerRegisterSecondState();
}

class _CustomerRegisterSecondState extends State<CustomerRegisterSecond> {
  List<Map<String, dynamic>> subDistricts = [
    {
      "id": 4156,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500101,
      "subdistrictNameEn": "Si Phum",
      "subdistrictNameTh": "ศรีภูมิ",
      "postalCode": 50200
    },
    {
      "id": 4157,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500102,
      "subdistrictNameEn": "Phra Sing",
      "subdistrictNameTh": "พระสิงห์",
      "postalCode": 50200
    },
    {
      "id": 4158,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500103,
      "subdistrictNameEn": "Hai Ya",
      "subdistrictNameTh": "หายยา",
      "postalCode": 50100
    },
    {
      "id": 4159,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500104,
      "subdistrictNameEn": "Chang Moi",
      "subdistrictNameTh": "ช้างม่อย",
      "postalCode": 50300
    },
    {
      "id": 4160,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500105,
      "subdistrictNameEn": "Chang Khlan",
      "subdistrictNameTh": "ช้างคลาน",
      "postalCode": 50100
    },
    {
      "id": 4161,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500106,
      "subdistrictNameEn": "Wat Ket",
      "subdistrictNameTh": "วัดเกต",
      "postalCode": 50000
    },
    {
      "id": 4162,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500107,
      "subdistrictNameEn": "Chang Phueak",
      "subdistrictNameTh": "ช้างเผือก",
      "postalCode": 50300
    },
    {
      "id": 4163,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500108,
      "subdistrictNameEn": "Su Thep",
      "subdistrictNameTh": "สุเทพ",
      "postalCode": 50200
    },
    {
      "id": 4164,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500109,
      "subdistrictNameEn": "Mae Hia",
      "subdistrictNameTh": "แม่เหียะ",
      "postalCode": 50100
    },
    {
      "id": 4165,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500110,
      "subdistrictNameEn": "Pa Daet",
      "subdistrictNameTh": "ป่าแดด",
      "postalCode": 50100
    },
    {
      "id": 4166,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500111,
      "subdistrictNameEn": "Nong Hoi",
      "subdistrictNameTh": "หนองหอย",
      "postalCode": 50000
    },
    {
      "id": 4167,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500112,
      "subdistrictNameEn": "Tha Sala",
      "subdistrictNameTh": "ท่าศาลา",
      "postalCode": 50000
    },
    {
      "id": 4168,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500113,
      "subdistrictNameEn": "Nong Pa Khrang",
      "subdistrictNameTh": "หนองป่าครั่ง",
      "postalCode": 50000
    },
    {
      "id": 4169,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500114,
      "subdistrictNameEn": "Fa Ham",
      "subdistrictNameTh": "ฟ้าฮ่าม",
      "postalCode": 50000
    },
    {
      "id": 4170,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500115,
      "subdistrictNameEn": "Pa Tan",
      "subdistrictNameTh": "ป่าตัน",
      "postalCode": 50300
    },
    {
      "id": 4171,
      "provinceCode": 50,
      "districtCode": 5001,
      "subdistrictCode": 500116,
      "subdistrictNameEn": "San Phisuea",
      "subdistrictNameTh": "สันผีเสื้อ",
      "postalCode": 50300
    },
  ];

  List<Map<String, dynamic>> priceRange = [
    {
      "id": 1,
      "labelEn": "Cheap",
      "labelTh": "ย่อยเยา",
      "Description": "ราคาน้อยกว่า 60 บาท"
    },
    {
      "id": 2,
      "labelEn": "Medium",
      "labelTh": "ปานกลาง",
      "Description": "ราคาประมาณ 60 - 80 บาท"
    },
    {
      "id": 3,
      "labelEn": "High",
      "labelTh": "สูง",
      "Description": "ราคามากกว่า 80 บาท"
    },
  ];

  List<Map<String, dynamic>> timeList = [
    {
      "id": 1,
      "labelEn": "Early MORNING",
      "labelTh": "เช้าตรู่",
      "Description": "เปิดร้านประมาณ 04:00 - 08:00"
    },
    {
      "id": 2,
      "labelEn": "Morning",
      "labelTh": "เช้าสาย",
      "Description": "เปิดร้านประมาณ 9:00 - 10:00"
    },
    {
      "id": 3,
      "labelEn": "Afternoon",
      "labelTh": "เที่ยงบ่าย",
      "Description": "เปิดร้านประมาณ 11:00 - 12:00"
    },
    {
      "id": 4,
      "labelEn": "Evening",
      "labelTh": "เย็นค่ำ",
      "Description": "เปิดร้านประมาณ 13:00 - 15:00"
    },
    {
      "id": 5,
      "labelEn": "Night",
      "labelTh": "กลางคืน",
      "Description": "เปิดร้านประมาณ 19:00 - 23:00"
    },
  ];

  List<Map<String, dynamic>> shopSize = [
    {
      "id": 1,
      "labelEn": "Small",
      "labelTh": "เล็ก",
      "Description": "ไม่แออัดมีน้อยกว่า 10 ที่"
    },
    {
      "id": 2,
      "labelEn": "Large",
      "labelTh": "ใหญ่",
      "Description": "ที่นั่งมีมากกว่า 10 ที่"
    },
  ];

  List<Map<String, dynamic>> sounds = [
    {
      "id": 1,
      "labelEn": "Quiet",
      "labelTh": "เงียบ",
      "Description": "เงียบสงบ คนไม่ชุกชุม"
    },
    {
      "id": 2,
      "labelEn": "Normal",
      "labelTh": "ใช้เสียงได้",
      "Description": "มีเสียงบ้าง ไม่เงียบเหงา"
    },
  ];

  List<Map<String, dynamic>> customerGroups = [
    {
      "id": 1,
      "labelEn": "Student / Collegian",
      "labelTh": "นักเรียน / นักศึกษา",
      "Description": "นักเรียน / นักศึกษา หาที่อ่านหนังสือ"
    },
    {
      "id": 2,
      "labelEn": "Office worker",
      "labelTh": "พนักงานออฟฟิศ",
      "Description": "พนักงานออฟฟิศจิบกาแฟ ทำงานบางครั้ง"
    },
    {
      "id": 3,
      "labelEn": "Tourist",
      "labelTh": "นักท่องเที่ยว",
      "Description": "นักท่องเที่ยว ถ่ายรูป สร้างคอนเทนต์กัน"
    },
    {
      "id": 4,
      "labelEn": "Digital nomad",
      "labelTh": "ดิจิทอล โนแมด",
      "Description": "นั่งแช่ ทำงาน WFH"
    },
    {
      "id": 5,
      "labelEn": "Take away",
      "labelTh": "ซื้อกลับบ้าน",
      "Description": "ซื้อกลับ + Rider จากแอปต่างๆ"
    },
  ];

  TextEditingController subdistrictController = TextEditingController();
  TextEditingController priceRangeController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController shopSizeController = TextEditingController();
  TextEditingController soundController = TextEditingController();
  TextEditingController customerGroupController = TextEditingController();

  String? selectedSubDistrict;
  String? selectedPriceRange;
  String? selectedTime;
  String? selectedShopSize;
  String? selectedSound;
  String? selectedCustomerGroup;

  final Map<String, String> _tags = {
    "1": "Location",
    "2": "Price range",
    "3": "Time",
    "4": "Shop size",
    "5": "Sound",
    "6": "Customer group",
  };

  List<Map<String, String>> orderSelectedTags = [];

  final CarouselController _controller = CarouselController();
  int _current = 1;

  late RegisterVM registerVM;

  @override
  void initState() {
    super.initState();
    registerVM = RegisterVM(
      customerProvider: context.read<CustomerProvider>(),
      shopProvider: context.read<ShopProvider>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(255, 245, 233, 1),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: width,
                  height: height,
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          child: headerContainer(
                            header: tr('CUSTOMER_REGISTER.HEADER_TAGS'),
                          )),
                      sectionBufferHeight(bufferSection: 30),
                      Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Container(
                          width: double.infinity,
                          // height:,
                          margin: EdgeInsets.symmetric(
                              horizontal: width * 0.07281,
                              vertical: height * 0.0163),
                          child: ReorderableListView.builder(
                            buildDefaultDragHandles: false,
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final item =
                                    orderSelectedTags.removeAt(oldIndex);
                                orderSelectedTags.insert(newIndex, item);
                              });
                            },
                            shrinkWrap: true,
                            itemCount: orderSelectedTags.length,
                            itemBuilder: (context, index) {
                              final item = orderSelectedTags[index];
                              return Dismissible(
                                key: ValueKey(item),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  setState(() {
                                    orderSelectedTags.removeAt(index);
                                  });
                                },
                                background: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        backgroundActiveButton,
                                        Colors.red,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  child: const Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 10,
                                  ),
                                  margin: const EdgeInsets.only(bottom: 5),
                                  decoration: kdecorationForContainerActiveItem,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration:
                                            kdecorationForContainerActiveBeingSelected,
                                        child: Center(
                                            child: Text(
                                          (index + 1).toString(),
                                          style: kfontH0InterWhiteColor(),
                                        )),
                                      ),
                                      sectionBufferWidth(bufferSection: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 150,
                                            child: Text(
                                              item["value"].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: kfont22w_400black(),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            child: Text(
                                              _tags[item["key"]].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: kfontH3InterBlackColor(),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      ReorderableDragStartListener(
                                        key: ValueKey(item),
                                        index: index,
                                        child: Container(
                                          height: 100,
                                          width: 50,
                                          // color: Colors.red,
                                          child: const Icon(
                                            Icons.reorder_outlined,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      sectionBufferHeight(bufferSection: 100),
                      Container(
                        width: double.infinity,
                        height: 100,

                        // margin:
                        //     const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: CarouselSlider(
                          carouselController: _controller,
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: 100,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.44,
                            initialPage: 0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = int.parse(
                                    _tags.entries.elementAt(index).key);
                              });
                            },
                          ),
                          items: _tags.entries
                              .map((MapEntry<String, String> entry) {
                            return AnimatedContainer(
                              duration: const Duration(microseconds: 300),
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 15),
                              child: ButtonSelectionAnimation(
                                  onTap: () {
                                    setState(() {
                                      setState(() {
                                        switch (entry.key) {
                                          case "1":
                                            showModal(
                                              context: context,
                                              height: height,
                                              entry: entry,
                                              width: width,
                                              valueToShow: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "subdistrictNameTh"
                                                  : "subdistrictNameEn",
                                              textInDropdown: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "subdistrictNameTh"
                                                  : "subdistrictNameEn",
                                              listItem: subDistricts,
                                              selectedItem: selectedSubDistrict,
                                              selectedController:
                                                  subdistrictController,
                                            ).whenComplete(() =>
                                                selectedSubDistrict = null);
                                            break;
                                          case "2":
                                            showModal(
                                              context: context,
                                              height: height,
                                              entry: entry,
                                              width: width,
                                              valueToShow: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "labelTh"
                                                  : "labelEn",
                                              textInDropdown: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "labelTh"
                                                  : "labelEn",
                                              listItem: priceRange,
                                              selectedItem: selectedPriceRange,
                                              selectedController:
                                                  priceRangeController,
                                            ).whenComplete(() =>
                                                selectedPriceRange = null);
                                            break;
                                          case "3":
                                            showModal(
                                              context: context,
                                              height: height,
                                              entry: entry,
                                              width: width,
                                              valueToShow: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "labelTh"
                                                  : "labelEn",
                                              textInDropdown: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "labelTh"
                                                  : "labelEn",
                                              listItem: timeList,
                                              selectedItem: selectedTime,
                                              selectedController:
                                                  timeController,
                                            ).whenComplete(
                                                () => selectedTime = null);
                                            break;
                                          case "4":
                                            showModal(
                                              context: context,
                                              height: height,
                                              entry: entry,
                                              width: width,
                                              valueToShow: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "labelTh"
                                                  : "labelEn",
                                              textInDropdown: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "labelTh"
                                                  : "labelEn",
                                              listItem: shopSize,
                                              selectedItem: selectedShopSize,
                                              selectedController:
                                                  shopSizeController,
                                            ).whenComplete(
                                                () => selectedShopSize = null);
                                            break;
                                          case "5":
                                            showModal(
                                              context: context,
                                              height: height,
                                              entry: entry,
                                              width: width,
                                              valueToShow: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "labelTh"
                                                  : "labelEn",
                                              textInDropdown: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "labelTh"
                                                  : "labelEn",
                                              listItem: sounds,
                                              selectedItem: selectedSound,
                                              selectedController:
                                                  soundController,
                                            ).whenComplete(
                                                () => selectedSound = null);
                                            break;
                                          case "6":
                                            showModal(
                                              context: context,
                                              height: height,
                                              entry: entry,
                                              width: width,
                                              valueToShow: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "labelTh"
                                                  : "labelEn",
                                              textInDropdown: Localizations
                                                          .localeOf(context) ==
                                                      const Locale('th', 'TH')
                                                  ? "labelTh"
                                                  : "labelEn",
                                              listItem: customerGroups,
                                              selectedItem:
                                                  selectedCustomerGroup,
                                              selectedController:
                                                  customerGroupController,
                                            ).whenComplete(() =>
                                                selectedCustomerGroup = null);
                                            break;
                                          default:
                                          // Default case or do nothing for other cases
                                        }
                                      });
                                    });
                                  },
                                  isButtonPressed: orderSelectedTags.any(
                                    (element) => element["key"] == entry.key,
                                  ),
                                  nameButton: entry.value),
                            );
                          }).toList(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _tags.entries.map((entry) {
                          return AnimatedContainer(
                            curve: Curves.decelerate,
                            duration: const Duration(milliseconds: 300),
                            width: _current == int.parse(entry.key) ? 36 : 12,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : brownBorderButton)
                                  .withOpacity(_current == int.parse(entry.key)
                                      ? 0.9
                                      : 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (orderSelectedTags.isEmpty) {
                                Utility.toastMessage(
                                    "ERROR_MESSAGE.PLEASE_SELECT_ITEM".tr());
                                return;
                              } else if (orderSelectedTags.length < 3) {
                                Utility.toastMessage(
                                    "ERROR_MESSAGE.PICK_ONLY_THREE_ITEM".tr());
                              }

                              registerVM
                                  .onCustomerAddAllTags(orderSelectedTags);
                              // registerVM.signUpThirdPage(
                              //     tags: orderSelectedTags, favorites: []);
                              registerVM.signUp(
                                  shop: context.read<ShopProvider>().shop,
                                  customer:
                                      context.read<CustomerProvider>().customer,
                                  userType: registerVM.userType);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomerRegisterThird()));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              width: width / 1.7,
                              height: constraints.maxHeight * 0.07,
                              decoration: const BoxDecoration(
                                  color: kcolorAcceptButton,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Center(
                                child: Text(
                                  tr("CUSTOMER_REGISTER.CONFIRM_BUTTON"),
                                  style: kfontH1InterBoldBlackColor(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showModal(
      {required BuildContext context,
      required double height,
      required MapEntry<String, String> entry,
      required double width,
      required String valueToShow,
      required String textInDropdown,
      required String? selectedItem,
      required TextEditingController selectedController,
      required List<Map<String, dynamic>> listItem}) {
    return showModalBottomSheet(
      elevation: 1,
      context: context,
      builder: (modalContext) {
        return StatefulBuilder(
          builder: (modalContext, StateSetter modalSetState) {
            return Container(
              padding: const EdgeInsets.all(24),
              height: height / 2,
              decoration: kdecorationForContainerActiveItem,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    entry.value,
                    style: kfontH0InterBlackColor(),
                  ),
                  sectionBufferHeight(bufferSection: 24),
                  DropDownSearchListWidget(
                      isEnableSearch: false,
                      width: width,
                      height: height,
                      header: entry.value,
                      listOfItem: listItem.map((item) {
                        return DropdownMenuItem<String>(
                          value: item[
                              valueToShow], // or any other key you want to use
                          child: Text(item[textInDropdown]),
                        );
                      }).toList(),
                      selectedItem: selectedItem,
                      searchTextMenuList: selectedController,
                      onSelectMenuItem: (value) {
                        modalSetState(() {
                          selectedItem = value;
                        });
                      }),
                  sectionBufferHeight(bufferSection: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: kdecorationForContainerApplication,
                    child: Text(
                      listItem
                              .where((element) =>
                                  element[valueToShow] == selectedItem)
                              .isEmpty
                          ? (Localizations.localeOf(context) ==
                                  const Locale('th', 'TH')
                              ? "คุณสนใจที่จะค้นหาร้านกาแฟตำบล  \n ${selectedItem ?? "ไหนดีจ๊ะ"}"
                              : "You interested in subdistrict  \n ${selectedItem ?? "where else ?"}")
                          : listItem.firstWhere(
                                (element) =>
                                    element[valueToShow] == selectedItem,
                                orElse: () => {
                                  "Description": null
                                }, // Default value if not found
                              )["Description"] ??
                              (Localizations.localeOf(context) ==
                                      const Locale('th', 'TH')
                                  ? "คุณสนใจที่จะค้นหาร้านกาแฟตำบล  \n ${selectedItem ?? "ไหนดีจ๊ะ"}"
                                  : "You interested in subdistrict  \n ${selectedItem ?? "where else ?"}"),
                      style: kfont26_400(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            orderSelectedTags.removeWhere(
                                (element) => element['key'] == entry.key);
                            modalSetState(() {
                              Navigator.pop(modalContext);
                            });
                          });
                        },
                        child: Container(
                          decoration:
                              kdecorationForContainerActiveBeingSelected,
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            tr("CUSTOMER_REGISTER.DELETE_TAGS_BUTTON"),
                            style: kfontH0InterWhiteColor(),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(
                            () {
                              String _selectedTags = "";
                              if (entry.key != "1") {
                                switch (selectedItem) {
                                  case "นักเรียน / นักศึกษา":
                                    _selectedTags = "STUDENT";
                                    break;
                                  case "พนักงานออฟฟิศ":
                                    _selectedTags = "OFFICE_WORKER";
                                    break;
                                  case "นักท่องเที่ยว":
                                    _selectedTags = "TOURIST";
                                    break;

                                  case "ดิจิทอล โนแมด":
                                    _selectedTags = "DIGITAL_NORMAD";
                                    break;

                                  case "ซื้อกลับบ้าน":
                                    _selectedTags = "TAKEAWAY";
                                    break;
                                  case "เงียบ":
                                    _selectedTags = "QUITE";
                                    break;
                                  case "ใช้เสียงได้":
                                    _selectedTags = "NORMAL";
                                    break;
                                  case "เล็ก":
                                    _selectedTags = "SMALL";
                                    break;
                                  case "ใหญ่":
                                    _selectedTags = "LARGE";
                                    break;
                                  case "เช้าตรู่":
                                    _selectedTags = "EARLYMORNING";
                                    break;
                                  case "เช้าสาย":
                                    _selectedTags = "MORNING";
                                    break;
                                  case "เที่ยงบ่าย":
                                    _selectedTags = "AFTERNOON";
                                    break;
                                  case "เย็นค่ำ":
                                    _selectedTags = "EVENING";
                                    break;
                                  case "กลางคืน":
                                    _selectedTags = "NIGHT";
                                    break;
                                  case "ย่อมเยา":
                                    _selectedTags = "CHEAP";
                                    break;
                                  case "ปานกลาง":
                                    _selectedTags = "MEDIUM";
                                    break;
                                  case "สูง":
                                    _selectedTags = "HIGH";
                                    break;
                                  default:
                                    break;
                                }
                                if (selectedItem != null &&
                                    orderSelectedTags.length < 3) {
                                  orderSelectedTags.add({
                                    "key": entry.key,
                                    "value": _selectedTags
                                  });

                                  modalSetState(() {
                                    Navigator.pop(modalContext);
                                  });
                                  Utility.flushBarGrantedMessage(
                                      message: "Added", context: context);
                                } else if (selectedItem == null) {
                                  Utility.toastMessage(
                                    "ERROR_MESSAGE.PLEASE_ENTER_VALUE".tr(),
                                  );
                                } else if (orderSelectedTags.length >= 3) {
                                  Utility.toastMessage(
                                    "ERROR_MESSAGE.PICK_ONLY_THREE_ITEM".tr(),
                                  );
                                }
                              } else {
                                if (selectedItem != null &&
                                    orderSelectedTags.length < 3) {
                                  orderSelectedTags.add({
                                    "key": entry.key,
                                    "value": selectedItem!
                                  });

                                  modalSetState(() {
                                    Navigator.pop(modalContext);
                                  });
                                  Utility.flushBarGrantedMessage(
                                      message: "Added", context: context);
                                } else if (selectedItem == null) {
                                  Utility.toastMessage(
                                    "ERROR_MESSAGE.PLEASE_ENTER_VALUE".tr(),
                                  );
                                } else if (orderSelectedTags.length >= 3) {
                                  Utility.toastMessage(
                                    "ERROR_MESSAGE.PICK_ONLY_THREE_ITEM".tr(),
                                  );
                                }
                              }
                            },
                          );
                        },
                        child: Container(
                          decoration: orderSelectedTags.length >= 3
                              ? kdecorationForContainerDisabled
                              : kdecorationForContainerAcceptButton,
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 60, right: 60),
                          child: Text(
                            "CUSTOMER_REGISTER.ADD_TAGS_BUTTON".tr(),
                            style: kfontH0InterWhiteColor(),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
