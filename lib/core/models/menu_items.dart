class MenuItems {
  String? id;
  final String name;
  final int price;
  final String desc;
  final String category;
  final int spicyLevel;
  final bool isAvailable;
  String? imgUrl;

  MenuItems({
    this.id,
    required this.name,
    required this.price,
    required this.desc,
    required this.category,
    required this.spicyLevel,
    required this.isAvailable,
    this.imgUrl,
  });

  factory MenuItems.fromJson(Map<String, dynamic> json, String id) {
    return MenuItems(
      id: id,
      name: json['name'],
      price: json['price'],
      desc: json['desc'],
      category: json['category'],
      spicyLevel: json['spicyLevel'],
      isAvailable: json['isAvailable'],
      imgUrl: json['imgUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'desc': desc,
      'category': category,
      'spicyLevel': spicyLevel,
      'isAvailable': isAvailable,
      'imgUrl': imgUrl
    };
  }
}
