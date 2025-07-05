import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../views/customer_list_page.dart';

class LoginController extends GetxController {
  static String authToken = '';
  var isLoading = false.obs;
  var token = ''.obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      final url = Uri.parse("https://www.pqstec.com/InvoiceApps/Values/LogIn?UserName=$username&Password=$password&ComId=1");
      final response = await http.get(url);

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        token.value = data['Token'];
        LoginController.authToken = data['Token'];
        Get.to(() => CustomerListPage());
      } else {
        Get.snackbar("Error", data["message"] ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
