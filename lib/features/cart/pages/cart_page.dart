import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/data/models/product_model.dart'; // Reusing for "You might like"
import '../../home/data/repositories/product_repository.dart';
import '../../../core/widgets/product_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Mock Data for Recommendations
  final ProductRepository _productRepository = ProductRepository();
  late Future<List<ProductModel>> _recommendationsFuture;

  @override
  void initState() {
    super.initState();
    _recommendationsFuture = _productRepository.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Giỏ hàng (22)',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Sửa', style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(width: 8),
          const Icon(Iconsax.message, color: AppColors.redPrimary, size: 24),
          const SizedBox(width: 16),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. Invalid Products Section (as seen in image)
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sản phẩm không tồn tại (2)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Sửa',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildInvalidItem(
                    title: 'Mascara chuốt mi 3D Sợi Mảnh Suake Full Bo...',
                    variant: 'C2, Chính hãng',
                    price: '12.000đ',
                    imageUrl: 'assets/images/shoppiii.png',
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          // 2. "You may also like" Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Có thể bạn cũng thích',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
            ),
          ),

          // 3. Recommendation Grid
          FutureBuilder<List<ProductModel>>(
            future: _recommendationsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.redPrimary,
                    ),
                  ),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
              final products = snapshot.data!;
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverMasonryGrid.count(
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
                      price: '\$${product.price}',
                      discount: index % 3 == 0 ? '-20%' : null,
                      rating: product.rating,
                      soldCount: product.count != null
                          ? '${product.count}'
                          : null,
                      shippingText: '3 - 5 Days',
                      isLive: index % 5 == 0,
                    );
                  },
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (v) {},
                  activeColor: AppColors.redPrimary,
                ),
                const Text('Tất cả'),
              ],
            ),
            const Spacer(),
            const Text('Tổng thanh toán: ', style: TextStyle(fontSize: 12)),
            const Text(
              '0đ',
              style: TextStyle(
                color: AppColors.redPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Mua hàng (0)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvalidItem({
    required String title,
    required String variant,
    required String price,
    required String imageUrl,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: const Text(
                'Bán hết',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      variant,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 14,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.redPrimary,
                      side: const BorderSide(color: AppColors.redPrimary),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0,
                      ),
                      minimumSize: const Size(0, 28),
                    ),
                    child: const Text(
                      'Tìm sản phẩm tương tự',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
