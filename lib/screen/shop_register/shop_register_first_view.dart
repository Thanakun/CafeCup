import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/screen/my_component/shop_register_statusbar.dart';
import 'package:coffee_application/screen/shop_register/shop_register_second_view.dart';
import 'package:coffee_application/screen/shop_text_field_form.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/register_view_model.dart';

class ShopRegisterView extends StatefulWidget {
  const ShopRegisterView({required this.id, super.key});
  final int id;

  @override
  State<ShopRegisterView> createState() => _ShopRegisterViewState();
}

class _ShopRegisterViewState extends State<ShopRegisterView> {
  final TextEditingController nameShop = TextEditingController();
  final TextEditingController descriptionShop = TextEditingController();
  final TextEditingController addressDetail = TextEditingController();
  final TextEditingController searchTextMenuList = TextEditingController();

  late RegisterVM _vm;

  String? selectedProvince;
  String? selectedDistrict;
  String? selectedSubDistrict;

  List<Map<String, dynamic>> provinces = [
    {
      "id": 39,
      "provinceCode": 50,
      "provinceNameEn": "Chiang Mai",
      "provinceNameTh": "เชียงใหม่"
    },
  ];

  List<Map<String, dynamic>> district = [
    {
      "id": 520,
      "provinceCode": 50,
      "districtCode": 5001,
      "districtNameEn": "Mueang Chiang Mai",
      "districtNameTh": "เมืองเชียงใหม่",
      "postalCode": 50200
    },
    {
      "id": 521,
      "provinceCode": 50,
      "districtCode": 5002,
      "districtNameEn": "Chom Thong",
      "districtNameTh": "จอมทอง",
      "postalCode": 50160
    },
    {
      "id": 522,
      "provinceCode": 50,
      "districtCode": 5003,
      "districtNameEn": "Mae Chaem",
      "districtNameTh": "แม่แจ่ม",
      "postalCode": 50270
    },
    {
      "id": 523,
      "provinceCode": 50,
      "districtCode": 5004,
      "districtNameEn": "Chiang Dao",
      "districtNameTh": "เชียงดาว",
      "postalCode": 50170
    },
    {
      "id": 524,
      "provinceCode": 50,
      "districtCode": 5005,
      "districtNameEn": "Doi Saket",
      "districtNameTh": "ดอยสะเก็ด",
      "postalCode": 50220
    },
    {
      "id": 525,
      "provinceCode": 50,
      "districtCode": 5006,
      "districtNameEn": "Mae Taeng",
      "districtNameTh": "แม่แตง",
      "postalCode": 50150
    },
    {
      "id": 526,
      "provinceCode": 50,
      "districtCode": 5007,
      "districtNameEn": "Mae Rim",
      "districtNameTh": "แม่ริม",
      "postalCode": 50180
    },
    {
      "id": 527,
      "provinceCode": 50,
      "districtCode": 5008,
      "districtNameEn": "Samoeng",
      "districtNameTh": "สะเมิง",
      "postalCode": 50250
    },
    {
      "id": 528,
      "provinceCode": 50,
      "districtCode": 5009,
      "districtNameEn": "Fang",
      "districtNameTh": "ฝาง",
      "postalCode": 50110
    },
    {
      "id": 529,
      "provinceCode": 50,
      "districtCode": 5010,
      "districtNameEn": "Mae Ai",
      "districtNameTh": "แม่อาย",
      "postalCode": 50280
    },
    {
      "id": 530,
      "provinceCode": 50,
      "districtCode": 5011,
      "districtNameEn": "Phrao",
      "districtNameTh": "พร้าว",
      "postalCode": 50190
    },
    {
      "id": 531,
      "provinceCode": 50,
      "districtCode": 5012,
      "districtNameEn": "San Pa Tong",
      "districtNameTh": "สันป่าตอง",
      "postalCode": 50120
    },
    {
      "id": 532,
      "provinceCode": 50,
      "districtCode": 5013,
      "districtNameEn": "San Kamphaeng",
      "districtNameTh": "สันกำแพง",
      "postalCode": 50130
    },
    {
      "id": 533,
      "provinceCode": 50,
      "districtCode": 5014,
      "districtNameEn": "San Sai",
      "districtNameTh": "สันทราย",
      "postalCode": 50210
    },
    {
      "id": 534,
      "provinceCode": 50,
      "districtCode": 5015,
      "districtNameEn": "Hang Dong",
      "districtNameTh": "หางดง",
      "postalCode": 50230
    },
    {
      "id": 535,
      "provinceCode": 50,
      "districtCode": 5016,
      "districtNameEn": "Hot",
      "districtNameTh": "ฮอด",
      "postalCode": 50240
    },
    {
      "id": 536,
      "provinceCode": 50,
      "districtCode": 5017,
      "districtNameEn": "Doi Tao",
      "districtNameTh": "ดอยเต่า",
      "postalCode": 50260
    },
    {
      "id": 537,
      "provinceCode": 50,
      "districtCode": 5018,
      "districtNameEn": "Omkoi",
      "districtNameTh": "อมก๋อย",
      "postalCode": 50310
    },
    {
      "id": 538,
      "provinceCode": 50,
      "districtCode": 5019,
      "districtNameEn": "Saraphi",
      "districtNameTh": "สารภี",
      "postalCode": 50140
    },
    {
      "id": 539,
      "provinceCode": 50,
      "districtCode": 5020,
      "districtNameEn": "Wiang Haeng",
      "districtNameTh": "เวียงแหง",
      "postalCode": 50350
    },
    {
      "id": 540,
      "provinceCode": 50,
      "districtCode": 5021,
      "districtNameEn": "Chai Prakan",
      "districtNameTh": "ไชยปราการ",
      "postalCode": 50320
    },
    {
      "id": 541,
      "provinceCode": 50,
      "districtCode": 5022,
      "districtNameEn": "Mae Wang",
      "districtNameTh": "แม่วาง",
      "postalCode": 50360
    },
    {
      "id": 542,
      "provinceCode": 50,
      "districtCode": 5023,
      "districtNameEn": "Mae On",
      "districtNameTh": "แม่ออน",
      "postalCode": 50130
    },
    {
      "id": 543,
      "provinceCode": 50,
      "districtCode": 5024,
      "districtNameEn": "Doi Lo",
      "districtNameTh": "ดอยหล่อ",
      "postalCode": 50160
    },
    {
      "id": 544,
      "provinceCode": 50,
      "districtCode": 5025,
      "districtNameEn": "Kanlayaniwatthana",
      "districtNameTh": "กัลยาณิวัฒนา",
      "postalCode": 58130
    }
  ];

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
    {
      "id": 4172,
      "provinceCode": 50,
      "districtCode": 5002,
      "subdistrictCode": 500203,
      "subdistrictNameEn": "Ban Luang",
      "subdistrictNameTh": "บ้านหลวง",
      "postalCode": 50160
    },
    {
      "id": 4173,
      "provinceCode": 50,
      "districtCode": 5002,
      "subdistrictCode": 500204,
      "subdistrictNameEn": "Khuang Pao",
      "subdistrictNameTh": "ข่วงเปา",
      "postalCode": 50160
    },
    {
      "id": 4174,
      "provinceCode": 50,
      "districtCode": 5002,
      "subdistrictCode": 500205,
      "subdistrictNameEn": "Sop Tia",
      "subdistrictNameTh": "สบเตี๊ยะ",
      "postalCode": 50160
    },
    {
      "id": 4175,
      "provinceCode": 50,
      "districtCode": 5002,
      "subdistrictCode": 500206,
      "subdistrictNameEn": "Ban Pae",
      "subdistrictNameTh": "บ้านแปะ",
      "postalCode": 50240
    },
    {
      "id": 4176,
      "provinceCode": 50,
      "districtCode": 5002,
      "subdistrictCode": 500207,
      "subdistrictNameEn": "Doi Kaeo",
      "subdistrictNameTh": "ดอยแก้ว",
      "postalCode": 50160
    },
    {
      "id": 4177,
      "provinceCode": 50,
      "districtCode": 5002,
      "subdistrictCode": 500209,
      "subdistrictNameEn": "Mae Soi",
      "subdistrictNameTh": "แม่สอย",
      "postalCode": 50240
    },
    {
      "id": 4178,
      "provinceCode": 50,
      "districtCode": 5003,
      "subdistrictCode": 500301,
      "subdistrictNameEn": "Chang Khoeng",
      "subdistrictNameTh": "ช่างเคิ่ง",
      "postalCode": 50270
    },
    {
      "id": 4179,
      "provinceCode": 50,
      "districtCode": 5003,
      "subdistrictCode": 500302,
      "subdistrictNameEn": "Tha Pha",
      "subdistrictNameTh": "ท่าผา",
      "postalCode": 50270
    },
    {
      "id": 4180,
      "provinceCode": 50,
      "districtCode": 5003,
      "subdistrictCode": 500303,
      "subdistrictNameEn": "Ban Thap",
      "subdistrictNameTh": "บ้านทับ",
      "postalCode": 50270
    },
    {
      "id": 4181,
      "provinceCode": 50,
      "districtCode": 5003,
      "subdistrictCode": 500304,
      "subdistrictNameEn": "Mae Suek",
      "subdistrictNameTh": "แม่ศึก",
      "postalCode": 50270
    },
    {
      "id": 4182,
      "provinceCode": 50,
      "districtCode": 5003,
      "subdistrictCode": 500305,
      "subdistrictNameEn": "Mae Na Chon",
      "subdistrictNameTh": "แม่นาจร",
      "postalCode": 50270
    },
    {
      "id": 4183,
      "provinceCode": 50,
      "districtCode": 5003,
      "subdistrictCode": 500307,
      "subdistrictNameEn": "Pang Hin Fon",
      "subdistrictNameTh": "ปางหินฝน",
      "postalCode": 50270
    },
    {
      "id": 4184,
      "provinceCode": 50,
      "districtCode": 5003,
      "subdistrictCode": 500308,
      "subdistrictNameEn": "Kong Khaek",
      "subdistrictNameTh": "กองแขก",
      "postalCode": 50270
    },
    {
      "id": 4185,
      "provinceCode": 50,
      "districtCode": 5004,
      "subdistrictCode": 500401,
      "subdistrictNameEn": "Chiang Dao",
      "subdistrictNameTh": "เชียงดาว",
      "postalCode": 50170
    },
    {
      "id": 4186,
      "provinceCode": 50,
      "districtCode": 5004,
      "subdistrictCode": 500402,
      "subdistrictNameEn": "Mueang Na",
      "subdistrictNameTh": "เมืองนะ",
      "postalCode": 50170
    },
    {
      "id": 4187,
      "provinceCode": 50,
      "districtCode": 5004,
      "subdistrictCode": 500403,
      "subdistrictNameEn": "Mueang Ngai",
      "subdistrictNameTh": "เมืองงาย",
      "postalCode": 50170
    },
    {
      "id": 4188,
      "provinceCode": 50,
      "districtCode": 5004,
      "subdistrictCode": 500404,
      "subdistrictNameEn": "Mae Na",
      "subdistrictNameTh": "แม่นะ",
      "postalCode": 50170
    },
    {
      "id": 4189,
      "provinceCode": 50,
      "districtCode": 5004,
      "subdistrictCode": 500405,
      "subdistrictNameEn": "Mueang Khong",
      "subdistrictNameTh": "เมืองคอง",
      "postalCode": 50170
    },
    {
      "id": 4190,
      "provinceCode": 50,
      "districtCode": 5004,
      "subdistrictCode": 500406,
      "subdistrictNameEn": "Ping Khong",
      "subdistrictNameTh": "ปิงโค้ง",
      "postalCode": 50170
    },
    {
      "id": 4191,
      "provinceCode": 50,
      "districtCode": 5004,
      "subdistrictCode": 500407,
      "subdistrictNameEn": "Thung Khao Phuang",
      "subdistrictNameTh": "ทุ่งข้าวพวง",
      "postalCode": 50170
    },
    {
      "id": 4192,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500501,
      "subdistrictNameEn": "Choeng Doi",
      "subdistrictNameTh": "เชิงดอย",
      "postalCode": 50220
    },
    {
      "id": 4193,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500502,
      "subdistrictNameEn": "San Pu Loei",
      "subdistrictNameTh": "สันปูเลย",
      "postalCode": 50220
    },
    {
      "id": 4194,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500503,
      "subdistrictNameEn": "Luang Nuea",
      "subdistrictNameTh": "ลวงเหนือ",
      "postalCode": 50220
    },
    {
      "id": 4195,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500504,
      "subdistrictNameEn": "Pa Pong",
      "subdistrictNameTh": "ป่าป้อง",
      "postalCode": 50220
    },
    {
      "id": 4196,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500505,
      "subdistrictNameEn": "Sa-Nga Ban",
      "subdistrictNameTh": "สง่าบ้าน",
      "postalCode": 50220
    },
    {
      "id": 4197,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500506,
      "subdistrictNameEn": "Pa Lan",
      "subdistrictNameTh": "ป่าลาน",
      "postalCode": 50220
    },
    {
      "id": 4198,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500507,
      "subdistrictNameEn": "Talat Khwan",
      "subdistrictNameTh": "ตลาดขวัญ",
      "postalCode": 50220
    },
    {
      "id": 4199,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500508,
      "subdistrictNameEn": "Samran Rat",
      "subdistrictNameTh": "สำราญราษฎร์",
      "postalCode": 50220
    },
    {
      "id": 4200,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500509,
      "subdistrictNameEn": "Mae Khue",
      "subdistrictNameTh": "แม่คือ",
      "postalCode": 50220
    },
    {
      "id": 4201,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500510,
      "subdistrictNameEn": "Talat Yai",
      "subdistrictNameTh": "ตลาดใหญ่",
      "postalCode": 50220
    },
    {
      "id": 4202,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500511,
      "subdistrictNameEn": "Mae Hoi Ngoen",
      "subdistrictNameTh": "แม่ฮ้อยเงิน",
      "postalCode": 50220
    },
    {
      "id": 4203,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500512,
      "subdistrictNameEn": "Mae Pong",
      "subdistrictNameTh": "แม่โป่ง",
      "postalCode": 50220
    },
    {
      "id": 4204,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500513,
      "subdistrictNameEn": "Pa Miang",
      "subdistrictNameTh": "ป่าเมี่ยง",
      "postalCode": 50220
    },
    {
      "id": 4205,
      "provinceCode": 50,
      "districtCode": 5005,
      "subdistrictCode": 500514,
      "subdistrictNameEn": "Thep Sadet",
      "subdistrictNameTh": "เทพเสด็จ",
      "postalCode": 50220
    },
    {
      "id": 4206,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500601,
      "subdistrictNameEn": "San Mahaphon",
      "subdistrictNameTh": "สันมหาพน",
      "postalCode": 50150
    },
    {
      "id": 4207,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500602,
      "subdistrictNameEn": "Mae Taeng",
      "subdistrictNameTh": "แม่แตง",
      "postalCode": 50150
    },
    {
      "id": 4208,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500603,
      "subdistrictNameEn": "Khi Lek",
      "subdistrictNameTh": "ขี้เหล็ก",
      "postalCode": 50150
    },
    {
      "id": 4209,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500604,
      "subdistrictNameEn": "Cho Lae",
      "subdistrictNameTh": "ช่อแล",
      "postalCode": 50150
    },
    {
      "id": 4210,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500605,
      "subdistrictNameEn": "Mae Ho Phra",
      "subdistrictNameTh": "แม่หอพระ",
      "postalCode": 50150
    },
    {
      "id": 4211,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500606,
      "subdistrictNameEn": "Sop Poeng",
      "subdistrictNameTh": "สบเปิง",
      "postalCode": 50150
    },
    {
      "id": 4212,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500607,
      "subdistrictNameEn": "Ban Pao",
      "subdistrictNameTh": "บ้านเป้า",
      "postalCode": 50150
    },
    {
      "id": 4213,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500608,
      "subdistrictNameEn": "San Pa Yang",
      "subdistrictNameTh": "สันป่ายาง",
      "postalCode": 50330
    },
    {
      "id": 4214,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500609,
      "subdistrictNameEn": "Pa Pae",
      "subdistrictNameTh": "ป่าแป๋",
      "postalCode": 50150
    },
    {
      "id": 4215,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500610,
      "subdistrictNameEn": "Mueang Kai",
      "subdistrictNameTh": "เมืองก๋าย",
      "postalCode": 50150
    },
    {
      "id": 4216,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500611,
      "subdistrictNameEn": "Ban Chang",
      "subdistrictNameTh": "บ้านช้าง",
      "postalCode": 50150
    },
    {
      "id": 4217,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500612,
      "subdistrictNameEn": "Kuet Chang",
      "subdistrictNameTh": "กื้ดช้าง",
      "postalCode": 50150
    },
    {
      "id": 4218,
      "provinceCode": 50,
      "districtCode": 5006,
      "subdistrictCode": 500613,
      "subdistrictNameEn": "Inthakhin",
      "subdistrictNameTh": "อินทขิล",
      "postalCode": 50150
    },
    {
      "id": 4219,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500701,
      "subdistrictNameEn": "Rim Tai",
      "subdistrictNameTh": "ริมใต้",
      "postalCode": 50180
    },
    {
      "id": 4220,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500702,
      "subdistrictNameEn": "Rim Nuea",
      "subdistrictNameTh": "ริมเหนือ",
      "postalCode": 50180
    },
    {
      "id": 4221,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500703,
      "subdistrictNameEn": "San Pong",
      "subdistrictNameTh": "สันโป่ง",
      "postalCode": 50180
    },
    {
      "id": 4222,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500704,
      "subdistrictNameEn": "Khi Lek",
      "subdistrictNameTh": "ขี้เหล็ก",
      "postalCode": 50180
    },
    {
      "id": 4223,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500705,
      "subdistrictNameEn": "Saluang",
      "subdistrictNameTh": "สะลวง",
      "postalCode": 50330
    },
    {
      "id": 4224,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500706,
      "subdistrictNameEn": "Huai Sai",
      "subdistrictNameTh": "ห้วยทราย",
      "postalCode": 50180
    },
    {
      "id": 4225,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500707,
      "subdistrictNameEn": "Mae Raem",
      "subdistrictNameTh": "แม่แรม",
      "postalCode": 50180
    },
    {
      "id": 4226,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500708,
      "subdistrictNameEn": "Pong Yaeng",
      "subdistrictNameTh": "โป่งแยง",
      "postalCode": 50180
    },
    {
      "id": 4227,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500709,
      "subdistrictNameEn": "Mae Sa",
      "subdistrictNameTh": "แม่สา",
      "postalCode": 50180
    },
    {
      "id": 4228,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500710,
      "subdistrictNameEn": "Don Kaeo",
      "subdistrictNameTh": "ดอนแก้ว",
      "postalCode": 50180
    },
    {
      "id": 4229,
      "provinceCode": 50,
      "districtCode": 5007,
      "subdistrictCode": 500711,
      "subdistrictNameEn": "Mueang Kaeo",
      "subdistrictNameTh": "เหมืองแก้ว",
      "postalCode": 50180
    },
    {
      "id": 4230,
      "provinceCode": 50,
      "districtCode": 5008,
      "subdistrictCode": 500801,
      "subdistrictNameEn": "Samoeng Tai",
      "subdistrictNameTh": "สะเมิงใต้",
      "postalCode": 50250
    },
    {
      "id": 4231,
      "provinceCode": 50,
      "districtCode": 5008,
      "subdistrictCode": 500802,
      "subdistrictNameEn": "Samoeng Nuea",
      "subdistrictNameTh": "สะเมิงเหนือ",
      "postalCode": 50250
    },
    {
      "id": 4232,
      "provinceCode": 50,
      "districtCode": 5008,
      "subdistrictCode": 500803,
      "subdistrictNameEn": "Mae Sap",
      "subdistrictNameTh": "แม่สาบ",
      "postalCode": 50250
    },
    {
      "id": 4233,
      "provinceCode": 50,
      "districtCode": 5008,
      "subdistrictCode": 500804,
      "subdistrictNameEn": "Bo Kaeo",
      "subdistrictNameTh": "บ่อแก้ว",
      "postalCode": 50250
    },
    {
      "id": 4234,
      "provinceCode": 50,
      "districtCode": 5008,
      "subdistrictCode": 500805,
      "subdistrictNameEn": "Yung Moen",
      "subdistrictNameTh": "ยั้งเมิน",
      "postalCode": 50250
    },
    {
      "id": 4235,
      "provinceCode": 50,
      "districtCode": 5009,
      "subdistrictCode": 500901,
      "subdistrictNameEn": "Wiang",
      "subdistrictNameTh": "เวียง",
      "postalCode": 50110
    },
    {
      "id": 4236,
      "provinceCode": 50,
      "districtCode": 5009,
      "subdistrictCode": 500903,
      "subdistrictNameEn": "Mon Pin",
      "subdistrictNameTh": "ม่อนปิ่น",
      "postalCode": 50110
    },
    {
      "id": 4237,
      "provinceCode": 50,
      "districtCode": 5009,
      "subdistrictCode": 500904,
      "subdistrictNameEn": "Mae Ngon",
      "subdistrictNameTh": "แม่งอน",
      "postalCode": 50320
    },
    {
      "id": 4238,
      "provinceCode": 50,
      "districtCode": 5009,
      "subdistrictCode": 500905,
      "subdistrictNameEn": "Mae Soon",
      "subdistrictNameTh": "แม่สูน",
      "postalCode": 50110
    },
    {
      "id": 4239,
      "provinceCode": 50,
      "districtCode": 5009,
      "subdistrictCode": 500906,
      "subdistrictNameEn": "San Sai",
      "subdistrictNameTh": "สันทราย",
      "postalCode": 50110
    },
    {
      "id": 4240,
      "provinceCode": 50,
      "districtCode": 5009,
      "subdistrictCode": 500910,
      "subdistrictNameEn": "Mae Kha",
      "subdistrictNameTh": "แม่คะ",
      "postalCode": 50110
    },
    {
      "id": 4241,
      "provinceCode": 50,
      "districtCode": 5009,
      "subdistrictCode": 500911,
      "subdistrictNameEn": "Mae Kha",
      "subdistrictNameTh": "แม่ข่า",
      "postalCode": 50320
    },
    {
      "id": 4242,
      "provinceCode": 50,
      "districtCode": 5009,
      "subdistrictCode": 500912,
      "subdistrictNameEn": "Pong Nam Ron",
      "subdistrictNameTh": "โป่งน้ำร้อน",
      "postalCode": 50110
    },
    {
      "id": 4243,
      "provinceCode": 50,
      "districtCode": 5010,
      "subdistrictCode": 501001,
      "subdistrictNameEn": "Mae Ai",
      "subdistrictNameTh": "แม่อาย",
      "postalCode": 50280
    },
    {
      "id": 4244,
      "provinceCode": 50,
      "districtCode": 5010,
      "subdistrictCode": 501002,
      "subdistrictNameEn": "Mae Sao",
      "subdistrictNameTh": "แม่สาว",
      "postalCode": 50280
    },
    {
      "id": 4245,
      "provinceCode": 50,
      "districtCode": 5010,
      "subdistrictCode": 501003,
      "subdistrictNameEn": "San Ton Mue",
      "subdistrictNameTh": "สันต้นหมื้อ",
      "postalCode": 50280
    },
    {
      "id": 4246,
      "provinceCode": 50,
      "districtCode": 5010,
      "subdistrictCode": 501004,
      "subdistrictNameEn": "Mae Na Wang",
      "subdistrictNameTh": "แม่นาวาง",
      "postalCode": 50280
    },
    {
      "id": 4247,
      "provinceCode": 50,
      "districtCode": 5010,
      "subdistrictCode": 501005,
      "subdistrictNameEn": "Tha Ton",
      "subdistrictNameTh": "ท่าตอน",
      "postalCode": 50280
    },
    {
      "id": 4248,
      "provinceCode": 50,
      "districtCode": 5010,
      "subdistrictCode": 501006,
      "subdistrictNameEn": "Ban Luang",
      "subdistrictNameTh": "บ้านหลวง",
      "postalCode": 50280
    },
    {
      "id": 4249,
      "provinceCode": 50,
      "districtCode": 5010,
      "subdistrictCode": 501007,
      "subdistrictNameEn": "Malika",
      "subdistrictNameTh": "มะลิกา",
      "postalCode": 50280
    },
    {
      "id": 4250,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501101,
      "subdistrictNameEn": "Wiang",
      "subdistrictNameTh": "เวียง",
      "postalCode": 50190
    },
    {
      "id": 4251,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501102,
      "subdistrictNameEn": "Thung Luang",
      "subdistrictNameTh": "ทุ่งหลวง",
      "postalCode": 50190
    },
    {
      "id": 4252,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501103,
      "subdistrictNameEn": "Pa Tum",
      "subdistrictNameTh": "ป่าตุ้ม",
      "postalCode": 50190
    },
    {
      "id": 4253,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501104,
      "subdistrictNameEn": "Pa Nai",
      "subdistrictNameTh": "ป่าไหน่",
      "postalCode": 50190
    },
    {
      "id": 4254,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501105,
      "subdistrictNameEn": "San Sai",
      "subdistrictNameTh": "สันทราย",
      "postalCode": 50190
    },
    {
      "id": 4255,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501106,
      "subdistrictNameEn": "Ban Pong",
      "subdistrictNameTh": "บ้านโป่ง",
      "postalCode": 50190
    },
    {
      "id": 4256,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501107,
      "subdistrictNameEn": "Nam Phrae",
      "subdistrictNameTh": "น้ำแพร่",
      "postalCode": 50190
    },
    {
      "id": 4257,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501108,
      "subdistrictNameEn": "Khuean Phak",
      "subdistrictNameTh": "เขื่อนผาก",
      "postalCode": 50190
    },
    {
      "id": 4258,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501109,
      "subdistrictNameEn": "Mae Waen",
      "subdistrictNameTh": "แม่แวน",
      "postalCode": 50190
    },
    {
      "id": 4259,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501110,
      "subdistrictNameEn": "Mae Pang",
      "subdistrictNameTh": "แม่ปั๋ง",
      "postalCode": 50190
    },
    {
      "id": 4260,
      "provinceCode": 50,
      "districtCode": 5011,
      "subdistrictCode": 501111,
      "subdistrictNameEn": "Long Khot",
      "subdistrictNameTh": "โหล่งขอด",
      "postalCode": 50190
    },
    {
      "id": 4261,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501201,
      "subdistrictNameEn": "Yu Wa",
      "subdistrictNameTh": "ยุหว่า",
      "postalCode": 50120
    },
    {
      "id": 4262,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501202,
      "subdistrictNameEn": "San Klang",
      "subdistrictNameTh": "สันกลาง",
      "postalCode": 50120
    },
    {
      "id": 4263,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501203,
      "subdistrictNameEn": "Tha Wang Phrao",
      "subdistrictNameTh": "ท่าวังพร้าว",
      "postalCode": 50120
    },
    {
      "id": 4264,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501204,
      "subdistrictNameEn": "Makham Luang",
      "subdistrictNameTh": "มะขามหลวง",
      "postalCode": 50120
    },
    {
      "id": 4265,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501205,
      "subdistrictNameEn": "Mae Ka",
      "subdistrictNameTh": "แม่ก๊า",
      "postalCode": 50120
    },
    {
      "id": 4266,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501206,
      "subdistrictNameEn": "Ban Mae",
      "subdistrictNameTh": "บ้านแม",
      "postalCode": 50120
    },
    {
      "id": 4267,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501207,
      "subdistrictNameEn": "Ban Klang",
      "subdistrictNameTh": "บ้านกลาง",
      "postalCode": 50120
    },
    {
      "id": 4268,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501208,
      "subdistrictNameEn": "Thung Satok",
      "subdistrictNameTh": "ทุ่งสะโตก",
      "postalCode": 50120
    },
    {
      "id": 4269,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501210,
      "subdistrictNameEn": "Thung Tom",
      "subdistrictNameTh": "ทุ่งต้อม",
      "postalCode": 50120
    },
    {
      "id": 4270,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501214,
      "subdistrictNameEn": "Nam Bo Luang",
      "subdistrictNameTh": "น้ำบ่อหลวง",
      "postalCode": 50120
    },
    {
      "id": 4271,
      "provinceCode": 50,
      "districtCode": 5012,
      "subdistrictCode": 501215,
      "subdistrictNameEn": "Makhun Wan",
      "subdistrictNameTh": "มะขุนหวาน",
      "postalCode": 50120
    },
    {
      "id": 4272,
      "provinceCode": 50,
      "districtCode": 5013,
      "subdistrictCode": 501301,
      "subdistrictNameEn": "San Kamphaeng",
      "subdistrictNameTh": "สันกำแพง",
      "postalCode": 50130
    },
    {
      "id": 4273,
      "provinceCode": 50,
      "districtCode": 5013,
      "subdistrictCode": 501302,
      "subdistrictNameEn": "Sai Mun",
      "subdistrictNameTh": "ทรายมูล",
      "postalCode": 50130
    },
    {
      "id": 4274,
      "provinceCode": 50,
      "districtCode": 5013,
      "subdistrictCode": 501303,
      "subdistrictNameEn": "Rong Wua Daeng",
      "subdistrictNameTh": "ร้องวัวแดง",
      "postalCode": 50130
    },
    {
      "id": 4275,
      "provinceCode": 50,
      "districtCode": 5013,
      "subdistrictCode": 501304,
      "subdistrictNameEn": "Buak Khang",
      "subdistrictNameTh": "บวกค้าง",
      "postalCode": 50130
    },
    {
      "id": 4276,
      "provinceCode": 50,
      "districtCode": 5013,
      "subdistrictCode": 501305,
      "subdistrictNameEn": "Chae Chang",
      "subdistrictNameTh": "แช่ช้าง",
      "postalCode": 50130
    },
    {
      "id": 4277,
      "provinceCode": 50,
      "districtCode": 5013,
      "subdistrictCode": 501306,
      "subdistrictNameEn": "On Tai",
      "subdistrictNameTh": "ออนใต้",
      "postalCode": 50130
    },
    {
      "id": 4278,
      "provinceCode": 50,
      "districtCode": 5013,
      "subdistrictCode": 501310,
      "subdistrictNameEn": "Mae Pu Kha",
      "subdistrictNameTh": "แม่ปูคา",
      "postalCode": 50130
    },
    {
      "id": 4279,
      "provinceCode": 50,
      "districtCode": 5013,
      "subdistrictCode": 501311,
      "subdistrictNameEn": "Huai Sai",
      "subdistrictNameTh": "ห้วยทราย",
      "postalCode": 50130
    },
    {
      "id": 4280,
      "provinceCode": 50,
      "districtCode": 5013,
      "subdistrictCode": 501312,
      "subdistrictNameEn": "Ton Pao",
      "subdistrictNameTh": "ต้นเปา",
      "postalCode": 50130
    },
    {
      "id": 4281,
      "provinceCode": 50,
      "districtCode": 5013,
      "subdistrictCode": 501313,
      "subdistrictNameEn": "San Klang",
      "subdistrictNameTh": "สันกลาง",
      "postalCode": 50130
    },
    {
      "id": 4282,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501401,
      "subdistrictNameEn": "San Sai Luang",
      "subdistrictNameTh": "สันทรายหลวง",
      "postalCode": 50210
    },
    {
      "id": 4283,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501402,
      "subdistrictNameEn": "San Sai Noi",
      "subdistrictNameTh": "สันทรายน้อย",
      "postalCode": 50210
    },
    {
      "id": 4284,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501403,
      "subdistrictNameEn": "San Phranet",
      "subdistrictNameTh": "สันพระเนตร",
      "postalCode": 50210
    },
    {
      "id": 4285,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501404,
      "subdistrictNameEn": "San Na Meng",
      "subdistrictNameTh": "สันนาเม็ง",
      "postalCode": 50210
    },
    {
      "id": 4286,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501405,
      "subdistrictNameEn": "San Pa Pao",
      "subdistrictNameTh": "สันป่าเปา",
      "postalCode": 50210
    },
    {
      "id": 4287,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501406,
      "subdistrictNameEn": "Nong Yaeng",
      "subdistrictNameTh": "หนองแหย่ง",
      "postalCode": 50210
    },
    {
      "id": 4288,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501407,
      "subdistrictNameEn": "Nong Chom",
      "subdistrictNameTh": "หนองจ๊อม",
      "postalCode": 50210
    },
    {
      "id": 4289,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501408,
      "subdistrictNameEn": "Nong Han",
      "subdistrictNameTh": "หนองหาร",
      "postalCode": 50290
    },
    {
      "id": 4290,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501409,
      "subdistrictNameEn": "Mae Faek",
      "subdistrictNameTh": "แม่แฝก",
      "postalCode": 50290
    },
    {
      "id": 4291,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501410,
      "subdistrictNameEn": "Mae Faek Mai",
      "subdistrictNameTh": "แม่แฝกใหม่",
      "postalCode": 50290
    },
    {
      "id": 4292,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501411,
      "subdistrictNameEn": "Mueang Len",
      "subdistrictNameTh": "เมืองเล็น",
      "postalCode": 50210
    },
    {
      "id": 4293,
      "provinceCode": 50,
      "districtCode": 5014,
      "subdistrictCode": 501412,
      "subdistrictNameEn": "Pa Phai",
      "subdistrictNameTh": "ป่าไผ่",
      "postalCode": 50210
    },
    {
      "id": 4294,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501501,
      "subdistrictNameEn": "Hang Dong",
      "subdistrictNameTh": "หางดง",
      "postalCode": 50230
    },
    {
      "id": 4295,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501502,
      "subdistrictNameEn": "Nong Kaeo",
      "subdistrictNameTh": "หนองแก๋ว",
      "postalCode": 50230
    },
    {
      "id": 4296,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501503,
      "subdistrictNameEn": "Han Kaeo",
      "subdistrictNameTh": "หารแก้ว",
      "postalCode": 50230
    },
    {
      "id": 4297,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501504,
      "subdistrictNameEn": "Nong Tong",
      "subdistrictNameTh": "หนองตอง",
      "postalCode": 50340
    },
    {
      "id": 4298,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501505,
      "subdistrictNameEn": "Khun Khong",
      "subdistrictNameTh": "ขุนคง",
      "postalCode": 50230
    },
    {
      "id": 4299,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501506,
      "subdistrictNameEn": "Sop Mae Kha",
      "subdistrictNameTh": "สบแม่ข่า",
      "postalCode": 50230
    },
    {
      "id": 4300,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501507,
      "subdistrictNameEn": "Ban Waen",
      "subdistrictNameTh": "บ้านแหวน",
      "postalCode": 50230
    },
    {
      "id": 4301,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501508,
      "subdistrictNameEn": "San Phak Wan",
      "subdistrictNameTh": "สันผักหวาน",
      "postalCode": 50230
    },
    {
      "id": 4302,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501509,
      "subdistrictNameEn": "Nong Khwai",
      "subdistrictNameTh": "หนองควาย",
      "postalCode": 50230
    },
    {
      "id": 4303,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501510,
      "subdistrictNameEn": "Ban Pong",
      "subdistrictNameTh": "บ้านปง",
      "postalCode": 50230
    },
    {
      "id": 4304,
      "provinceCode": 50,
      "districtCode": 5015,
      "subdistrictCode": 501511,
      "subdistrictNameEn": "Nam Phrae",
      "subdistrictNameTh": "น้ำแพร่",
      "postalCode": 50230
    },
    {
      "id": 4305,
      "provinceCode": 50,
      "districtCode": 5016,
      "subdistrictCode": 501601,
      "subdistrictNameEn": "Hang Dong",
      "subdistrictNameTh": "หางดง",
      "postalCode": 50240
    },
    {
      "id": 4306,
      "provinceCode": 50,
      "districtCode": 5016,
      "subdistrictCode": 501602,
      "subdistrictNameEn": "Hot",
      "subdistrictNameTh": "ฮอด",
      "postalCode": 50240
    },
    {
      "id": 4307,
      "provinceCode": 50,
      "districtCode": 5016,
      "subdistrictCode": 501603,
      "subdistrictNameEn": "Ban Tan",
      "subdistrictNameTh": "บ้านตาล",
      "postalCode": 50240
    },
    {
      "id": 4308,
      "provinceCode": 50,
      "districtCode": 5016,
      "subdistrictCode": 501604,
      "subdistrictNameEn": "Bo Luang",
      "subdistrictNameTh": "บ่อหลวง",
      "postalCode": 50240
    },
    {
      "id": 4309,
      "provinceCode": 50,
      "districtCode": 5016,
      "subdistrictCode": 501605,
      "subdistrictNameEn": "Bo Sali",
      "subdistrictNameTh": "บ่อสลี",
      "postalCode": 50240
    },
    {
      "id": 4310,
      "provinceCode": 50,
      "districtCode": 5016,
      "subdistrictCode": 501606,
      "subdistrictNameEn": "Na Kho Ruea",
      "subdistrictNameTh": "นาคอเรือ",
      "postalCode": 50240
    },
    {
      "id": 4311,
      "provinceCode": 50,
      "districtCode": 5017,
      "subdistrictCode": 501701,
      "subdistrictNameEn": "Doi Tao",
      "subdistrictNameTh": "ดอยเต่า",
      "postalCode": 50260
    },
    {
      "id": 4312,
      "provinceCode": 50,
      "districtCode": 5017,
      "subdistrictCode": 501702,
      "subdistrictNameEn": "Tha Duea",
      "subdistrictNameTh": "ท่าเดื่อ",
      "postalCode": 50260
    },
    {
      "id": 4313,
      "provinceCode": 50,
      "districtCode": 5017,
      "subdistrictCode": 501703,
      "subdistrictNameEn": "Muet Ka",
      "subdistrictNameTh": "มืดกา",
      "postalCode": 50260
    },
    {
      "id": 4314,
      "provinceCode": 50,
      "districtCode": 5017,
      "subdistrictCode": 501704,
      "subdistrictNameEn": "Ban Aen",
      "subdistrictNameTh": "บ้านแอ่น",
      "postalCode": 50260
    },
    {
      "id": 4315,
      "provinceCode": 50,
      "districtCode": 5017,
      "subdistrictCode": 501705,
      "subdistrictNameEn": "Bong Tan",
      "subdistrictNameTh": "บงตัน",
      "postalCode": 50260
    },
    {
      "id": 4316,
      "provinceCode": 50,
      "districtCode": 5017,
      "subdistrictCode": 501706,
      "subdistrictNameEn": "Pong Thung",
      "subdistrictNameTh": "โปงทุ่ง",
      "postalCode": 50260
    },
    {
      "id": 4317,
      "provinceCode": 50,
      "districtCode": 5018,
      "subdistrictCode": 501801,
      "subdistrictNameEn": "Omkoi",
      "subdistrictNameTh": "อมก๋อย",
      "postalCode": 50310
    },
    {
      "id": 4318,
      "provinceCode": 50,
      "districtCode": 5018,
      "subdistrictCode": 501802,
      "subdistrictNameEn": "Yang Piang",
      "subdistrictNameTh": "ยางเปียง",
      "postalCode": 50310
    },
    {
      "id": 4319,
      "provinceCode": 50,
      "districtCode": 5018,
      "subdistrictCode": 501803,
      "subdistrictNameEn": "Mae Tuen",
      "subdistrictNameTh": "แม่ตื่น",
      "postalCode": 50310
    },
    {
      "id": 4320,
      "provinceCode": 50,
      "districtCode": 5018,
      "subdistrictCode": 501804,
      "subdistrictNameEn": "Mon Chong",
      "subdistrictNameTh": "ม่อนจอง",
      "postalCode": 50310
    },
    {
      "id": 4321,
      "provinceCode": 50,
      "districtCode": 5018,
      "subdistrictCode": 501805,
      "subdistrictNameEn": "Sop Khong",
      "subdistrictNameTh": "แม่หลอง",
      "postalCode": 50310
    },
    {
      "id": 4322,
      "provinceCode": 50,
      "districtCode": 5018,
      "subdistrictCode": 501806,
      "subdistrictNameEn": "Na Kian",
      "subdistrictNameTh": "นาเกียน",
      "postalCode": 50310
    },
    {
      "id": 4323,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501901,
      "subdistrictNameEn": "Yang Noeng",
      "subdistrictNameTh": "ยางเนิ้ง",
      "postalCode": 50140
    },
    {
      "id": 4324,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501902,
      "subdistrictNameEn": "Saraphi",
      "subdistrictNameTh": "สารภี",
      "postalCode": 50140
    },
    {
      "id": 4325,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501903,
      "subdistrictNameEn": "Chomphu",
      "subdistrictNameTh": "ชมภู",
      "postalCode": 50140
    },
    {
      "id": 4326,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501904,
      "subdistrictNameEn": "Chaiya Sathan",
      "subdistrictNameTh": "ไชยสถาน",
      "postalCode": 50140
    },
    {
      "id": 4327,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501905,
      "subdistrictNameEn": "Khua Mung",
      "subdistrictNameTh": "ขัวมุง",
      "postalCode": 50140
    },
    {
      "id": 4328,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501906,
      "subdistrictNameEn": "Nong Faek",
      "subdistrictNameTh": "หนองแฝก",
      "postalCode": 50140
    },
    {
      "id": 4329,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501907,
      "subdistrictNameEn": "Nong Phueng",
      "subdistrictNameTh": "หนองผึ้ง",
      "postalCode": 50140
    },
    {
      "id": 4330,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501908,
      "subdistrictNameEn": "Tha Kwang",
      "subdistrictNameTh": "ท่ากว้าง",
      "postalCode": 50140
    },
    {
      "id": 4331,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501909,
      "subdistrictNameEn": "Don Kaeo",
      "subdistrictNameTh": "ดอนแก้ว",
      "postalCode": 50140
    },
    {
      "id": 4332,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501910,
      "subdistrictNameEn": "Tha Wang Tan",
      "subdistrictNameTh": "ท่าวังตาล",
      "postalCode": 50140
    },
    {
      "id": 4333,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501911,
      "subdistrictNameEn": "San Sai",
      "subdistrictNameTh": "สันทราย",
      "postalCode": 50140
    },
    {
      "id": 4334,
      "provinceCode": 50,
      "districtCode": 5019,
      "subdistrictCode": 501912,
      "subdistrictNameEn": "Pa Bong",
      "subdistrictNameTh": "ป่าบง",
      "postalCode": 50140
    },
    {
      "id": 4335,
      "provinceCode": 50,
      "districtCode": 5020,
      "subdistrictCode": 502001,
      "subdistrictNameEn": "Mueang Haeng",
      "subdistrictNameTh": "เมืองแหง",
      "postalCode": 50350
    },
    {
      "id": 4336,
      "provinceCode": 50,
      "districtCode": 5020,
      "subdistrictCode": 502002,
      "subdistrictNameEn": "Piang Luang",
      "subdistrictNameTh": "เปียงหลวง",
      "postalCode": 50350
    },
    {
      "id": 4337,
      "provinceCode": 50,
      "districtCode": 5020,
      "subdistrictCode": 502003,
      "subdistrictNameEn": "Saen Hai",
      "subdistrictNameTh": "แสนไห",
      "postalCode": 50350
    },
    {
      "id": 4338,
      "provinceCode": 50,
      "districtCode": 5021,
      "subdistrictCode": 502101,
      "subdistrictNameEn": "Pong Tam",
      "subdistrictNameTh": "ปงตำ",
      "postalCode": 50320
    },
    {
      "id": 4339,
      "provinceCode": 50,
      "districtCode": 5021,
      "subdistrictCode": 502102,
      "subdistrictNameEn": "Si Dong Yen",
      "subdistrictNameTh": "ศรีดงเย็น",
      "postalCode": 50320
    },
    {
      "id": 4340,
      "provinceCode": 50,
      "districtCode": 5021,
      "subdistrictCode": 502103,
      "subdistrictNameEn": "Mae Thalop",
      "subdistrictNameTh": "แม่ทะลบ",
      "postalCode": 50320
    },
    {
      "id": 4341,
      "provinceCode": 50,
      "districtCode": 5021,
      "subdistrictCode": 502104,
      "subdistrictNameEn": "Nong Bua",
      "subdistrictNameTh": "หนองบัว",
      "postalCode": 50320
    },
    {
      "id": 4342,
      "provinceCode": 50,
      "districtCode": 5022,
      "subdistrictCode": 502201,
      "subdistrictNameEn": "Ban Kat",
      "subdistrictNameTh": "บ้านกาด",
      "postalCode": 50360
    },
    {
      "id": 4343,
      "provinceCode": 50,
      "districtCode": 5022,
      "subdistrictCode": 502202,
      "subdistrictNameEn": "Thung Pi",
      "subdistrictNameTh": "ทุ่งปี๊",
      "postalCode": 50360
    },
    {
      "id": 4344,
      "provinceCode": 50,
      "districtCode": 5022,
      "subdistrictCode": 502203,
      "subdistrictNameEn": "Thung Ruang Thong",
      "subdistrictNameTh": "ทุ่งรวงทอง",
      "postalCode": 50360
    },
    {
      "id": 4345,
      "provinceCode": 50,
      "districtCode": 5022,
      "subdistrictCode": 502204,
      "subdistrictNameEn": "Mae Win",
      "subdistrictNameTh": "แม่วิน",
      "postalCode": 50360
    },
    {
      "id": 4346,
      "provinceCode": 50,
      "districtCode": 5022,
      "subdistrictCode": 502205,
      "subdistrictNameEn": "Don Pao",
      "subdistrictNameTh": "ดอนเปา",
      "postalCode": 50360
    },
    {
      "id": 4347,
      "provinceCode": 50,
      "districtCode": 5023,
      "subdistrictCode": 502301,
      "subdistrictNameEn": "On Nuea",
      "subdistrictNameTh": "ออนเหนือ",
      "postalCode": 50130
    },
    {
      "id": 4348,
      "provinceCode": 50,
      "districtCode": 5023,
      "subdistrictCode": 502302,
      "subdistrictNameEn": "On Klang",
      "subdistrictNameTh": "ออนกลาง",
      "postalCode": 50130
    },
    {
      "id": 4349,
      "provinceCode": 50,
      "districtCode": 5023,
      "subdistrictCode": 502303,
      "subdistrictNameEn": "Ban Sahakon",
      "subdistrictNameTh": "บ้านสหกรณ์",
      "postalCode": 50130
    },
    {
      "id": 4350,
      "provinceCode": 50,
      "districtCode": 5023,
      "subdistrictCode": 502304,
      "subdistrictNameEn": "Huai Kaeo",
      "subdistrictNameTh": "ห้วยแก้ว",
      "postalCode": 50130
    },
    {
      "id": 4351,
      "provinceCode": 50,
      "districtCode": 5023,
      "subdistrictCode": 502305,
      "subdistrictNameEn": "Mae Tha",
      "subdistrictNameTh": "แม่ทา",
      "postalCode": 50130
    },
    {
      "id": 4352,
      "provinceCode": 50,
      "districtCode": 5023,
      "subdistrictCode": 502306,
      "subdistrictNameEn": "Tha Nuea",
      "subdistrictNameTh": "ทาเหนือ",
      "postalCode": 50130
    },
    {
      "id": 4353,
      "provinceCode": 50,
      "districtCode": 5024,
      "subdistrictCode": 502401,
      "subdistrictNameEn": "Doi Lo",
      "subdistrictNameTh": "ดอยหล่อ",
      "postalCode": 50160
    },
    {
      "id": 4354,
      "provinceCode": 50,
      "districtCode": 5024,
      "subdistrictCode": 502402,
      "subdistrictNameEn": "Song Khwae",
      "subdistrictNameTh": "สองแคว",
      "postalCode": 50160
    },
    {
      "id": 4355,
      "provinceCode": 50,
      "districtCode": 5024,
      "subdistrictCode": 502403,
      "subdistrictNameEn": "Yang Khram",
      "subdistrictNameTh": "ยางคราม",
      "postalCode": 50160
    },
    {
      "id": 4356,
      "provinceCode": 50,
      "districtCode": 5024,
      "subdistrictCode": 502404,
      "subdistrictNameEn": "Santi Suk",
      "subdistrictNameTh": "สันติสุข",
      "postalCode": 50160
    },
    {
      "id": 4357,
      "provinceCode": 50,
      "districtCode": 5025,
      "subdistrictCode": 502501,
      "subdistrictNameEn": "Ban Chan",
      "subdistrictNameTh": "บ้านจันทร์",
      "postalCode": 58130
    },
    {
      "id": 4358,
      "provinceCode": 50,
      "districtCode": 5025,
      "subdistrictCode": 502502,
      "subdistrictNameEn": "Mae Dad",
      "subdistrictNameTh": "แม่แดด",
      "postalCode": 58130
    },
    {
      "id": 4359,
      "provinceCode": 50,
      "districtCode": 5025,
      "subdistrictCode": 502503,
      "subdistrictNameEn": "Jam Luang",
      "subdistrictNameTh": "แจ่มหลวง",
      "postalCode": 58130
    }, // Add other districts as needed
  ];

  @override
  void initState() {
    super.initState();
    // _vm = RegisterVM();
    // _vm.userEnterPage();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
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
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.07281, vertical: height * 0.0163),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShopStatusBarRegister(
                      shopIndicatorRegistationState: 1,
                    ),
                    sectionBufferHeight(bufferSection: height * 0.0218),
                    Center(
                      child: Text(
                        "General information",
                        style: kfontH1InterBoldBlackColor(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    sectionBufferHeight(bufferSection: height * 0.0218),
                    headingContainer(
                      header: "Name",
                    ),
                    sectionBufferHeight(bufferSection: height * 0.0109),
                    TextFieldContainer(
                      hightContainer: 40,
                      controller: nameShop,
                      hintText: "Shop name",
                    ),
                    sectionBufferHeight(bufferSection: height * 0.0218),
                    headingContainer(
                      header: "Description",
                    ),
                    sectionBufferHeight(bufferSection: height * 0.0109),
                    TextFieldContainer(
                        hightContainer: 175,
                        controller: descriptionShop,
                        hintText: "Description"),
                    sectionBufferHeight(bufferSection: height * 0.0218),
                    headingContainer(header: "Address"),
                    sectionBufferHeight(bufferSection: height * 0.0109),
                    dropdownButtonDependancySelectionProvince(
                        width: width,
                        height: height,
                        header: "Province",
                        selected: selectedProvince),
                    sectionBufferHeight(bufferSection: height * 0.0109),
                    dropdownButtonDependancySelectionDistricts(
                        header: "District",
                        listOfItem: district,
                        height: height,
                        width: width),
                    sectionBufferHeight(bufferSection: height * 0.0109),
                    dropdownButtonDependancySelectionSubDistricts(
                        header: "Sub District",
                        listOfItem: subDistricts,
                        height: height,
                        width: width),
                    sectionBufferHeight(bufferSection: height * 0.0109),
                    TextFieldContainer(
                        hightContainer: height * 0.191,
                        controller: addressDetail,
                        hintText: "Address Detail"),
                    const Spacer(),
                    InkWell(
                      splashColor: Colors.greenAccent,
                      onTap: () {
                        //TODO Shop First
                        // if (nameShop.text.isEmpty ||
                        //     descriptionShop.text.isEmpty ||
                        //     selectedProvince == null ||
                        //     selectedDistrict == null ||
                        //     selectedSubDistrict == null ||
                        //     addressDetail.text.isEmpty) {
                        //   // Display an error message or perform some action for invalid input
                        //   Utility.flushBarErrorMessage(
                        //       message: "Please insert data information",
                        //       context: context);
                        //   return;
                        // }

                        setState(() {
                          // Your logic here
                          print("hello");

                          print(nameShop.text);
                          print(descriptionShop.text);
                          print(selectedProvince);
                          print(selectedDistrict);
                          print(selectedSubDistrict);
                          print(addressDetail.text);
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ShopRegisterSecondView(),
                              ));
                          // Add more logic as needed
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        width: double.infinity,
                        height: constraints.maxHeight * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Center(
                          child: Text(
                            "NEXT PAGE",
                            style: kfontH1InterBoldBlackColor(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Text headingContainer({required String header}) {
    return Text(
      header,
      style: kfontH3InterBlackColor(),
      textAlign: TextAlign.left,
    );
  }

  DropdownButtonHideUnderline dropdownButtonDependancySelectionSubDistricts(
      {required String header,
      required List<Map<String, dynamic>> listOfItem,
      required width,
      required height}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: (selectedProvince != null && selectedDistrict != null
            ? listOfItem
                .where((subdistrict) =>
                    (subdistrict["provinceCode"] ==
                        (provinces.firstWhere((p) =>
                            p["provinceNameTh"] ==
                            selectedProvince))["provinceCode"]) &&
                    (subdistrict["districtCode"] ==
                        (district.firstWhere((p) =>
                            p["districtNameTh"] ==
                            selectedDistrict))["districtCode"]))
                .map((Map<String, dynamic> district) {
                return DropdownMenuItem<String>(
                  value: district["subdistrictNameTh"],
                  child: Text(district["subdistrictNameTh"]),
                );
              }).toList()
            : <DropdownMenuItem<String>>[]),
        value: selectedSubDistrict,
        hint: Text(
          header,
          style: kfontH4InterBlackColorHalfOpacity(),
        ),
        onChanged: (value) {
          setState(() {
            selectedSubDistrict = value.toString();
          });
        },
        // disabledHint: ,

        buttonStyleData: buttonStyleDropDown(height: height, width: width),
        dropdownStyleData: dropdownStyleBox(height: height),
        menuItemStyleData: menuItemStyleBox(height: height),
        dropdownSearchData: dropdownSearchBox(height: height, width: width),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchTextMenuList.clear();
          }
        },
      ),
    );
  }

  DropdownButtonHideUnderline dropdownButtonDependancySelectionDistricts(
      {required String header,
      required List<Map<String, dynamic>> listOfItem,
      required height,
      required width}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: (selectedProvince != null
            ? listOfItem
                .where((district) =>
                    district["provinceCode"] ==
                    (provinces.firstWhere((p) =>
                        p["provinceNameTh"] ==
                        selectedProvince))["provinceCode"])
                .map((Map<String, dynamic> district) {
                return DropdownMenuItem<String>(
                  value: district["districtNameTh"],
                  child: Text(district["districtNameTh"]),
                );
              }).toList()
            : <DropdownMenuItem<String>>[]),
        value: selectedDistrict,
        hint: Text(
          header,
          style: kfontH4InterBlackColorHalfOpacity(),
        ),
        onChanged: (value) {
          setState(() {
            selectedSubDistrict = null;
            selectedDistrict = value.toString();
          });
        },
        // disabledHint: ,

        buttonStyleData: buttonStyleDropDown(height: height, width: width),
        dropdownStyleData: dropdownStyleBox(height: height),
        menuItemStyleData: menuItemStyleBox(height: height),
        dropdownSearchData: dropdownSearchBox(height: height, width: width),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchTextMenuList.clear();
          }
        },
      ),
    );
  }

  DropdownSearchData<Object?> dropdownSearchBox(
      {required height, required width}) {
    return DropdownSearchData(
      searchController: searchTextMenuList,
      searchInnerWidgetHeight: height * 0.0546,
      searchInnerWidget: Container(
        height: height * 0.0546,
        padding: EdgeInsets.only(
          top: height * 0.008,
          bottom: height * 0.004,
          right: width * 0.0194,
          left: width * 0.0194,
        ),
        child: TextFormField(
          expands: true,
          maxLines: null,
          controller: searchTextMenuList,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: width * 0.024,
              vertical: height * 0.008,
            ),
            hintText: 'Search for an item...',
            hintStyle: kfontH4InterBlackColorHalfOpacity(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      searchMatchFn: (item, searchValue) {
        return item.value.toString().contains(searchValue);
      },
    );
  }

  MenuItemStyleData menuItemStyleBox({required height}) {
    return MenuItemStyleData(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      height: height * 0.0437,
    );
  }

  DropdownStyleData dropdownStyleBox({required height}) {
    return DropdownStyleData(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      maxHeight: height * 0.2185,
    );
  }

  ButtonStyleData buttonStyleDropDown({required height, required width}) {
    return ButtonStyleData(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: const Color.fromRGBO(226, 199, 153, 1),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.symmetric(horizontal: width * 0.0388),
      height: height * 0.0437,
      width: double.infinity,
    );
  }

  DropdownButtonHideUnderline dropdownButtonDependancySelectionProvince(
      {required String header,
      required String? selected,
      required height,
      required width}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: provinces.map((Map<String, dynamic> province) {
          return DropdownMenuItem<String>(
            value: province["provinceNameTh"],
            child: Text(province["provinceNameTh"]),
          );
        }).toList(),
        value: selectedProvince,
        hint: Text(
          header,
          style: kfontH4InterBlackColorHalfOpacity(),
        ),
        onChanged: (value) {
          setState(() {
            if (value != selectedProvince) {
              selectedProvince = value.toString();
              selectedDistrict = null;
            }
          });
        },
        buttonStyleData: buttonStyleDropDown(height: height, width: width),
        dropdownStyleData: dropdownStyleBox(height: height),
        menuItemStyleData: menuItemStyleBox(height: height),
        dropdownSearchData: dropdownSearchBox(height: height, width: width),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchTextMenuList.clear();
          }
        },
      ),
    );
  }
}
