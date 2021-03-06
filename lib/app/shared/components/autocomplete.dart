import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomAutocomplete extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Function onSuggestionSelected;
  final Function suggestionsCallback;
  final Widget? leading;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const CustomAutocomplete({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    required this.onSuggestionSelected,
    required this.suggestionsCallback,
    this.leading,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Material(
        elevation: 12,
        borderRadius: BorderRadius.circular(24),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            focusNode: focusNode,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(style: BorderStyle.none),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(style: BorderStyle.none),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(style: BorderStyle.none),
              ),
            ),
          ),
          itemBuilder: (BuildContext context, dynamic itemData) {
            return ListTile(
              leading: leading,
              title: Text(
                itemData.description,
              ),
            );
          },
          onSuggestionSelected: (suggestion) {
            onSuggestionSelected(suggestion);
          },
          suggestionsCallback: (String pattern) async {
            return await suggestionsCallback(pattern);
          },
        ),
      ),
    );
  }
}
