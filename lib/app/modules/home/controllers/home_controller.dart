import 'package:get/get.dart';

import '../../../data/model/product_model.dart';
import '../../../data/json_services/json_services.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var featuredProductList = <Product>[].obs;
  final currentBannerIndex = 0.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await ProductService().fetchProducts();
      productList.assignAll(products);
    } finally {
      isLoading(false);
    }
  }



  List<Product> get mobileProducts =>
      productList.where((product) => product.category == 'Mobile').toList();

  List<Product> get laptopProducts =>
      productList.where((product) => product.category == 'Laptop').toList();

  List<Product> get flashDeals =>
      productList.where((product) => product.category == 'FlashDeals').toList();

  final List<String> bannerImages = [
    'https://images.unsplash.com/photo-1649972904349-6e44c42644a7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1423784346385-c1d4dac9893a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];


  final filteredProducts = <Product>[].obs;
  final searchQuery = ''.obs;

  void searchProducts(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredProducts.assignAll(productList);
      return;
    }

    filteredProducts.assignAll(
      productList.where((product) =>
      product.title.toLowerCase().contains(query.toLowerCase()) ||
          product.description.toLowerCase().contains(query.toLowerCase()) ||
          product.category.toLowerCase().contains(query.toLowerCase())),
    );
  }


}



