import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.onChanged,
    this.suffixIcon,
    this.enabled = true,
    this.validator,
    this.keyboardType,
  });

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscure = false;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void didUpdateWidget(CustomInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller.dispose();
      _controller = widget.controller ?? TextEditingController();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  enabled: widget.enabled,
                  obscureText: _obscure,
                  onChanged: widget.onChanged,
                  validator: widget.validator,
                  keyboardType: widget.keyboardType,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              if (widget.obscureText || widget.suffixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: widget.suffixIcon ??
                      IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: widget.enabled
                            ? () => setState(() => _obscure = !_obscure)
                            : null,
                      ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
