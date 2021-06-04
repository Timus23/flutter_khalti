class KhaltiResult {
  int amount;
  String mobile;
  String productIdentity;
  String productName;
  String? productUrl;
  String token;

  KhaltiResult({
    required this.amount,
    required this.mobile,
    required this.productIdentity,
    required this.productName,
    required this.token,
    this.productUrl,
  });

  factory KhaltiResult.fromJson(Map<String, dynamic> json) {
    return KhaltiResult(
      amount: json['amount'],
      mobile: json['mobile'],
      productIdentity: json['product_identity'],
      productName: json['product_name'],
      token: json['token'],
      productUrl: json['product_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['mobile'] = this.mobile;
    data['product_identity'] = this.productIdentity;
    data['product_name'] = this.productName;
    data['token'] = this.token;
    data['product_url'] = this.productUrl;
    return data;
  }
}
