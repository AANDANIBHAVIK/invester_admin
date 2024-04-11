import 'package:admin/Data/APIs/api_constant.dart';
import 'package:admin/Data/APIs/api_manager.dart';
import 'package:admin/Data/Models/transfers_model.dart';

class TransferRepository {
  ApiManager apiManager = ApiManager();

  Future<TransferModel> getTransferInfo(Map<String, dynamic> parameters) async {
    try {
      var response =
          await apiManager.post(APIConstants.getTransfer, parameters);
      var responseMap = TransferModel.fromJson(response);

      return responseMap;
    } catch (e) {
      rethrow;
    }
  }
}
