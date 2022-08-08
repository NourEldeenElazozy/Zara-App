class Cart {
  int id;
  List<ProductsCarts> productsCarts;

  Cart({this.id,this.productsCarts});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['products'] != null) {
      productsCarts = <ProductsCarts>[];
      json['products'].forEach((v) {
        productsCarts.add(new ProductsCarts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productsCarts != null) {
      data['products'] = this.productsCarts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsCarts {
  int id;
  String name;
  bool inCart;
  bool infavorites;
  String imageUrl;
  double price;






  ProductsCarts(
      {this.id,
        this.name,
        this.inCart,
        this.infavorites,
        this.imageUrl,
        this.price,
  });

  ProductsCarts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    inCart = json['inCart'];
    infavorites = json['infavorites'];
    imageUrl = json['imageUrl'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['inCart'] = this.inCart;
    data['infavorites'] = this.infavorites;
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;
    return data;
  }
}