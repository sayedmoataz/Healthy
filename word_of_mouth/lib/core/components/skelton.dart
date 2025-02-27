import 'package:flutter/material.dart';

import '../utils/constants.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    this.height,
    this.width,
    this.layer = 1,
    this.radious = AppConstants.defaultPadding,
  });

  final double? height, width;
  final int layer;
  final double radious;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(AppConstants.defaultPadding / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).iconTheme.color!.withValues(alpha: 0.04 * layer),
        borderRadius: BorderRadius.all(Radius.circular(radious))
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).iconTheme.color!.withValues(alpha: 0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}