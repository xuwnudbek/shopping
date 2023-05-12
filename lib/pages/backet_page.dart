import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopping/consts.dart';
import 'package:shopping/models/booked_product.dart';

class BacketPage extends StatefulWidget {
  const BacketPage({super.key});

  @override
  State<BacketPage> createState() => _BacketPageState();
}

class _BacketPageState extends State<BacketPage> {
  GetStorage box = GetStorage("products");
  late int productsCount;
  late Size size;
  late List data;

  Future deleteProduct(BookedProduct product) async {
    for (var i = 0; i < data.length; i++) {
      BookedProduct bProduct = BookedProduct.fromMap(data[i]);
      if (bProduct.title == product.title && bProduct.count == product.count) {
        data.removeAt(i);
      }
    }

    await box.write("products", jsonEncode(data)).then((value) {
      setState(() {});
    });
  }

  Map getAllPrice(List data) {
    int price = 0;
    int allProductCount = 0;
    for (var element in data) {
      BookedProduct bookedProduct = BookedProduct.fromMap(element);
      price += bookedProduct.count *
          int.parse(bookedProduct.price.toString().replaceAll(" ", ''));

      allProductCount += bookedProduct.count;
    }
    return {
      "allPrice": prettyPrice(price),
      "allCount": allProductCount,
    };
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    data = jsonDecode(box.read("products") ?? "[]");
    productsCount = getAllPrice(data)["allCount"];
    String allPrice = getAllPrice(data)["allPrice"];

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: size.width,
              color: primaryColor,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Maxsulot soni:  ${productsCount} ta",
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                    ),
                  ),
                  Text(
                    "Summasi:  ${allPrice}",
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              children: data.map((productData) {
            BookedProduct product = BookedProduct.fromMap(productData);
            return _buildItemTile(product: product);
          }).toList()),
        ),
      ],
    );
  }

  Widget _buildItemTile({required BookedProduct product}) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: secondaryColor,
            boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
              ),
            ],
          ),
          child: ListTile(
            isThreeLine: true,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox.square(
                dimension: 70,
                child: Image.asset(
                  "assets/images/${product.img}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "${product.title}",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              "narxi",
                              style: titleTextStyle,
                            ),
                            Text(
                              "${product.price}",
                              style: descriptionTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              vertical: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "soni",
                                    style: titleTextStyle,
                                  ),
                                  Text(
                                    "${product.count}",
                                    style: descriptionTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              "summasi",
                              style: titleTextStyle,
                            ),
                            Text(
                              "${product.count * intParse(product.price)}",
                              style: descriptionTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 7, right: 7),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Icon(
                        Ionicons.trash,
                        color: Colors.red,
                        size: 75,
                      ),
                      content: Text(
                        "Rostdan ham o'chirishni hohlaysizmi?",
                        textAlign: TextAlign.center,
                      ),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Yo'q",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            deleteProduct(product);
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(secondaryColor),
                              backgroundColor:
                                  MaterialStatePropertyAll(primaryColor),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              )),
                          child: Text("Ha"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Ionicons.trash_outline, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle get titleTextStyle => TextStyle(fontSize: 12, color: grey);
  TextStyle get descriptionTextStyle =>
      TextStyle(fontSize: 14, color: Colors.black);
}
