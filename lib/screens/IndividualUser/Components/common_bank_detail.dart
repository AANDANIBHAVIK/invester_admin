import 'package:admin/Utils/Widgets/common_devider.dart';
import 'package:admin/Utils/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

Widget commonBankAccount(
    int index, String name, String accountNumber, String bankName) {
  return InkWell(
    // onHover: (val) {
    //   print(val);
    // },
    // onTap: () {
    //   print('object');
    // },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          'Bank Account ${index}',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
        const SizedBox(height: 15),
        Container(
          // margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueAccent, width: 1.5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildAccountDetails(
                leadingText: 'Account holder name',
                trailingText: name,
              ),
              const SizedBox(height: 3),
              commonDivider(
                  bgColor: Colors.grey, intent: 0, endIntent: 0, thikness: 0.3),
              const SizedBox(height: 3),
              buildAccountDetails(
                leadingText: 'Account number',
                trailingText: '**********$accountNumber',
              ),
              const SizedBox(height: 3),
              commonDivider(
                  bgColor: Colors.grey, intent: 0, endIntent: 0, thikness: 0.3),
              const SizedBox(height: 3),
              buildAccountDetails(
                leadingText: 'Bank Name',
                trailingText: '$bankName',
              )
            ],
          ),
        )
      ],
    ),
  );
}

Row buildAccountDetails(
    {required String leadingText, required String trailingText}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextWidget(
        leadingText,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
      Expanded(
        child: TextWidget(
          trailingText,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: Colors.blueAccent,
          textAlign: TextAlign.end,
        ),
      ),
    ],
  );
}

// ListTile buildRecentTransactionListTile({
//   required String profile,
//   required String name,
//   required String amount,
//   required String date,
//   required Color color,
// }) {
//   return ListTile(
//     minVerticalPadding: 10,
//     contentPadding: EdgeInsets.zero,
//     leading: CircleAvatar(
//       maxRadius: 23,
//       backgroundImage: NetworkImage(profile),
//     ),
//     title: TextWidget(
//       name,
//       fontSize: 10.5,
//       fontWeight: FontWeight.w600,
//       textAlign: TextAlign.start,
//       color: context.theme.textTheme.displayLarge!.color!,
//     ),
//     subtitle: TextWidget(
//       date,
//       fontSize: 10.5,
//       fontWeight: FontWeight.w400,
//       textAlign: TextAlign.start,
//       color: context.theme.hintColor,
//     ),
//     trailing: TextWidget(
//       '-\$$amount',
//       fontSize: 9.8,
//       fontWeight: FontWeight.w500,
//       textAlign: TextAlign.start,
//       color: color,
//     ),
//   );
// }
