import 'package:carousel_slider/carousel_slider.dart';
import 'package:dhaka_shop/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/product_card_widget.dart';
import '../../../theme/controller/theme_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/heading_Button_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () {

            },
          ),
        ],
        title: GestureDetector(
          onTap: () {
            showSearch(context: context, delegate: ProductSearchDelegate());
          },
          child: Container(
            width: 250,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: BoxBorder.all(color: Colors.grey)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Icon(Icons.search_outlined,color: Colors.grey,),
                  SizedBox(width: 8,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Search", style: TextStyle(fontSize: 17)),
                  ),
                ],
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final categories = controller.productList
            .map((product) => product.category)
            .toSet()
            .toList();
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return CustomScrollView(
            slivers: [
              //slider section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 180,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          controller.currentBannerIndex.value = index;
                        },
                      ),
                      items: controller.bannerImages.map((imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.bannerImages.asMap().entries.map((
                        entry,
                      ) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:ThemeController.to.isDarkMode? Colors.black.withOpacity(
                              controller.currentBannerIndex.value == entry.key
                                  ? 0.9
                                  : 0.4,
                            ):Colors.grey.withOpacity(
                              controller.currentBannerIndex.value == entry.key
                                  ? 0.9
                                  : 0.4,
                            ),

                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              //category list
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: .8),
                            borderRadius: BorderRadius.circular(5)
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(categories[index],style: TextStyle(color: Colors.white  ),),
                            )
                        ),
                      );
                    },),
                  ),
                ),
              ),

              // Flash Deal Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                  child: HeadingButtonWidget(
                    level: "Flash Deals",
                    onTap: () => Get.toNamed(
                      Routes.CATEGORY_PRODUCTS,
                      arguments: "FlashDeals",
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    itemCount: controller.flashDeals.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 120,
                          child: ProductCard(
                            product: controller.flashDeals[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Discount Poster Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                  child: SizedBox(
                    child: Image.asset("assets/img/discount_banner.jpg"),
                  )
                ),
              ),

              // Laptop Products Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                  child: HeadingButtonWidget(
                    level: "Top Selling Laptop",
                    onTap: () => Get.toNamed(
                      Routes.CATEGORY_PRODUCTS,
                      arguments: "Laptop",
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    itemCount: controller.laptopProducts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 120,
                          child: ProductCard(
                            product: controller.laptopProducts[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // You May Like Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'you May',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.favorite_outlined, color: Colors.red),
                      Text(
                        'Like',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ProductCard(product: controller.productList[index]),
                  );
                }, childCount: controller.productList.length),
              ),
            ],
          );
        }
      }),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  final HomeController controller = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          controller.searchProducts(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    controller.searchProducts(query);
    return Obx(
      () => ListView.builder(
        itemCount: controller.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = controller.filteredProducts[index];
          return InkWell(
            onTap: () {
              close(context, product);
              Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dhaka_shop/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../data/model/product_model.dart';
// import '../../../widgets/product_card_widget.dart';
// import '../controllers/home_controller.dart';
// import '../widgets/heading_Button_widget.dart';
//
// class HomeView extends GetView<HomeController> {
//   const HomeView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.camera_alt_outlined),
//             onPressed: () {},
//           ),
//         ],
//         title: GestureDetector(
//           onTap: () {
//             showSearch(context: context, delegate: ProductSearchDelegate());
//           },
//           child: Container(
//             width: 250,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 14),
//               child: Row(
//                 children: [
//                   Icon(Icons.search_outlined),
//                   SizedBox(width: 8),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text("Search", style: TextStyle(fontSize: 17)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: _buildBody(),
//     );
//   }
//
//   Widget _buildBody() {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }
//       return _buildMainContent();
//     });
//   }
//
//   Widget _buildMainContent() {
//     return CustomScrollView(
//       slivers: [
//         _buildBannerSlider(),
//         _buildSectionTitle(
//           "Flash Deals",
//           Routes.CATEGORY_PRODUCTS,
//           "FlashDeals",
//         ),
//         _buildHorizontalProductList(controller.flashDeals),
//         _buildSectionTitle(
//           "Best Mobile Brand",
//           Routes.CATEGORY_PRODUCTS,
//           "Mobile",
//         ),
//         _buildHorizontalProductList(controller.mobileProducts),
//         _buildSectionTitle(
//           "Top Selling Laptop",
//           Routes.CATEGORY_PRODUCTS,
//           "Laptop",
//         ),
//         _buildHorizontalProductList(controller.laptopProducts),
//         _buildYouMayLikeTitle(),
//         _buildProductGrid(),
//       ],
//     );
//   }
//
//   Widget _buildBannerSlider() {
//     return SliverToBoxAdapter(
//       child: Column(
//         children: [
//           Obx(
//             () => CarouselSlider.builder(
//               itemCount: controller.bannerImages.length,
//               itemBuilder: (context, index, realIndex) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: CachedNetworkImage(
//                     imageUrl: controller.bannerImages[index],
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) =>
//                         Container(color: Colors.grey[200]),
//                     errorWidget: (context, url, error) =>
//                         const Icon(Icons.error),
//                   ),
//                 );
//               },
//               options: CarouselOptions(
//                 height: 180,
//                 autoPlay: true,
//                 enlargeCenterPage: true,
//                 aspectRatio: 16 / 9,
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 enableInfiniteScroll: true,
//                 autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                 viewportFraction: 0.8,
//                 onPageChanged: (index, reason) {
//                   controller.currentBannerIndex.value = index;
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Obx(
//             () => Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: controller.bannerImages.asMap().entries.map((entry) {
//                 return Container(
//                   width: 8.0,
//                   height: 8.0,
//                   margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.black.withOpacity(
//                       controller.currentBannerIndex.value == entry.key
//                           ? 0.9
//                           : 0.4,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   SliverToBoxAdapter _buildSectionTitle(
//     String title,
//     String route,
//     String argument,
//   ) {
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
//         child: HeadingButtonWidget(
//           level: title,
//           onTap: () => Get.toNamed(route, arguments: argument),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHorizontalProductList(List<Product> products) {
//     return SliverToBoxAdapter(
//       child: SizedBox(
//         height: 200,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           itemCount: products.length,
//           itemExtent: 136,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ProductCard(product: products[index]),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildYouMayLikeTitle() {
//     return SliverToBoxAdapter(
//       child: const Padding(
//         padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'You May',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Icon(Icons.favorite_outlined, color: Colors.red),
//             Text(
//               'Like',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProductGrid() {
//     return Obx(
//       () => SliverGrid(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.75,
//           mainAxisSpacing: 8,
//           crossAxisSpacing: 8,
//         ),
//         delegate: SliverChildBuilderDelegate((context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: ProductCard(product: controller.productList[index]),
//           );
//         }, childCount: controller.productList.length),
//       ),
//     );
//   }
// }
//
// class ProductSearchDelegate extends SearchDelegate {
//   final HomeController controller = Get.find();
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           controller.searchProducts(query);
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () => close(context, null),
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) => _buildSearchResults();
//
//   @override
//   Widget buildSuggestions(BuildContext context) => _buildSearchResults();
//
//   Widget _buildSearchResults() {
//     controller.searchProducts(query);
//     return Obx(
//       () => ListView.builder(
//         itemCount: controller.filteredProducts.length,
//         itemBuilder: (context, index) {
//           final product = controller.filteredProducts[index];
//           return ListTile(
//             leading: CachedNetworkImage(
//               imageUrl: product.image,
//               width: 60,
//               height: 60,
//               placeholder: (context, url) => Container(color: Colors.grey[200]),
//               errorWidget: (context, url, error) => const Icon(Icons.error),
//             ),
//             title: Text(
//               product.title,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//               '\$${product.price.toStringAsFixed(2)}',
//               style: const TextStyle(color: Colors.green),
//             ),
//             onTap: () {
//               close(context, product);
//               Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
