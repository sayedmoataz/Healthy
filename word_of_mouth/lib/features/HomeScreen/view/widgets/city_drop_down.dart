import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/constants.dart';

class CityDropdownRow extends StatelessWidget {
  final String currentCity;
  final List<String> cities;
  final Function(String) onCityChanged;

  const CityDropdownRow({
    Key? key,
    required this.currentCity,
    required this.cities,
    required this.onCityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.defaultPadding / 2,
      ),
      child: Row(
        children: [
          Text(
            'Deliver To: ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(width: 10.w),
          DropdownButton<String>(
            value: currentCity,
            onChanged: (String? newValue) {
              if (newValue != null) {
                onCityChanged(newValue);
              }
            },
            items: cities.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
