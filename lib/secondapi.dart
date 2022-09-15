import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class secondapi extends StatefulWidget {
  const secondapi({Key? key}) : super(key: key);

  @override
  State<secondapi> createState() => _secondapiState();
}

class _secondapiState extends State<secondapi> {
  Map<String, dynamic> d = {};
  bool status =false;
  acess? m;

  void initState() {
    super.initState();
    getalldata();
  }
  getalldata()
  async {
    try {
      var response = await Dio().get('https://dummyjson.com/products');
      print(response);
      d = response.data;
      print("**********");
      print(d);
      m = acess.fromJson(d);
      print(m);
      setState(() {
        status=true;
      });
    }
    catch (e)
    {
      print(e);
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("second api"),),
      body: status ? ListView.builder(itemCount: m!.products!.length,
        itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          child: ListTile(
            leading: Text("${m!.products![index].id}"),
            title: Text("${m!.products![index].title}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("description:${m!.products![index].description}"),
                Text("prise:${m!.products![index].price}"),
                Text("discountPercentage:${m!.products![index].discountPercentage}"),
                Text("rating:${m!.products![index].rating}"),
                Text("stock:${m!.products![index].stock}"),
                Text("brand:${m!.products![index].brand}"),
                Text("category:${m!.products![index].category}"),
                Text("thumbnail:${m!.products![index].thumbnail}"),



              ],
            ),

          ),
        );
      },)
      :Center(child: CircularProgressIndicator(),)
    );
  }
}

class acess {
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;

  acess({this.products, this.total, this.skip, this.limit});

  acess.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Products(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.discountPercentage,
        this.rating,
        this.stock,
        this.brand,
        this.category,
        this.thumbnail,
        this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = double.parse(json['rating'].toString());
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discountPercentage'] = this.discountPercentage;
    data['rating'] = this.rating;
    data['stock'] = this.stock;
    data['brand'] = this.brand;
    data['category'] = this.category;
    data['thumbnail'] = this.thumbnail;
    data['images'] = this.images;
    return data;
  }
}
