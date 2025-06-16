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
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.broken_image, size: 100),
                ),
              ),
            ),
            pinned: true,
            floating: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title and Price
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Description Section
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),

                  // Add to Cart Button
                  Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      label: Text(
                        cartController.isProductInCart(product)
                            ? 'Already in Cart'
                            : 'Add to Cart',
                        style: TextStyle(color: Colors.white),
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
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: cartController.isProductInCart(product)
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),

                  // Specifications Section

                  if (product.specifications != null) ...[
                    Text(
                      'Specifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildSpecItem('Category', product.category),
                    if (product.specifications!.display != null)
                      _buildSpecItem('Display', product.specifications!.display),
                    if (product.specifications!.processor != null)
                      _buildSpecItem('Processor', product.specifications!.processor),
                    if (product.specifications!.ram != null)
                      _buildSpecItem('RAM', product.specifications!.ram),
                    if (product.specifications!.storage != null)
                      _buildSpecItem('Storage', product.specifications!.storage),
                    if (product.specifications!.battery != null)
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
                    SizedBox(height: 16),
                  ],

                  if (product.reviews.isNotEmpty) ...[
                    Divider(),
                    SizedBox(height: 16),
                    Text(
                      'Customer Reviews',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Column(
                      children: [
                        for (var review in product.reviews)
                          _buildReviewCard(review),
                        SizedBox(height: 16),
                        _buildAddReviewButton(),
                      ],
                    ),
                  ] else ...[
                    Divider(),
                    SizedBox(height: 16),
                    Text(
                      'No Reviews Yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Be the first to review this product!'),
                    _buildAddReviewButton(),
                  ],

                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSpecItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
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
          SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.author,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                _buildRatingStars(review.rating),
              ],
            ),
            SizedBox(height: 8),
            Text(
              review.comment,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

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

  Widget _buildAddReviewButton() {
    return OutlinedButton(
      onPressed: () {
        // Implement review submission logic
        // Get.bottomSheet(
        //     Container(
        //       padding: EdgeInsets.all(16),
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        //         child: SingleChildScrollView(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Text(
        //                 'Add Your Review',
        //                 style: TextStyle(
        //                   fontSize: 18,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //               SizedBox(height: 16),
        //               TextField(
        //                 decoration: InputDecoration(
        //                   labelText: 'Your Name',
        //                   border: OutlineInputBorder(),
        //                 ),
        //               ),
        //               SizedBox(height: 16),
        //               Row(
        //                 children: [
        //                   Text('Rating:'),
        //                   SizedBox(width: 8),
        //                   _buildRatingStars(3), // Default 3 stars
        //                   // Implement interactive star rating here
        //                 ],
        //               ),
        //               SizedBox(height: 16),
        //               TextField(
        //                 maxLines: 3,
        //                 decoration: InputDecoration(
        //                   labelText: 'Your Review',
        //                   border: OutlineInputBorder(),
        //                 ),
        //               ),
        //               SizedBox(height: 16),
        //               ElevatedButton(
        //                 onPressed: () {
        //                   // Submit review logic
        //                   Get.back();
        //                   Get.snackbar('Success', 'Review submitted!');
        //                 },
        //                 child: Text('Submit Review'),
        //               ),
        //             ],
        //           ),
        //         ),
        //     )
        // );
        Get.bottomSheet(
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ThemeController.to.isDarkMode
                  ? Colors.grey[900]  // Dark theme color
                  : Colors.white,     // Light theme color
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                      color: ThemeController.to.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      labelStyle: TextStyle(
                        color: ThemeController.to.isDarkMode
                            ? Colors.grey[300]
                            : Colors.grey[700],
                      ),
                      border: OutlineInputBorder(),
                      filled: ThemeController.to.isDarkMode,
                      fillColor: ThemeController.to.isDarkMode
                          ? Colors.grey[800]
                          : null,
                    ),
                    style: TextStyle(
                      color: ThemeController.to.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Rating:',
                        style: TextStyle(
                          color: ThemeController.to.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                      _buildRatingStars(3),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Your Review',
                      labelStyle: TextStyle(
                        color: ThemeController.to.isDarkMode
                            ? Colors.grey[300]
                            : Colors.grey[700],
                      ),
                      border: OutlineInputBorder(),
                      filled: ThemeController.to.isDarkMode,
                      fillColor: ThemeController.to.isDarkMode
                          ? Colors.grey[800]
                          : null,
                    ),
                    style: TextStyle(
                      color: ThemeController.to.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeController.to.isDarkMode
                          ? Colors.greenAccent[400]
                          : Colors.green,
                      foregroundColor: ThemeController.to.isDarkMode
                          ? Colors.black
                          : Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                      Get.snackbar('Success', 'Review submitted!');
                    },
                    child: Text('Submit Review'),
                  ),
                ],
              ),
            ),
          ),
          isScrollControlled: true,
        );

        },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(color: Colors.deepOrangeAccent),
      ),
      child: Text('Write a Review'),
    );
  }
}