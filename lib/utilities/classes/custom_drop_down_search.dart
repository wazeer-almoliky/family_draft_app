import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomDropDownSearch extends StatelessWidget {
  final EdgeInsetsGeometry? padding, margin;
  final List<dynamic> items;
  final String? labelText, hintText;
  final Function(dynamic)? onChanged;
  final Future<List<dynamic>> Function(String)? asyncItems;
  final bool? enabled, isSearch;
  const CustomDropDownSearch(
      {super.key,
      this.padding,
      this.margin,
      required this.items,
      this.labelText,
      this.hintText,
      this.onChanged,
      this.asyncItems,
      this.enabled = true,
      this.isSearch = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: DropdownSearch(
        popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            showSearchBox: isSearch != true ? false : true,
            menuProps: const MenuProps(
              elevation: 0,
              barrierCurve: Curves.ease,
            ),
            searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical:0),
                  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  focusedBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))))),
        items: items,
        asyncItems: asyncItems,
        enabled: enabled!,
        // dropdownButtonProps:DropdownButtonProps() ,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              labelText: labelText,
              hintText: hintText,
              // constraints:const BoxConstraints(maxWidth: 250),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)))),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
