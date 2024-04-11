import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void commonImageViewDialog(BuildContext context,
    {String? imageUrl, Uint8List? memoryImage}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 400,
              width: 400,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: memoryImage != null
                      ? DecorationImage(
                          image: MemoryImage(memoryImage), fit: BoxFit.cover)
                      : DecorationImage(
                          image: NetworkImage(imageUrl!), fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xA2573EF),
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        spreadRadius: 2),
                  ],
                  borderRadius: BorderRadius.circular(20)),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: InkWell(
                  onTap: () async {
                    Get.back();
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.grey,
                        size: 25,
                      ))),
            ),
          ],
        ),
      );
    },
  );
}
