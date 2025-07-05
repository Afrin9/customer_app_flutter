import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/customer_model.dart';

class CustomerTile extends StatelessWidget {
  final Customer customer;

  const CustomerTile({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: "https://www.pqstec.com/InvoiceApps${customer.imagePath}",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        width: 50,
        height: 50,
      ),
      title: Text(customer.name),
      subtitle: Text("Balance: ${customer.totalDue.toStringAsFixed(2)}"),
    );
  }
}
