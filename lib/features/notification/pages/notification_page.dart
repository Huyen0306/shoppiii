import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/cart_service.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.redPrimary, Color(0xFFEF4444)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          Consumer<CartService>(
            builder: (context, cartService, child) {
              final cartCount = cartService.totalItems;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Iconsax.bag_2, color: Colors.white, size: 26),
                  if (cartCount > 0)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cartCount > 99 ? '99+' : '$cartCount',
                          style: const TextStyle(
                            color: AppColors.redPrimary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 16),
          const Icon(Iconsax.message, color: Colors.white, size: 24),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 200),
        children: [
          _buildCategoryItem(
            icon: Iconsax.discount_shape,
            iconColor: Colors.orange,
            title: 'Khuyến mãi',
            subtitle: 'Voucher cho đơn từ 0Đ, thỏa sức mua sắm...',
            badgeCount: 14,
          ),
          _buildCategoryItem(
            icon: Iconsax.video_play,
            iconColor: Colors.teal,
            title: 'Live & Video',
            subtitle: 'Trăm ngàn deal đình giảm đến 50%',
            badgeCount: 1,
          ),
          _buildCategoryItem(
            icon: Iconsax.bag_2,
            iconColor: Colors.deepOrange,
            title: 'Cập nhật Shopee',
            subtitle: 'Dành ít phút chia sẻ cùng Shopee TẠI ĐÂY đ...',
            badgeCount: 5,
          ),
          _buildCategoryItem(
            icon: Iconsax.gift,
            iconColor: Colors.blue,
            title: 'Giải Thưởng Shopee',
            subtitle: 'Duy nhất hôm nay tại Quà tặng Shopee Xu',
            badgeCount: 10,
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFFF5F5F5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cập nhật đơn hàng',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Đọc tất cả (6)',
                  style: TextStyle(color: AppColors.redPrimary, fontSize: 14),
                ),
              ],
            ),
          ),

          _buildOrderUpdateItem(
            imageUrl: 'assets/images/shoppiii.png', // Temporary Use App Logo
            status: 'Dang vận chuyển',
            description:
                'Đơn hàng 2601020R9KHJV2 với mã vận đơn SPXVN068129387051 đã được Người bán Focallure Official Store giao cho đơn vị vận chuyển qua phương thức vận chuyển SPX Express.',
            time: '18:38',
            isRead: false,
          ),
          _buildOrderUpdateItem(
            imageUrl: 'assets/images/shoppiii.png',
            status: 'Giao kiện hàng thành công',
            description:
                'Kiện hàng SPXVN05069154154C của đơn hàng 251226CSFW3WGY đã giao thành công đến bạn.',
            time: '12:39 28-12-2025',
            isRead: true,
          ),
          _buildOrderUpdateItem(
            imageUrl: 'assets/images/shoppiii.png',
            status: 'Giao kiện hàng thành công',
            description:
                'Kiện hàng GYDMR43T của đơn hàng 25122109V1X5PS đã giao thành công đến bạn.',
            time: '14:52 24-12-2025',
            isRead: true,
          ),
          _buildOrderUpdateItem(
            imageUrl: 'assets/images/shoppiii.png',
            status: 'Giao kiện hàng thành công',
            description: 'Kiện hàng của đơn hàng đã giao thành công.',
            time: '10:00 20-12-2025',
            isRead: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required int badgeCount,
  }) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[500], fontSize: 13),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Custom Red Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.redPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badgeCount > 99 ? '99+' : badgeCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
              ],
            ),
            onTap: () {},
          ),
          Divider(height: 1, color: Colors.grey[100], indent: 72),
        ],
      ),
    );
  }

  Widget _buildOrderUpdateItem({
    required String imageUrl,
    required String status,
    required String description,
    required String time,
    required bool isRead,
  }) {
    return Container(
      color: isRead
          ? Colors.white
          : const Color(0xFFFFF8F8), // Highlights unread
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500, // Medium weight
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Colors.grey[600],
                    ),
                    children: _parseDescription(description),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
              ],
            ),
          ),
          const Icon(Icons.expand_more, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  // Helper to parse and colorize specific keywords
  List<TextSpan> _parseDescription(String text) {
    // Keywords/Patterns to highlight in Green
    // 1. Tracking Codes: SPXVN..., GYD...
    // 2. Carriers: SPX Express, Focallure Official Store
    final RegExp gradientPattern = RegExp(
      r'(SPXVN[A-Z0-9]+|GYD[A-Z0-9]+|SPX Express|Focallure Official Store)',
      caseSensitive: false,
    );

    final List<TextSpan> spans = [];

    text.splitMapJoin(
      gradientPattern,
      onMatch: (Match match) {
        spans.add(
          TextSpan(
            text: match.group(0),
            style: const TextStyle(
              color: Color(0xFF00BFA5), // Teal/Green color from image
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        return '';
      },
      onNonMatch: (String nonMatch) {
        spans.add(TextSpan(text: nonMatch));
        return '';
      },
    );

    return spans;
  }
}
