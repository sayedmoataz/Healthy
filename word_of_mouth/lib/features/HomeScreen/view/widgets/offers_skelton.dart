import 'package:flutter/material.dart';

import '../../../../core/components/skelton.dart';
import '../../../../core/utils/constants.dart';

class OffersSkelton extends StatelessWidget {
  const OffersSkelton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.87,
      child: Stack(
        children: [
          const Skeleton(),
          const Positioned.fill(
            left: AppConstants.defaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(
                  width: 140,
                  height: 20,
                ),
                SizedBox(height: AppConstants.defaultPadding / 2),
                Skeleton(
                  width: 200,
                  height: 20,
                ),
              ],
            ),
          ),
          Positioned(
            right: AppConstants.defaultPadding,
            bottom: AppConstants.defaultPadding,
            child: Row(
              children: List.generate(
                4,
                (index) => const Padding(
                  padding: EdgeInsets.only(left: AppConstants.defaultPadding / 4),
                  child: CircleSkeleton(size: 8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}