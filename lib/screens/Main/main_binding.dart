import 'package:admin/screens/CompanyPage/company_controller.dart';
import 'package:admin/screens/EnterpriseUser/enterprise_controller.dart';
import 'package:admin/screens/IndividualUser/users_controller.dart';
import 'package:admin/screens/PropertyPage/property_controller.dart';
import 'package:admin/screens/Transactions/transactions_controller.dart';
import 'package:admin/screens/main/main_controller.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<EnterpriseController>(() => EnterpriseController());
    Get.lazyPut<CompanyController>(() => CompanyController());
    Get.lazyPut<PropertyController>(() => PropertyController());
    Get.lazyPut<UsersController>(() => UsersController());
    Get.lazyPut<TransactionController>(() => TransactionController());
  }
}
