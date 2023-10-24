// ignore_for_file: file_names, prefer_const_constructors, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Constants/ColorConstants.dart';
import 'package:ecommerce_app/Constants/utils.dart';
import 'package:ecommerce_app/widgets/flash-sale-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Constants/app-constant.dart';
import '../../widgets/banner-widget.dart';
import '../../widgets/category-widget.dart';
import '../../widgets/custom-drawer-widget.dart';
import '../../widgets/heading-widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: logoColor,
        title: CustomizedText(
            text: "WT Ecomm",
            color: white,
            size: 20.sp,
            FontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.h),
          child: Column(
            children: [
              10.h.heightBox,
              //banners
              FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: BannerWidget()),
              //heading
              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your budget",
                onTap: () {},
                buttonText: "See More >",
              ),

              CategoriesWidget(),

              // Container(
              //   height: 200.h,
              //   width: Get.width / 4.0,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20.0),
              //     image: DecorationImage(
              //       image: CachedNetworkImageProvider(
              //         "https://img.freepik.com/free-photo/men39s-clothes-hanger-generative-ai_169016-29035.jpg?w=740&t=st=1698132195~exp=1698132795~hmac=1e19992839ecf249a6584db171853b199cba0d7a43c7f80aff60efeeecf3f0b9",
              //       ),
              //       fit: BoxFit.cover, // Adjust this as needed
              //     ),
              //   ),
              // ),

              //heading
              HeadingWidget(
                headingTitle: "Flash Sale",
                headingSubTitle: "According to your budget",
                onTap: () {},
                buttonText: "See More >",
              ),
              FlashSaleWidget(),
              //  //heading
              // HeadingWidget(
              //   headingTitle: "All Products",
              //   headingSubTitle: "According to your budget",
              //   onTap: () => Get.to(() => AllProductsScreen()),
              //   buttonText: "See More >",
              // ),

              // AllProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
