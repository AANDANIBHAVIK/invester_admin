import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

Widget commonProperty(
    List<String> images,
    String name,
    String investmentValue,
    String invested,
    String earns,
    String returnOnInvest,
    String investmentDate,
    String sold) {
  return InkWell(
    // onHover: (val) {
    //   print(val);
    // },
    // onTap: () {
    //   print('object');
    // },
    child: Container(
      // margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(2, 2))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(images.first), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15)),
          ),
          Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextWidget(
                  name,
                  color: Colors.black,
                  textAlign: TextAlign.start,
                  fontSize: 15,
                ),
              ),
              Expanded(
                child: TextWidget(
                  '$investmentValue USD',
                  color: Colors.blueAccent,
                  textAlign: TextAlign.end,
                  fontSize: 15.5,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextWidget(
                  'Total Invested ',
                  color: Colors.grey,
                  fontSize: 13,
                  textAlign: TextAlign.start,
                ),
              ),
              TextWidget(
                '$invested',
                color: Colors.blueAccent,
                fontSize: 13,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextWidget(
                  'Total Earns ',
                  color: Colors.grey,
                  fontSize: 13,
                  textAlign: TextAlign.start,
                ),
              ),
              TextWidget(
                '$earns',
                color: Colors.blueAccent,
                fontSize: 13,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Spacer(
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextWidget(
                  investmentDate,
                  color: Colors.black,
                  fontSize: 15.5,
                  textAlign: TextAlign.start,
                ),
              ),
              // TextWidget(
              //   "Sold $sold%",
              //   color: Colors.green,
              //   fontSize: 15.5,
              //   textAlign: TextAlign.start,
              // ),
              // CustomButton(
              //   buttonText: 'More..',
              //   onBtnPress: () {},
              //   width: Responsive.isMobile(context) ? 20 : 5,
              //   height: 3,
              //   fontSize: 15,
              //   borderRadius: 5,
              // ),
            ],
          ),
        ],
      ),
    ),
  );
}
