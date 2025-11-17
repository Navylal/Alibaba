import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../transaction/controllers/transaction_controller.dart';
import '../../../core/theme/controller/theme_controller.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/menu_button.dart';
import '../widgets/stat_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  void navigateWithAnimation(String route) {
    Get.toNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final txController = Get.find<TransactionController>();
    final themeC = Get.find<ThemeController>();
    final authC = Get.find<AuthController>();

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isAdmin = authC.role == "admin";

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          'Welcome back, ${authC.displayRole}!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,

        actions: [
          PopupMenuButton<String>(
            color: theme.colorScheme.surface,
            icon: Icon(
              Icons.menu,
              color: theme.colorScheme.onSurface,
            ),
            onSelected: (value) {
              switch (value) {
                case 'theme':
                  themeC.toggleTheme();
                  break;

                case 'account':
                  Nav.toNamed(Routes.account);
                  break;

                case 'notification':
                  Nav.toNamed(Routes.notification);
                  break;

                case 'logout':
                  Get.defaultDialog(
                    title: 'Log Out',
                    middleText: 'Are you sure you want to log out?',
                    textCancel: 'Cancel',
                    textConfirm: 'Log Out',
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.back();
                      authC.logout();
                    },
                  );
                  break;
              }
            },

            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'theme',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dark Mode',
                        style: TextStyle(color: theme.colorScheme.onSurface)),
                    Obx(() => Switch(
                          value: themeC.isDark.value,
                          onChanged: (v) => themeC.toggleTheme(),
                        )),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'account',
                child: Text('Account',
                    style: TextStyle(color: theme.colorScheme.onSurface)),
              ),
              PopupMenuItem(
                value: 'notification',
                child: Text('Notification',
                    style: TextStyle(color: theme.colorScheme.onSurface)),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Text('Log Out',
                    style: TextStyle(color: theme.colorScheme.onSurface)),
              ),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Alibaba Perfume Management System",
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                fontSize: isTablet ? 18 : 14,
              ),
            ),

            const SizedBox(height: 16),

            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 700;
                final cardWidth = isWide
                    ? (constraints.maxWidth / 2) - 12
                    : constraints.maxWidth;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: Obx(() => StatCard(
                            title: "Product in Stock",
                            value: controller.stockCount.value.toString(),
                            textColor: Colors.blue,
                          )),
                    ),

                    SizedBox(
                      width: cardWidth,
                      child: Obx(() {
                        final totalSales = txController.transactions
                            .where((tx) => tx.type == "sale")
                            .fold<int>(0, (sum, tx) => sum + tx.price);

                        return StatCard(
                          title: "Today's Sales",
                          value: "Rp $totalSales",
                          textColor: Colors.green,
                        );
                      }),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            MenuButton(
              icon: Icons.attach_money,
              title: "Transaction",
              subtitle: "Record sales and purchases",
              color: Colors.green,
              onTap: () => navigateWithAnimation(Routes.transaction),
              isDark: isDark,
            ),

            MenuButton(
              icon: Icons.calculate,
              title: "Price Calculator",
              subtitle: "Calculate prices by volume",
              color: Colors.orange,
              onTap: () => navigateWithAnimation(Routes.calculator),
              isDark: isDark,
            ),

            if (isAdmin) ...[
              MenuButton(
                icon: Icons.inventory,
                title: "Stock Management",
                subtitle: "Manage perfume inventory",
                color: Colors.blue,
                onTap: () => navigateWithAnimation(Routes.stock),
                isDark: isDark,
              ),

              MenuButton(
                icon: Icons.bar_chart,
                title: "Reports",
                subtitle: "View performance report",
                color: Colors.red,
                onTap: () => navigateWithAnimation(Routes.reports),
                isDark: isDark,
              ),
            ],

            MenuButton(
              icon: Icons.qr_code,
              title: "Barcode",
              subtitle: "Perfume barcode",
              color: Colors.purple,
              onTap: () => navigateWithAnimation(Routes.barcode),
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}
