import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/shipping_address.dart';
import 'package:e_commerce/utilities/constans.dart';
import 'package:e_commerce/utilities/context_extension.dart';
import 'package:e_commerce/views/widgets/custom_text_field.dart';
import 'package:e_commerce/views/widgets/main_buttom.dart';
import 'package:e_commerce/views/widgets/main_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AddShippingAddressPage extends StatefulWidget {
  final ShippingAddress? shippingAddress;
  const AddShippingAddressPage({super.key, this.shippingAddress});

  @override
  State<AddShippingAddressPage> createState() => _AddShippingAddressPageState();
}

class _AddShippingAddressPageState extends State<AddShippingAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  ShippingAddress? shippingAddress;
  @override
  void initState() {
    super.initState();
    shippingAddress = widget.shippingAddress;
    if (shippingAddress != null) {
      _nameController.text = shippingAddress!.fullName;
      _addressController.text = shippingAddress!.address;
      _cityController.text = shippingAddress!.city;
      _zipController.text = shippingAddress!.zipCode;
      _stateController.text = shippingAddress!.state;
      _countryController.text = shippingAddress!.country;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _stateController.dispose();
    _countryController.dispose();
  }

  Future<void> saveAddress(Database database) async {
    try {
      if (_formKey.currentState!.validate()) {
        final address = ShippingAddress(
          id:shippingAddress != null ? shippingAddress!.id: documentIdFromLocalDatabase(),
          fullName: _nameController.text.trim(),
          country: _countryController.text.trim(),
          address: _addressController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          zipCode: _zipController.text.trim(),
        );
        await database.saveAddress(address);
        if (!mounted) return;
        context.pop();
      }
    } catch (e) {
      MainDialog.showCustomDialog(
        context: context,
        error: e.toString(),
        title: 'Save Address Failed!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          shippingAddress != null
              ? 'Edit Shipping Address'
              : 'Add Shipping Address',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Enter Your Name',
                  fillColor: Colors.white,
                  filled: true,

                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your name',
                ),
                const Gap(16),
                CustomTextField(
                  controller: _addressController,
                  labelText: 'Address',
                  hintText: 'Enter Your Address',
                  fillColor: Colors.white,
                  filled: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your address',
                ),
                const Gap(16),

                CustomTextField(
                  controller: _cityController,
                  labelText: 'City',
                  hintText: 'Enter Your City',

                  fillColor: Colors.white,
                  filled: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your city',
                ),
                const Gap(16),

                CustomTextField(
                  controller: _stateController,
                  labelText: 'State/Province',
                  hintText: 'Enter Your state',
                  fillColor: Colors.white,

                  filled: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your state',
                ),
                const Gap(16),

                CustomTextField(
                  controller: _zipController,
                  labelText: 'Zip Code',
                  hintText: 'Enter zip code',
                  fillColor: Colors.white,

                  filled: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter zip code',
                ),
                const Gap(16),

                CustomTextField(
                  controller: _countryController,
                  labelText: 'Country',
                  hintText: 'Enter Country',
                  fillColor: Colors.white,

                  filled: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter country',
                ),
                const Gap(32),
                MainButton(
                  text: 'Save Address',
                  onTap: () => saveAddress(database),
                  hasCircularBorder: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
