import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import 'offers_carousel.dart';

class OffersCarouselAndCategories extends StatelessWidget {
  const OffersCarouselAndCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OffersCarousel(),
        SizedBox(height: AppConstants.defaultPadding / 2),
        // Padding(
        //   padding: const EdgeInsets.all(AppConstants.defaultPadding),
        //   child: Text(
        //     AppStrings.categories,
        //     style: Theme.of(context).textTheme.titleSmall,
        //   ),
        // ),
        // const Categories(),
      ],
    );
  }
}
