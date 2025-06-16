# Dhaka Shop - Flutter E-Commerce App

[![GitHub stars](https://img.shields.io/github/stars/robiulsunnyemon/dhaka-shop?style=social)](https://github.com/yourusername/dhaka-shop)
[![Build Status](https://img.shields.io/github/actions/workflow/status/robiulsunnyemon/dhaka-shop/flutter.yml)](https://github.com/yourusername/dhaka-shop/actions)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A full-featured e-commerce application built with Flutter, optimized for Bangladeshi users.

## 📸 Screenshots

<div align="center">
  <table>
    <tr>
      <td><img src="assets/screenshots/home.jpg" width="576" alt="Home Screen"></td>
      <td><img src="assets/screenshots/product_details.jpg" width="576" alt="Product Screen"></td>
      <td><img src="assets/screenshots/cart.jpg" width="576" alt="Cart Screen"></td>
    </tr>
    <tr>
      <td><img src="assets/screenshots/wishlist.jpg" width="576" alt="Wishlist"></td>
      <td><img src="assets/screenshots/checkout.jpg" width="576" alt="Checkout"></td>
      <td><img src="assets/screenshots/order_history.jpg" width="576" alt="Orders"></td>
    </tr>
    <tr>
      <td><img src="assets/screenshots/search.jpg" width="576" alt="Search"></td>
      <td><img src="assets/screenshots/profile.jpg" width="576" alt="Profile"></td>
      <td><img src="assets/screenshots/add_review.jpg" width="576" alt="Login"></td>
    </tr>
    <tr>
      <td><img src="assets/screenshots/category.jpg" width="576" alt="Search"></td>
      <td><img src="assets/screenshots/category_product.jpg" width="576" alt="Profile"></td>
      <td><img src="assets/screenshots/add_review.jpg" width="576" alt="Login"></td>
    </tr>
  </table>
</div>

## 🎥 Video Demo
[![Watch the demo](https://img.youtube.com/vi/YOUR_VIDEO_ID/0.jpg)](https://youtu.be/bwxqJI3y98Q?si=k1NZLci5QJXTpSO_)

## ✨ Features

- **Product Browsing**: Browse products by categories
- **Search Functionality**: Quick product search
- **Wishlist**: Save favorite products
- **Cart System**: Add products to cart
- **Order Management**: Track your orders
- **Profile Management**: Update user profile
- **Rating System**: 5-star rating implementation

## 🛠️ Technologies

- **Frontend**: Flutter (Dart)
- **State Management**: GetX
- **Local Storage**: SharedPreferences, GetStorage
- **Image Loading**: CachedNetworkImage
- **API Client**: Dio/Http
- **Dependency Management**: Pub

## 🚀 Installation

```bash
git clone https://github.com/robiulsunnyemon/dhaka_shop.git
cd dhaka-shop
flutter pub get
flutter run
```
## 📂 Project Structure
```
lib/
├── app/
│   ├── modules/
│   │   ├── home/
│   │   ├── product/
│   │   ├── cart/
│   │   ├── wishlist/
│   │   └── ...
│   ├── routes/
│   └── widgets/
├── data/
│   ├── model/
│   └── services/
└── main.dart

```
## 💻 Key Code Snippets
### Product Card with 5-Star Rating
```
// lib/app/component/product_card.dart

ProductCard(
  product: product,
  rating: 5.0, // Fixed 4-star rating
)
```
### GetX Controller
```
// lib/app/modules/home/controllers/home_controller.dart

class HomeController extends GetxController {
  final products = <Product>[].obs;
  // ...
}
```
## 🤝 Contributing Fork the repository

- Create your feature branch (git checkout -b feature/AmazingFeature)

- Commit your changes (git commit -m 'Add some AmazingFeature')

- Push to the branch (git push origin feature/AmazingFeature)

- Open a Pull Request

## 📄 License
#### Distributed under the MIT License. See LICENSE for more information.

- ✉️ Contact
- Email: robiulsunnyemon11@gmail.com

GitHub: @robiulsunnyemon