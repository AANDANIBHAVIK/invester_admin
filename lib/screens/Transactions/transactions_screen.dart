import 'package:admin/Utils/Widgets/header.dart';
import 'package:admin/screens/Transactions/transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'components/transaction_table.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TransactionController transactionController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        // scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              title: 'Transfers',
            ),
            TransactionTable(),
            // if (Responsive.isMobile(context))
            //   SizedBox(height: defaultPadding),
            //
          ],
        ),
      ),
    );
  }
}
