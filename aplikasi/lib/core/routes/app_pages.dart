import 'package:get/get.dart';

import 'package:aplikasi/modules/auth/bindings/auth_binding.dart';
import 'package:aplikasi/modules/auth/views/login_view.dart';


import 'package:aplikasi/modules/home/bindings/home_binding.dart';
import 'package:aplikasi/modules/home/views/home_view.dart';

import 'package:aplikasi/modules/transaction/bindings/transaction_binding.dart';
import 'package:aplikasi/modules/transaction/views/transaction_view.dart';

import 'package:aplikasi/modules/calculator/bindings/calculator_binding.dart';
import 'package:aplikasi/modules/calculator/views/calculator_view.dart';

import 'package:aplikasi/modules/stock/bindings/stock_binding.dart';
import 'package:aplikasi/modules/stock/views/stock_view.dart';
import 'package:aplikasi/modules/stock/views/add/add_perfume_view.dart';
import 'package:aplikasi/modules/stock/views/add/add_ingredient_view.dart';
import 'package:aplikasi/modules/stock/views/detail/detail_perfume_view.dart';
import 'package:aplikasi/modules/stock/views/detail/detail_ingredient_view.dart';
import 'package:aplikasi/modules/stock/views/edit/edit_perfume_view.dart';
import 'package:aplikasi/modules/stock/views/edit/edit_ingredient_view.dart';

import 'package:aplikasi/modules/barcode/bindings/barcode_binding.dart';
import 'package:aplikasi/modules/barcode/views/barcode_view.dart';

import 'package:aplikasi/modules/reports/bindings/reports_binding.dart';
import 'package:aplikasi/modules/reports/views/reports_view.dart';

import 'package:aplikasi/modules/account/bindings/account_binding.dart';
import 'package:aplikasi/modules/account/views/account_view.dart';

import 'package:aplikasi/modules/notification/bindings/notification_binding.dart';
import 'package:aplikasi/modules/notification/views/notification_view.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [

    GetPage(
      name: Routes.login,
      page: () => LoginView(),
      binding: AuthBinding(),
),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.transaction,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.calculator,
      page: () => const CalculatorView(),
      binding: CalculatorBinding(),
    ),

    GetPage(
      name: Routes.stock,
      page: () => const StockView(),
      binding: StockBinding(),
    ),

    GetPage(
      name: Routes.addPerfume,
      page: () => const AddPerfumeView(),
      binding: StockBinding(),
    ),
    GetPage(
      name: Routes.addIngredient,
      page: () => const AddIngredientView(),
      binding: StockBinding(),
    ),

    GetPage(
      name: Routes.detailPerfume,
      page: () => const DetailPerfumeView(),
      binding: StockBinding(),
    ),

    GetPage(
      name: Routes.detailIngredient,
      page: () => const DetailIngredientView(),
      binding: StockBinding(),
    ),

    GetPage(
      name: Routes.editPerfume,
      page: () => const EditPerfumeView(),
      binding: StockBinding(),
    ),
    GetPage(
      name: Routes.editIngredient,
      page: () => const EditIngredientView(),
      binding: StockBinding(),
    ),

    GetPage(
      name: Routes.barcode,
      page: () => const BarcodeView(),
      binding: BarcodeBinding(),
    ),

    GetPage(
      name: Routes.reports,
      page: () => const ReportsView(),
      binding: ReportsBinding(),
    ),

    GetPage(
      name: Routes.account,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),

    GetPage(
      name: Routes.notification,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
