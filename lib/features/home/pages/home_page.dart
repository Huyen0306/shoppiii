import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/banner_slider.dart';
import '../../../core/widgets/product_card.dart';
import '../data/repositories/product_repository.dart';
import '../data/models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductRepository _productRepository = ProductRepository();
  late Future<List<ProductModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _productRepository.getProducts();
  }

  // Helper to format currency
  String _formatPrice(double price) {
    // Basic wrapper to show USD or convert roughly to VND if preferred.
    // Keeping it simple as USD for this API.
    return '\$${price.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Custom Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              bottom: 10,
              left: 16,
              right: 16,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.redPrimary, Color(0xFFEF4444)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Iconsax.search_normal,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Tingoan Store',
                            style: TextStyle(
                              color: AppColors.redPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Icon(
                          Iconsax.camera,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Iconsax.bag_2, color: Colors.white, size: 26),
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '2',
                          style: TextStyle(
                            color: AppColors.redPrimary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  const SliverToBoxAdapter(child: BannerSlider()),
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        'GỢI Ý HÔM NAY',
                        style: TextStyle(
                          color: AppColors.redPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  FutureBuilder<List<ProductModel>>(
                    future: _productsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.redPrimary,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text('Error: ${snapshot.error}'),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(child: Text('No products found')),
                        );
                      }

                      final products = snapshot.data!;

                      return SliverMasonryGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            imageAspectRatio: index % 2 == 0 ? 1.0 : 0.90,
                            imageUrl: product.image,
                            title: product.title,
                            price: _formatPrice(product.price),
                            discount: index % 3 == 0 ? '-20%' : null,
                            rating: product.rating,
                            soldCount: product.count != null
                                ? '${product.count}'
                                : null,
                            shippingText: '3 - 5 Days',
                            isLive: index % 5 == 0,
                          );
                        },
                      );
                    },
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
