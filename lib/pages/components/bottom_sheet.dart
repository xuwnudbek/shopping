import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping/consts.dart';
import 'package:shopping/models/booked_product.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/pages/components/snackbar.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet(
      {super.key, required this.product, required this.context});

  final Product product;
  final BuildContext context;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  GetStorage box = GetStorage("products");

  late Size size;
  int count = 0;
  int allPrice = 0;
  bool isLoading = false;

  inc() {
    int price = int.parse(widget.product.price.toString().replaceAll(" ", ""));
    setState(() {
      count++;
      allPrice = count * price;
    });
  }

  dec() {
    int price = int.parse(widget.product.price.toString().replaceAll(" ", ""));
    setState(() {
      if (count > 0) {
        count--;
        allPrice = count * price;
      }
    });
  }

  addToBacket() async {
    setState(() => isLoading = true);
    Product product = widget.product;
    Map<String, dynamic> data = {
      "title": product.title,
      "img": product.img,
      "count": count,
      "price": product.price,
    };

    List bookedList = jsonDecode(box.read("products") ?? "[]");

    bool isThere = false;
    for (var i = 0; i < bookedList.length; i++) {
      BookedProduct p = BookedProduct.fromMap(bookedList[i]);

      if (product.title == p.title && product.price == p.price) {
        bookedList[i]["count"] = p.count + count;
        isThere = true;
      }
    }
    !isThere ? bookedList.add(data) : null;

    await box.write("products", jsonEncode(bookedList)).then((value) async {
      setState(() => isLoading = false);
      Navigator.pop(widget.context);

      ScaffoldMessenger.of(context).showSnackBar(
        customSnackbar(msg: "Maxsulot savatchaga qo'shildi"),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      child: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.product.title}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${widget.product.price}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Container(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: grey.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      dec();
                    },
                    child: Container(
                      width: size.width * 0.2,
                      height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red,
                      ),
                      child: Text(
                        "-",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "$count",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      inc();
                    },
                    child: Container(
                      width: size.width * 0.2,
                      height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                      ),
                      child: Text(
                        "+",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Summasi: ",
                  style: TextStyle(
                    fontSize: 18,
                    color: grey,
                  ),
                ),
                Text(
                  "${prettyPrice(allPrice)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                addToBacket();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(primaryColor),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                fixedSize: MaterialStatePropertyAll(
                  Size(size.width, 50),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Savatga qo'shish",
                    style: TextStyle(color: secondaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
