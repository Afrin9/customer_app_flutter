class Customer {
  final int id;
  final String name;
  final String email;
  final String? imagePath;
  final double totalDue;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    this.imagePath,
    required this.totalDue,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['Id'],
      name: json['Name'] ?? '',
      email: json['Email'] ?? '',
      imagePath: json['ImagePath'],
      totalDue: (json['TotalDue'] ?? 0).toDouble(),
    );
  }
}
