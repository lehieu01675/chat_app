import 'package:chatapp/src/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String) onSearch;

  const SearchBarWidget({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: 10.h,
      ),
      child: CustomTextFormField(
        prefixIcon: const Icon(Icons.search_outlined),
        controller: searchController,
        keyboardType: TextInputType.text,
        hintText: 'Search by ID',
        onChanged: (value) => onSearch,
      ),
    );
  }
}
