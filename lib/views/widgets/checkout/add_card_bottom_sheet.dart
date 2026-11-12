import 'package:e_commerce/utilities/context_extension.dart';
import 'package:e_commerce/views/widgets/checkout/card_month_input_formatter.dart';
import 'package:e_commerce/views/widgets/checkout/card_number_input_formatter.dart';
import 'package:e_commerce/views/widgets/main_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class AddCardBottomSheet extends StatefulWidget {
  const AddCardBottomSheet({super.key});

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  bool isDefault = false;

  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _cardNumberController;
  late final TextEditingController _expiryDateController;
  late final TextEditingController _cvvController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _cardNumberController = TextEditingController();
    _expiryDateController = TextEditingController();
    _cvvController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 12.0,
          bottom: 20.0 + bottomInset,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Drag Handle
                Center(
                  child: Container(
                    width: 60,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const Gap(16),

                // 2. Title
                Text(
                  'Add new card',
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Gap(20),

                // 3. Name on card
                _buildCustomCardField(
                  context: context,
                  controller: _nameController,
                  labelText: 'Name on card',
                  hintText: 'Enter name on card',
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.isNullOrEmpty()) {
                      return 'Please enter name on card';
                    }
                    return null;
                  },
                ),
                const Gap(16),

                // 4. Card number
                _buildCustomCardField(
                  context: context,
                  controller: _cardNumberController,
                  maxLength: 19,
                  counterText: '',
                  labelText: 'Card number',
                  hintText: 'ْXXXX XXXX XXXX XXXX',
                  keyboardType: TextInputType.number,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png',
                      width: 32,
                      height: 20,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.credit_card, color: Colors.red),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    CardNumberInputFormatter(),
                  ],

                  validator: (value) {
                    if (value.isNullOrEmpty()) {
                      return 'Please enter card number';
                    }
                    final RegExp cardNumberRegExp = RegExp(r'^\d{16}$');
                    if (!cardNumberRegExp.hasMatch(value!)) {
                      return 'Card number must be numeric';
                    }
                    if (value.length != 16) {
                      return 'Card number must be 16 digits';
                    }

                    return null;
                  },
                ),
                const Gap(16),

                // 5. Expire Date
                _buildCustomCardField(
                  context: context,
                  maxLength: 5,
                  controller: _expiryDateController,
                  labelText: 'Expire Date',
                  hintText: 'MM/YY',
                  counterText: '',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    CardMonthInputFormatter(),
                  ],
                  validator: (value) {
                    if (value.isNullOrEmpty()) {
                      return 'Please enter expiry date';
                    }
                    final RegExp expiryDateRegExp = RegExp(
                      r'^(0[1-9]|1[0-2])\/?([0-9]{2})$',
                    );
                    if (!expiryDateRegExp.hasMatch(value!)) {
                      return 'Please enter a valid expiry date (MM/YY)';
                    }
                    final parts = value.split('/');
                    final month = int.parse(parts[0]);
                    final year = int.parse('20${parts[1]}');

                    final now = DateTime.now();
                    final currentYear = now.year;
                    final currentMonth = now.month;

                    if (year < currentYear ||
                        (year == currentYear && month < currentMonth)) {
                      return 'The expiry date cannot be in the past';
                    }
                    return null;
                  },
                ),
                const Gap(16),

                // 6. CVV
                _buildCustomCardField(
                  context: context,
                  controller: _cvvController,

                  maxLength: 3,
                  counterText: '',
                  labelText: 'CVV',
                  hintText: 'Enter CVV',

                  keyboardType: TextInputType.number,

                  suffixIcon: Icon(
                    Icons.help_outline,
                    color: Colors.grey.shade400,
                  ),

                  validator: (value) {
                    if (value.isNullOrEmpty()) {
                      return 'Please enter CVV';
                    }
                    final RegExp cvvRegExp = RegExp(r'^\d{3}$');
                    if (!cvvRegExp.hasMatch(value!)) {
                      return 'CVV must be numeric';
                    }
                    if (value.length != 3) {
                      return 'CVV must be 3 digits';
                    }
                    return null;
                  },
                ),
                const Gap(16),

                // 7. Checkbox: Set as default payment method
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isDefault,
                        activeColor: const Color(0xFF2D2D2D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (value) {
                          setState(() {
                            isDefault = value ?? false;
                          });
                        },
                      ),
                    ),
                    const Gap(12),
                    Text(
                      'Set as default payment method',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const Gap(24),

                MainButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  text: 'ADD CARD',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomCardField({
    required BuildContext context,
    TextEditingController? controller,
    String? labelText,
    required String hintText,
    required TextInputType keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    String? counterText,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,

        style: textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF222222),
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          counterText: counterText,
          labelStyle: textTheme.labelSmall?.copyWith(
            color: Colors.grey.shade400,
            fontSize: 11,
          ),

          hintText: hintText,
          hintStyle: textTheme.bodyMedium?.copyWith(
            color: Colors.black.withValues(alpha: 0.6),
            fontWeight: FontWeight.normal,
          ),

          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: labelText != null ? 8 : 16,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
