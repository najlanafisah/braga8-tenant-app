import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? prefix;
  final bool isNumber;
  final bool readOnly;
  final int maxLines;
  final List<String>? dropdownItems;
  final String? dropdownValue;
  final Function(String?)? onDropdownChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.prefix,
    this.isNumber = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.dropdownItems,
    this.dropdownValue,
    this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10, left: 4),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        dropdownItems != null ? _buildDropdown() : _buildTextField(),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        prefixText: prefix,
        prefixStyle: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        hintText: hint,
        filled: true,
        fillColor: readOnly ? Color(0xFFD6C4BA) : Color(0xFFE5D1C5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }

  Widget _buildDropdown() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Color(0xFFE5D1C5),
      borderRadius: BorderRadius.circular(20),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        hint: Text(hint ?? "Pilih...", style: TextStyle(color: Colors.black54)),
        isExpanded: true,
        dropdownColor: Color(0xFFE5D1C5),
        icon: Icon(Icons.arrow_drop_down, color: Colors.black87),
        items: dropdownItems!.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(val, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          );
        }).toList(),
        onChanged: onDropdownChanged,
      ),
    ),
  );
}
}
