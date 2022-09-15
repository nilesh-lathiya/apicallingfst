import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class fristapi extends StatefulWidget {
  const fristapi({Key? key}) : super(key: key);

  @override
  State<fristapi> createState() => _fristapiState();
}

class _fristapiState extends State<fristapi> {
  List l = [];
  bool status = false;
  @override
  void initState() {
    super.initState();
    getalldata();
  }
  getalldata()
  async {
       try {
            var response = await Dio().get('https://dummyjson.com/products');
            print(response);
            l = response.data["product"];
           }
    catch (e)
         {
            print(e);
        }
        setState(() {
          status=true;
                });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("dio_product"),),
      body: status ? ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          acess m = acess.fromJson(l[index]);
          return ListTile(
            title: Text("${m.products![index].id}"),

            leading:Column(
              children: [
                ElevatedButton(onPressed: () {

                }, child:Text("nilesh"))
              ],

            ),

          );
        },

      ) : Center(child: CircularProgressIndicator(),),
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
    rating = double.parse(json['rating'].toString()) ;
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
