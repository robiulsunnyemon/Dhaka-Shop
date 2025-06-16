// // lib/widgets/product_card.dart
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dhaka_shop/app/modules/wishlist/controllers/wishlist_controller.dart';
// import 'package:dhaka_shop/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../data/model/product_model.dart';
//
//
// class ProductCard extends StatelessWidget {
//   final Product product;
//
//    ProductCard({
//     super.key,
//     required this.product,
//   });
//
//   final  wishlistController=Get.find<WishlistController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//         Get.toNamed(Routes.PRODUCT_DETAILS,arguments: product);
//       },
//       child: Card(
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Stack(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Expanded(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//                     child: CachedNetworkImage(
//                       imageUrl: product.image,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => Shimmer.fromColors(
//                         baseColor: Colors.grey[300]!,
//                         highlightColor: Colors.grey[100]!,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//                           ),
//                         ),
//                       ),
//                       errorWidget: (context, url, error) => Container(
//                         color: Colors.grey[200],
//                         child: Icon(Icons.error_outline, color: Colors.red),
//                       ),
//                       fadeInDuration: Duration(milliseconds: 300),
//                       fadeInCurve: Curves.easeIn,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         product.title,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         '\$${product.price.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               top: -3,
//               right: -3,
//               child: IconButton(
//                 icon: Obx(()=>Icon(
//                   wishlistController.isWishListed(product)?
//                   Icons.favorite : Icons.favorite_border,
//                   color: wishlistController.isWishListed(product)? Colors.red : Colors.grey[600],
//                 ),),
//                 onPressed: (){
//                   wishlistController.toggleWishlist(product);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhaka_shop/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:dhaka_shop/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../data/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double rating; // Add rating parameter

  ProductCard({
    super.key,
    required this.product,
    this.rating = 4.0, // Default to 4 stars
  });

  final wishlistController = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product);
      },
      child: Card(
        color: Colors.green.withValues(alpha: .1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.error_outline, color: Colors.red),
                      ),
                      fadeInDuration: Duration(milliseconds: 300),
                      fadeInCurve: Curves.easeIn,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      // Star Rating Row
                      Row(
                        children: [
                          // Display 4 stars (or your fixed rating)
                          ...List.generate(5, (index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 12,
                          )),
                          SizedBox(width: 4),
                          Text(
                            '4.0', // Display the rating value
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -3,
              right: -3,
              child: IconButton(
                icon: Obx(() => Icon(
                  wishlistController.isWishListed(product)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: wishlistController.isWishListed(product)
                      ? Colors.red
                      : Colors.grey[600],
                )),
                onPressed: () {
                  wishlistController.toggleWishlist(product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}