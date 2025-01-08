import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/constants.dart';
import '../banner_with_counter.dart';
import 'banner_m.dart';

class BannerMWithCounter extends StatefulWidget {
  const BannerMWithCounter({
    super.key,
    required this.image,
    required this.text,
    required this.duration,
    required this.press,
  });

  final String image, text;
  final Duration duration;
  final VoidCallback press;

  @override
  State<BannerMWithCounter> createState() => _BannerMWithCounterState();
}

class _BannerMWithCounterState extends State<BannerMWithCounter> {
  late Duration _duration;
  late Timer _timer;

  @override
  void initState() {
    _duration = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: widget.image,
      press: widget.press,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppStrings.grandisExtendedFont,
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlurContainer(text: _duration.inHours.toString().padLeft(2, '0')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding / 4),
                  child: SvgPicture.asset(AppAssets.timerDivider),
                ),
                BlurContainer(text: _duration.inMinutes.remainder(60).toString().padLeft(2, '0')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding / 4),
                  child: SvgPicture.asset(AppAssets.timerDivider),
                ),
                BlurContainer(text: _duration.inSeconds.remainder(60).toString().padLeft(2, '0')),
              ],
            )
          ],
        ),
      ],
    );
  }
}
