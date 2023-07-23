import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CoupnsGrid extends StatelessWidget {
  const CoupnsGrid({
    super.key,
    required this.datas,
  });

  final List datas;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: (1 / 1.2),
        crossAxisCount: 2, // Number of columns
        children: List.generate(datas.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 30,
              shadowColor: Colors.black,
              color: Colors.white,
              child: SizedBox(
                width: 300,
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                    Container(
                    color: Colors.white,
                    width: 100,
                    height: 100,
                    child : Image(image: CachedNetworkImageProvider(datas[index][2]))
                    ),//CircleAvatar
                      const SizedBox(
                        height: 10,
                      ), //SizedBox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.currency_rupee),
                          Text(
                            '${datas[index][1]}',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ), //Textstyle
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ), //SizedBox/Text
                      Text(
                        '${datas[index][0]}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ), //Textstyle
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${datas[index][3]}',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ), //Textstyle
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            'Good',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ), //Textstyle
                          ),
                        ],
                      ),
                    ],
                  ), //Column
                ), //Padding
              ), //SizedBox
            ),
          );
        }));
  }
}