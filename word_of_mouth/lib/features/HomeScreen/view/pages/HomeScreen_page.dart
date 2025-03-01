import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_snack_bar.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../controllers/HomeScreen_controller.dart';
import '../widgets/city_drop_down.dart';
import '../widgets/flash_sale.dart';
import '../widgets/offer_carousel_and_categories.dart';
import '../widgets/popular_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  Future<DocumentSnapshot>? _userFuture;

  @override
  void initState() {
    super.initState();
    userId = CacheHelper.getData(key: AppConstants.userId) as String?;
    _fetchUserData();
  }

  void _fetchUserData() {
    if (userId != null) {
      _userFuture = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
    }
  }

  Future<void> _updateCity(String newCity) async {
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({
        'address.city': newCity,
      });
      // Refresh the user data after updating the city
      setState(() {
        _fetchUserData();
      });
      CommonUI.showSnackBar('City updated to $newCity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final controller = Get.put(HomeScreenController());
            await controller.refreshAllData();
            setState(() {
              _fetchUserData();
            });
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: FutureBuilder<DocumentSnapshot>(
                  future: _userFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError || !snapshot.hasData) {
                      return const Center(child: Text('Error loading city'));
                    }

                    final userData = snapshot.data!.data() as Map<String, dynamic>;
                    final city = userData['address']['city'] as String;

                    return CityDropdownRow(
                      currentCity: city,
                      cities: const [
                        'NasrCityCairo',
                        'MaadiCairo',
                        'FaisalGiza',
                        'Alsharkyah',
                        'Aswan',
                      ],
                      onCityChanged: _updateCity,
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
              const SliverPadding(
                padding: EdgeInsets.symmetric(
                    vertical: AppConstants.defaultPadding * 1.5),
                sliver: SliverToBoxAdapter(child: FlashSale()),
              ),
              const SliverToBoxAdapter(child: PopularProducts()),
            ],
          ),
        ),
      ),
    );
  }
}
