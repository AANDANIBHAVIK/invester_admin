import 'package:flutter/material.dart';

class commonPropertyImage extends StatelessWidget {
  const commonPropertyImage(this.imageUrl, this.onTap);
  final String imageUrl;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          // margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(2, 2))
              ]),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: InkWell(
              onTap: () async {
                onTap();
              },
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.redAccent),
                      color: Colors.white),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.redAccent,
                    size: 25,
                  ))),
        ),
      ],
    );
  }
}
