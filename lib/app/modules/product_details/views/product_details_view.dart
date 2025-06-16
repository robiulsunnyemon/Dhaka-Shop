import 'package:dhaka_shop/app/modules/cart/controllers/cart_controller.dart';
import 'package:dhaka_shop/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:dhaka_shop/app/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/product_model.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({super.key});

  final Product product = Get.arguments as Product;
  final cartController = Get.find<CartController>();
  final themeController = Get.find<ThemeController>();
  final wishlistController = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildProductImageAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductTitleAndPrice(),
                  const SizedBox(height: 16),
                  _buildDescriptionSection(),
                  const SizedBox(height: 24),
                  _buildAddToCartButton(),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  if (product.specifications != null) _buildSpecificationsSection(),
                  _buildReviewsSection(),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 300),
          ),
        ],
      ),
    );
  }

  // AppBar with Product Image
  SliverAppBar _buildProductImageAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          product.image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.grey[200],
            child: const Icon(Icons.broken_image, size: 100),
          ),
        ),
      ),
      pinned: true,
      floating: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      actions: [
        Obx(() => IconButton(
          icon: Icon(
            wishlistController.isWishListed(product)
                ? Icons.favorite
                : Icons.favorite_border,
            color: wishlistController.isWishListed(product)
                ? Colors.red
                : Colors.white,
          ),
          onPressed: () => wishlistController.toggleWishlist(product),
        )),
      ],
    );
  }

  // Product Title and Price Row
  Widget _buildProductTitleAndPrice() {
    return Row(
      children: [
        Expanded(
          child: Text(
            product.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Description Section
  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Add to Cart Button
  Widget _buildAddToCartButton() {
    return Obx(() => SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        label: Text(
          cartController.isProductInCart(product)
              ? 'Already in Cart'
              : 'Add to Cart',
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (!cartController.isProductInCart(product)) {
            cartController.addToCart(product);
            Get.snackbar(
              'Success',
              '${product.title} added to cart',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: cartController.isProductInCart(product)
              ? Colors.grey
              : Theme.of(Get.context!).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ));
  }

  // Specifications Section
  Widget _buildSpecificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildSpecItem('Category', product.category),
        _buildSpecItem('Display', product.specifications!.display),
        _buildSpecItem('Processor', product.specifications!.processor),
        _buildSpecItem('RAM', product.specifications!.ram),
        _buildSpecItem('Storage', product.specifications!.storage),
        _buildSpecItem('Battery', product.specifications!.battery),
        if (product.specifications!.camera != null)
          _buildSpecItem('Camera', product.specifications!.camera!),
        if (product.specifications!.os != null)
          _buildSpecItem('OS', product.specifications!.os!),
        if (product.specifications!.connectivity != null)
          _buildSpecItem('Connectivity', product.specifications!.connectivity!),
        if (product.specifications!.specialFeatures != null)
          _buildSpecItem('Features', product.specifications!.specialFeatures!),
        if (product.specifications!.dimensions != null)
          _buildSpecItem('Dimensions', product.specifications!.dimensions!),
        const SizedBox(height: 16),
      ],
    );
  }

  // Specification Item Row
  Widget _buildSpecItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // Reviews Section
  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 16),
        if (product.reviews.isNotEmpty) ...[
          const Text(
            'Customer Reviews',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              for (var review in product.reviews)
                _buildReviewCard(review),
              const SizedBox(height: 16),
              _buildAddReviewButton(),
            ],
          ),
        ] else ...[
          const Text(
            'No Reviews Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('Be the first to review this product!'),
          _buildAddReviewButton(),
        ],
      ],
    );
  }

  // Review Card
  Widget _buildReviewCard(Review review) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.author,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                _buildRatingStars(review.rating),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Rating Stars
  Widget _buildRatingStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 18,
        );
      }),
    );
  }

  // Add Review Button
  Widget _buildAddReviewButton() {
    return OutlinedButton(
      onPressed: _showReviewBottomSheet,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(color: Colors.deepOrangeAccent),
      ),
      child: const Text('Write a Review'),
    );
  }

  // Review Bottom Sheet
  void _showReviewBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16),),
          color: Get.theme.cardColor
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Your Review',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,

                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: const OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Rating:',
                  ),
                  const SizedBox(width: 8),
                  _buildRatingStars(3),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Your Review',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                  Get.snackbar('Success', 'Review submitted!');
                },
                child: const Text('Submit Review'),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}