import 'package:carousel_slider/carousel_slider.dart';
import 'package:dhaka_shop/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/product_card_widget.dart';
import '../../../data/model/product_model.dart';
import '../../../theme/controller/theme_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/heading_Button_widget.dart';
import '../widgets/product_search_delegate.dart';


class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return CustomScrollView(
            slivers: [
              _buildBannerSlider(),
              _buildCategoryList(),
              _buildSectionTitle(
                title: "Flash Deals",
                onTap: () => Get.toNamed(
                  Routes.CATEGORY_PRODUCTS,
                  arguments: "FlashDeals",
                ),
              ),

              _buildHorizontalProductList(products: controller.flashDeals,scrollController: controller.flashDealsScrollController, isScrolling: true),
              _buildDiscountBanner(),
              _buildSectionTitle(
                title: "Top Selling Laptop",
                onTap: () => Get.toNamed(
                  Routes.CATEGORY_PRODUCTS,
                  arguments: "Laptop",
                ),
              ),
              _buildHorizontalProductList(products: controller.laptopProducts,isScrolling: false),
              _buildYouMayLikeSection(),
              _buildProductGrid(),
            ],
          );
        }
      }),
    );
  }

  // AppBar Widget
  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.camera_alt_outlined),
          onPressed: () {},
        ),
      ],
      title: GestureDetector(
        onTap: () {
          showSearch(context: Get.context!, delegate: ProductSearchDelegate());
        },
        child: Container(
          width: 250,
          height: 40,
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Icon(Icons.search_outlined, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  "Search",
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),

      ),
      centerTitle: true,
    );
  }

  // Banner Slider Widget
  SliverToBoxAdapter _buildBannerSlider() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 15),
          CarouselSlider(
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                controller.currentBannerIndex.value = index;
              },
            ),
            items: controller.sliderImages.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.sliderImages.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ThemeController.to.isDarkMode
                      ? Colors.black.withOpacity(
                    controller.currentBannerIndex.value == entry.key ? 0.9 : 0.4,
                  )
                      : Colors.grey.withOpacity(
                    controller.currentBannerIndex.value == entry.key ? 0.9 : 0.4,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Category List Widget
  SliverToBoxAdapter _buildCategoryList() {
    final categories = controller.productList
        .map((product) => product.category)
        .toSet()
        .toList();

    return SliverToBoxAdapter(
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
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      categories[index],
                      style:  TextStyle(color: Theme.of(context).scaffoldBackgroundColor,),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Section Title Widget
  SliverToBoxAdapter _buildSectionTitle({
    required String title,
    required VoidCallback onTap,
  }) {return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        child: HeadingButtonWidget(
          level: title,
          onTap: onTap,
        ),
      ),
    );}

  // Horizontal Product List Widget
  SliverToBoxAdapter _buildHorizontalProductList({required List<Product> products,ScrollController? scrollController,required bool isScrolling}) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: isScrolling? ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 140,
              child: ProductCard(product: products[index]),
            );
          },
        ):ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 140,
              child: ProductCard(product: products[index]),
            );
          },
        )
      ),
    );
  }

  // Discount Banner Widget
  SliverToBoxAdapter _buildDiscountBanner() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        child: SizedBox(
          child: Image.asset("assets/img/discount_banner.jpg"),
        ),
      ),
    );
  }

  // "You May Like" Section Widget
  SliverToBoxAdapter _buildYouMayLikeSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You May',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.favorite_outlined, color: Colors.red),
            const Text(
              'Like',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Product Grid Widget
  SliverGrid _buildProductGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ProductCard(product: controller.productList[index]),
          );
        },
        childCount: controller.productList.length,
      ),
    );
  }
}



