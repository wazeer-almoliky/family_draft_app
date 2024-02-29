class CommonApi {
  final int? id;
  final String? name;
  final String? address;
  final String? type;
  final int? state;
  final String? phone;
  final String? note;
  final int? price;
  final DateTime? date;
  const CommonApi(
      {this.id,
      this.name,
      this.address,
      this.type,
      this.state,
      this.note,
      this.phone,
      this.price,
      this.date});
}

class User extends CommonApi {
  final String? password;
  const User(
      {super.id,
      super.name,
      super.type,
      super.state,
      super.phone,
      this.password});
  factory User.fromjson(Map<String, dynamic> json) {
    return User(
      id: json["user_id"] != null ? json["user_id"] as int : 0,
      name: json["user_name"] != null ? json["user_name"] as String : '',
      phone: json["user_phone"] != null ? json["user_phone"] as String : '',
      type: json["user_type"] != null ? json["user_type"] as String : '',
      state: json["user_state"] != null ? json["user_state"] as int : 0,
      password:
          json["user_password"] != null ? json["user_password"] as String : '',
    );
  }
}

class Catagory extends CommonApi {
  final String? url;
  const Catagory({super.id, super.name, super.note,this.url});
  factory Catagory.fromjson(Map<String, dynamic> json) {
    return Catagory(
      id: json["category_id"] != null ? json["category_id"] as int : 0,
      name:
          json["category_name"] != null ? json["category_name"] as String : '',
      note:
          json["category_note"] != null ? json["category_note"] as String : '',
      url:
          json["category_photo"] != null ? json["category_photo"] as String : '',
    );
  }
}

class Photo extends CommonApi {
  final int? serviceID;
  final String? name2;
  const Photo({super.id, super.name, this.serviceID, this.name2});
  factory Photo.fromjson(Map<String, dynamic> json) {
    return Photo(
      id: json["photo_id"] != null ? json["photo_id"] as int : 0,
      serviceID: json["product_id"] != null ? json["product_id"] as int : 0,
      name: json["photo_url"] != null ? json["photo_url"] as String : '',
    );
  }
}


class Family extends CommonApi {
  final int? userID;

  const Family(
      {super.id,
      super.name,
      super.phone,
      super.note,
      super.address,
      this.userID});
  factory Family.fromjson(Map<String, dynamic> json) {
    return Family(
      id: json["family_id"] != null ? json["family_id"] as int : 0,
      userID: json["user_id"] != null ? json["user_id"] as int : 0,
      name: json["family_name"] != null ? json["family_name"] as String : '',
      phone: json["family_phone"] != null ? json["family_phone"] as String : '',
      address: json["family_address"] != null
          ? json["family_address"] as String
          : '',
    );
  }
}

class Product extends CommonApi {
  // final String? image;
  final int? familyID, catagoryID;
  // final List<String>? images;
  const Product(
      {super.id,
      super.name,
      super.note,
      super.price,
      this.familyID,
      this.catagoryID});
  factory Product.fromjson(Map<String, dynamic> json) {
    return Product(
      id: json["product_id"] != null ? json["product_id"] as int : 0,
      familyID: json["family_id"] != null ? json["family_id"] as int : 0,
      catagoryID: json["category_id"] != null ? json["category_id"] as int : 0,
      name: json["product_name"] != null ? json["product_name"] as String : '',
      price: json["product_price"] != null ? json["product_price"] as int : 0,
      note: json["product_description"] != null
          ? json["product_description"] as String
          : '',
      // image: json["image"] != null ? json["image"] as String : '',
      // images: json["images"] != null ? json["image"] as List : [],
    );
  }
}

class Reserve extends CommonApi {
  final String? paymentMethod;
  final int? quentity, productID;
  final DateTime? reserveDate;
  const Reserve(
      {super.id,
      super.name,
      super.state,
      super.price,
      super.phone,
      super.date,
      this.productID,
      this.quentity,
      this.reserveDate,
      this.paymentMethod});
  factory Reserve.fromjson(Map<String, dynamic> json) {
    return Reserve(
      id: json["request_id"] != null ? json["request_id"] as int : 0,
      productID: json["product_id"] != null ? json["product_id"] as int : 0,
      quentity: json["request_quantity"] != null
          ? json["request_quantity"] as int
          : 0,
      name: json["coustomer_name"] != null
          ? json["coustomer_name"] as String
          : '',
      paymentMethod: json["payment_method"] != null
          ? json["payment_method"] as String
          : '',
      phone: json["coustomer_phone"] != null
          ? json["coustomer_phone"] as String
          : '',
      state: json["request_status"] != null ? json["request_status"] as int : 0,
      price: json["request_price"] != null ? json["request_price"] as int : 0,
      date: json["request_day"] != null
          ? DateTime.tryParse(json["request_day"])
          : DateTime.now(),
      reserveDate: json["request_date"] != null
          ? DateTime.tryParse(json["request_date"])
          : DateTime.now(),
    );
  }
}
