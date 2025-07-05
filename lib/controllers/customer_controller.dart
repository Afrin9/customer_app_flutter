import 'dart:convert';
import 'package:customer_app/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/customer_model.dart';

class CustomerController extends GetxController {
  var customers = <Customer>[].obs;
  var page = 1.obs;
  var isLoading = false.obs;
  var hasMore = true.obs;

  Future<void> fetchCustomers() async {
    if (!hasMore.value || isLoading.value) return;

    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse("https://www.pqstec.com/InvoiceApps/Values/GetCustomerList?searchquery=&pageNo=${page.value}&pageSize=20&SortyBy=Balance"),
        headers: {
          'Authorization': 'Bearer ${LoginController.authToken}',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['Success'] == 1 && responseData['CustomerList'] != null) {
        final List<dynamic> data = responseData['CustomerList'];
        
        if (data.isEmpty) {
          hasMore.value = false;
        } else {
          customers.addAll(data.map((e) => Customer.fromJson(e)).toList());
          page.value++;
        }
      } else {
        Get.snackbar("Error", "Failed to load customers");
      }
    } catch (_) {
      Get.snackbar("Error", "Failed to load customers");
    } finally {
      isLoading.value = false;
    }
  }
}
