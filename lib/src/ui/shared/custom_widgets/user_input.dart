// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';

// ignore: must_be_immutable
class UserInput extends StatefulWidget {
  UserInput(
      {super.key,
      required this.text,
      this.controller,
      this.validator,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.borderRadius,
      this.onSubmitted,
      this.keyboardType,
      this.maxLength,
      this.prefixText,
      this.height,
      this.onChange,
      this.borderColor,
      this.enabled,
      this.fillColor});
  bool? obscureText;
  final Icon? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String text;
  final BorderRadius? borderRadius;
  final TextEditingController? controller;
  final double? height;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final int? maxLength;
  final String? prefixText;
  final Color? fillColor;
  final bool? enabled;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChange;
  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  bool _obscureText = false;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    bool isFieldEmpty = widget.controller?.text.isEmpty ?? true;

    return Padding(
        padding: EdgeInsets.only(top: height * 0.0),
        child: SizedBox(
          height: widget.height,
          child: TextFormField(
            enabled: widget.enabled,
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChange,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            onFieldSubmitted: widget.onSubmitted,
            scrollPadding: EdgeInsets.all(0),
            style: TextStyle(
              color: Get.theme.colorScheme.secondary,
            ),
            obscureText: _obscureText,
            textInputAction: TextInputAction.next,
            validator: widget.validator,
            controller: widget.controller,
            cursorColor: Get.theme.colorScheme.secondary,
            decoration: InputDecoration(
              suffixIcon: widget.obscureText!
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black,
                      ),
                    )
                  : widget.suffixIcon,
              hintText: isFieldEmpty && !_focusNode.hasFocus ? widget.text : '',
              prefixIcon: widget.prefixIcon,
              prefixIconColor: Get.theme.colorScheme.secondary,
              hintStyle: TextStyle(
                fontSize: context.screenWidth(33),
                color: Get.theme.colorScheme.secondary,
              ),
              filled: true,
              focusedBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: widget.borderRadius ??
                      BorderRadius.all(
                        Radius.circular(8),
                      ),
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedErrorBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: widget.borderRadius ??
                      BorderRadius.all(
                        Radius.circular(8),
                      ),
                  borderSide: BorderSide(
                    color: Colors.red,
                  )),
              errorBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: widget.borderRadius ??
                      BorderRadius.all(
                        Radius.circular(8),
                      ),
                  borderSide: BorderSide(
                    color: Colors.red,
                  )),
              enabledBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: widget.borderRadius ??
                      BorderRadius.all(
                        Radius.circular(8),
                      ),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.transparent,
                  )),
              border: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: widget.borderRadius ??
                      BorderRadius.all(
                        Radius.circular(8),
                      ),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.transparent,
                  )),
              disabledBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: widget.borderRadius ??
                      BorderRadius.all(
                        Radius.circular(8),
                      ),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.transparent,
                  )),
              fillColor: widget.fillColor ?? Colors.white,
              prefixText: widget.prefixText,
              prefixStyle: TextStyle(color: Colors.grey),
            ),
            maxLength: widget.maxLength,
          ),
        ));
  }
}
