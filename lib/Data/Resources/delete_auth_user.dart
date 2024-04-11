import 'package:admin/Data/APIs/api_manager.dart';
import 'package:admin/Data/Models/delete_user_model.dart';

import 'firebase_constants.dart';

class DeleteUserRepository {
  ApiManager apiManager = ApiManager();

  Future<DeleteUserModel> deleteUser(String uid) async {
    try {
      var response = await apiManager.delete(APIConstants.deleteUser + uid);
      var responseMap = DeleteUserModel.fromJson(response);

      return responseMap;
    } catch (e) {
      rethrow;
    }
  }
}
