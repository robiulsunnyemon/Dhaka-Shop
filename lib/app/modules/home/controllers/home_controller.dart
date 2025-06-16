import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/model/product_model.dart';
import '../../../data/json_services/json_services.dart';


class HomeController extends GetxController {
  // Loading state
  var isLoading = true.obs;

  // Product lists
  var productList = <Product>[].obs;
  var featuredProductList = <Product>[].obs;

  // Banner
  final currentBannerIndex = 0.obs;
  final List<String> sliderImages = [
    'https://images.unsplash.com/photo-1649972904349-6e44c42644a7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1423784346385-c1d4dac9893a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

  // Search functionality
  final filteredProducts = <Product>[].obs;
  final searchQuery = ''.obs;

  // Auto-scroll functionality
  final ScrollController flashDealsScrollController = ScrollController();
  Timer? _autoScrollTimer;
  var currentFlashDealIndex = 0.obs;
  var isScrolling = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  @override
  void onClose() {
    _autoScrollTimer?.cancel();
    flashDealsScrollController.dispose();
    super.onClose();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await ProductService().fetchProducts();
      productList.assignAll(products);
      filteredProducts.assignAll(products);

      // Start auto-scroll only if there are flash deals
      if (flashDeals.isNotEmpty) {
        startAutoScroll();
      }
    } finally {
      isLoading(false);
    }
  }

  // Product category getters
  List<Product> get mobileProducts =>
      productList.where((product) => product.category == 'Mobile').toList();

  List<Product> get laptopProducts =>
      productList.where((product) => product.category == 'Laptop').toList();

  List<Product> get flashDeals =>
      productList.where((product) => product.category == "FlashDeals").toList();

  // Search functionality
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

  // Auto-scroll methods
  void setupScrollListener() {
    flashDealsScrollController.addListener(() {
      if (flashDealsScrollController.position.pixels ==
          flashDealsScrollController.position.maxScrollExtent) {
        // When reached end, smoothly scroll back to start
        resetToStart();
      }
    });
  }

  void startAutoScroll() {
    _autoScrollTimer?.cancel();
    isScrolling(true);

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (flashDeals.isEmpty || !flashDealsScrollController.hasClients) return;

      if (currentFlashDealIndex.value >= flashDeals.length - 1) {
        resetToStart();
      } else {
        scrollToNextItem();
      }
    });
  }

  void scrollToNextItem() {
    currentFlashDealIndex.value++;
    flashDealsScrollController.animateTo(
      currentFlashDealIndex.value * 140.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void resetToStart() {
    currentFlashDealIndex.value = 0;
    flashDealsScrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void stopAutoScroll() {
    _autoScrollTimer?.cancel();
    isScrolling(false);
  }

  // Call this when user manually scrolls to stop auto-scroll temporarily
  void onManualScroll() {
    stopAutoScroll();
    // Optionally restart after some time
    Future.delayed(const Duration(seconds: 10), startAutoScroll);
  }
}
