import 'package:flutter/material.dart';

import '../../../../core/animations/animation_do.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import 'categories.dart';
import 'offers_carousel.dart';

class OffersCarouselAndCategories extends StatelessWidget {
  const OffersCarouselAndCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OffersCarousel(),
        SlideInRight(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Text(
              AppStrings.categories,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        const Categories(),
      ],
    );
  }
}
