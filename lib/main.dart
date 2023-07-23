import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'coupn_grid.dart';
import 'horizontal_chips.dart';

void main() => runApp(MyApp());

List<List<Object>> vouchers = [
  ['phone ', 000, 'https://img.freepik.com/premium-vector/system-software-update-upgrade-concept-loading-process-screen-vector-illustration_175838-2182.jpg?w=2000',"32 gb"],
  ['phone', 000, 'https://img.freepik.com/premium-vector/system-software-update-upgrade-concept-loading-process-screen-vector-illustration_175838-2182.jpg?w=2000',"32 gb"],
  ['phone', 000, 'https://img.freepik.com/premium-vector/system-software-update-upgrade-concept-loading-process-screen-vector-illustration_175838-2182.jpg?w=2000',"32 gb"],
  ['phone', 000, 'https://img.freepik.com/premium-vector/system-software-update-upgrade-concept-loading-process-screen-vector-illustration_175838-2182.jpg?w=2000',"32 gb"],
];

List<dynamic> chipData = [    //demo values are uising for only better user interface
  'Apple',
  'Samsung',
  'OnePlus',
  'Xiami',
];

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final TextEditingController _controller = TextEditingController();

  Future<void> gett() async {
    var url1 = Uri.parse('https://dev2be.oruphones.com/api/v1/global/assignment/getFilters?isLimited=true');
    var url2 = Uri.parse('https://dev2be.oruphones.com/api/v1/global/assignment/getListings?page=1&limit=15');  //hardcoded 15 pc
    var response1 = await http.get(url1);
    var response2 = await http.get(url2);

    if (response1.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response1.body);
      List<dynamic> token = data["filters"]["make"];
      setState((){
        chipData = token;
      });
    } else {
      print(response1.body);
    }

    if (response2.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response2.body);
      List<List<Object>> ans = [];
      List<dynamic> token = data["listings"];
      for(var valu in token) {
        List<Object> temp=[];
        String pic = valu["defaultImage"]["fullImage"];
        String rom = valu["deviceStorage"];
        int pric = valu["listingNumPrice"];
        String nm = valu["model"];
        temp.add(nm);
        temp.add(pric);
        temp.add(pic);
        temp.add(rom);
        ans.add(temp);
      }
      setState((){
        vouchers = ans;
      });
    } else {
      print(response2.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    gett();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                toolbarHeight: 100,
                title:  Expanded(
                  child:Column(
                    children:[
                      Row(
                        children: [
                          Icon(Icons.view_sidebar_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("name"),
                          const SizedBox(
                            width: 100,
                          ),
                          const SizedBox(
                            width: 110,
                          ),// Sized
                          // Padding(
                          // padding: EdgeInsets.all(8.0),
                          Text(
                            "India",
                          ),
                          Icon(Icons.location_on_outlined),
                          const SizedBox(
                            width: 15,
                          ),
                          Icon(Icons.notifications),
                          // ),
                          // const Padding(
                          // padding: EdgeInsets.all(0.0),

                          // ),// Box
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFFFFFFFF),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                /* -- Text and Icon -- */
                                hintText: "Search Products...",
                                hintStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFB3B1B1),
                                ), // TextStyle
                                suffixIcon: IconButton(
                                  color: Colors.black54, onPressed: () {
                                    postcall();
                                }, icon: Icon(Icons.search),
                                ), // Icon
                                /* -- Border Styling -- */
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(45.0),
                                  borderSide: const BorderSide(
                                    width: 2.0,
                                    color: Color(0xFFFF0000),
                                  ), // BorderSide
                                ), // OutlineInputBorder
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(45.0),
                                  borderSide: const BorderSide(
                                    width: 2.0,
                                    color: Colors.grey,
                                  ), // BorderSide
                                ), // OutlineInputBorder
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(45.0),
                                  borderSide: const BorderSide(
                                    width: 2.0,
                                    color: Colors.grey,
                                  ), // BorderSide
                                ), // OutlineInputBorder
                              ), // InputDecoration
                            ), // TextField
                          ), // Expanded
                        ],
                      ),
                    ],
                  ),
                ),// Row
              ), // Appbar
              body: PrefetchImageDemo()),
    );
  }

  Future<void> postcall() async {
    var url =Uri.parse('https://dev2be.oruphones.com/api/v1/global/assignment/searchModel');
    Map data = {
      'searchModel': _controller.text
    };
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String token = data["message"];
      Fluttertoast.showToast(
          msg: token,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      print(response.body);
    }
  }
}

class PrefetchImageDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PrefetchImageDemoState();
  }
}

class _PrefetchImageDemoState extends State<PrefetchImageDemo> {
  final List<String> images = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/Jupiter2021/Phase1_Teaser/MI_DealsRevealed/Redmi_02.jpg',
    'https://m.media-amazon.com/images/I/31miL7xrOUL._AC_UF420%2C420_FMjpg_.jpg',
    'https://m.media-amazon.com/images/I/61DUO0NqyyL._SX3000_.jpg',
    'https://i0.wp.com/www.smartprix.com/bytes/wp-content/uploads/2023/01/Apple-iPhone-14.jpg?fit=1440%2C810&ssl=1',
    'https://m.media-amazon.com/images/I/71aQ3u78A3L._SX3000_.jpg'
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SingleChildScrollView(
        child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 10, top: 10),
                child:Text(
                  'Buy Top Brands',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              HorizontalChips(
                values: chipData,
              ),
              const SizedBox(
                height: 10,
              ),
              CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 3.1,
                  enlargeCenterPage: true,
                ),
                itemBuilder: (context, index, realIdx) {
                  return Center(
                      child: Image.network(images[index],
                          fit: BoxFit.cover, width: double.infinity));
                },
              ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10, top: 20),
                    child: Text(
                      'Best deals near you',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CoupnsGrid(
                      datas: vouchers,
                    ),
                  ),
            ],
    ),),),
    );
  }
}
