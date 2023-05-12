import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping/consts.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/pages/components/bottom_sheet.dart';

import 'components/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  TextEditingController _searchController = TextEditingController();

  late Size size;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          children: [
            SearchBar(controller: _searchController),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Chegirmalar",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: size.width,
                  height: size.width * 0.425,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      Product product = Product.fromMap(
                          fakeProducts[Random.secure().nextInt(3)]);
                      return _buildProductCard(product: product);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Top maxsulotlar",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: size.width,
                  child: Column(
                    children: fakeProducts
                        .map((e) =>
                            _buildProductTile(product: Product.fromMap(e)))
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Eng ko'p sotilgan maxsulotlar",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(),
                  clipBehavior: Clip.antiAlias,
                  height: size.width * 0.7,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      Product product = Product.fromMap(
                          fakeProducts[Random.secure().nextInt(3)]);
                      return _buildBigProductCard(product: product);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Eng ko'p sotilgan maxsulotlar",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(),
                  clipBehavior: Clip.antiAlias,
                  height: size.width,
                  child: ListView.builder(
                    itemCount: 10,
                    reverse: true,
                    itemBuilder: (context, index) {
                      Product product = Product.fromMap(
                          fakeProducts[Random.secure().nextInt(3)]);
                      return _buildBigProductTile(product: product);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTile({required Product product}) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isDismissible: true,
          enableDrag: true,
          context: context,
          builder: (context) => BottomSheet(
            enableDrag: true,
            animationController: _animationController,
            onClosing: () {},
            builder: (context) {
              return CustomBottomSheet(product: product, context: context);
            },
          ),
        );
      },
      child: Container(
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
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox.square(
              child: Image.asset(
                "assets/images/${product.img}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            "${product.title}",
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            "${product.price}",
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildBigProductTile({required Product product}) {
    double tileWidth = size.width * 0.8;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isDismissible: true,
          enableDrag: true,
          context: context,
          builder: (context) => BottomSheet(
            enableDrag: true,
            animationController: _animationController,
            onClosing: () {},
            builder: (context) {
              return CustomBottomSheet(product: product, context: context);
            },
          ),
        );

        print(product.title);
      },
      child: Container(
        width: tileWidth,
        height: 75,
        margin: EdgeInsets.all(10),
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
        child: Row(
          children: [
            Container(
              width: 74.5,
              height: 74.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: secondaryColor,
                image: DecorationImage(
                  image: AssetImage("assets/images/${product.img}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.title}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${product.price}",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBigProductCard({required Product product}) {
    double cardWidth = size.width * 0.5;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isDismissible: true,
          enableDrag: true,
          context: context,
          builder: (context) => BottomSheet(
            enableDrag: true,
            animationController: _animationController,
            onClosing: () {},
            builder: (context) {
              return CustomBottomSheet(product: product, context: context);
            },
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: cardWidth * 1.3,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: secondaryColor,
          boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/${product.img}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text(
                        "${product.title}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5.0, right: 15.0),
                      child: Text(
                        "${product.price}",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard({required Product product}) {
    double cardWidth = size.width * 0.425;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isDismissible: true,
          enableDrag: true,
          context: context,
          builder: (context) => BottomSheet(
            enableDrag: true,
            animationController: _animationController,
            onClosing: () {},
            builder: (context) {
              return CustomBottomSheet(product: product, context: context);
            },
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: cardWidth,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage("assets/images/${product.img}"),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: cardWidth * 0.35,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 5.0),
                    child: Text(
                      "${product.title}",
                      style: TextStyle(color: secondaryColor),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.0, right: 15.0),
                    child: Text(
                      "${product.price}",
                      style: TextStyle(color: secondaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
