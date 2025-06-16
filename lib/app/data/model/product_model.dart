class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final Specifications? specifications; // Nullable
  final List<Review> reviews; // Empty list if null

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    this.specifications,
    List<Review>? reviews,
  }) : reviews = reviews ?? [];

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0, // Provide default if null
      title: json['title'] as String? ?? 'No Title',
      description: json['description'] as String? ?? 'No Description',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? '',
      category: json['category'] as String? ?? 'Uncategorized',
      specifications: json['specifications'] != null
          ? Specifications.fromJson(json['specifications'] as Map<String, dynamic>)
          : null,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
          .map((review) => Review.fromJson(review as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'specifications': specifications?.toJson(),
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}

class Specifications {
  final String display;
  final String processor;
  final String ram;
  final String storage;
  final String battery;
  final String? camera; // Nullable
  final String? os; // Nullable
  final String? connectivity; // Nullable
  final String? specialFeatures; // Nullable
  final String? dimensions; // Nullable

  Specifications({
    required this.display,
    required this.processor,
    required this.ram,
    required this.storage,
    required this.battery,
    this.camera,
    this.os,
    this.connectivity,
    this.specialFeatures,
    this.dimensions,
  });

  factory Specifications.fromJson(Map<String, dynamic> json) {
    return Specifications(
      display: json['Display'] as String? ?? 'N/A',
      processor: json['Processor'] as String? ?? 'N/A',
      ram: json['RAM'] as String? ?? 'N/A',
      storage: json['Storage'] as String? ?? 'N/A',
      battery: json['Battery'] as String? ?? 'N/A',
      camera: json['Camera'] as String? ?? json['Rear Camera'] as String?,
      os: json['OS'] as String?,
      connectivity: json['Connectivity'] as String?,
      specialFeatures: json['Special Features'] as String?,
      dimensions: json['Dimensions'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Display': display,
      'Processor': processor,
      'RAM': ram,
      'Storage': storage,
      'Battery': battery,
      if (camera != null) 'Camera': camera,
      if (os != null) 'OS': os,
      if (connectivity != null) 'Connectivity': connectivity,
      if (specialFeatures != null) 'Special Features': specialFeatures,
      if (dimensions != null) 'Dimensions': dimensions,
    };
  }
}

class Review {
  final String author;
  final int rating;
  final String comment;

  Review({
    required this.author,
    required this.rating,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'] as String? ?? 'Anonymous',
      rating: json['rating'] as int? ?? 0,
      comment: json['comment'] as String? ?? 'No comment',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'rating': rating,
      'comment': comment,
    };
  }
}