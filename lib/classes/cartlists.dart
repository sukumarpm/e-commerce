// Removed unnecessary import to avoid conflict with 'int' type.

class Cartlists {
  String? title;
  double? price;
  int? productId;
  String? icon;
  double? qty;

  Cartlists(
      {required this.title,
      required this.price,
      required this.productId,
      required this.icon,
      this.qty});

  Cartlists.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    productId = json['productId'];
    icon = json['icon'];
    qty = json['qty'];
  }
  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "price": price,
      "productId": productId,
      "icon": icon,
      "qty": qty,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['productId'] = productId;
    data['icon'] = icon;
    data['qty'] = qty;
    return data;
  }
}
