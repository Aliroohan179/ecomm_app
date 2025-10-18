import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';
import '../../models/order.dart';
import '../../models/user_profile.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userId = authService.currentUser?.uid;

    if (userId != null) {
      final profile = await authService.getUserProfile(userId);
      if (profile != null && mounted) {
        setState(() {
          _nameController.text = profile.name;
          _phoneController.text = profile.phone;
          _addressController.text = profile.address;
          _cityController.text = profile.city;
          _stateController.text = profile.state;
          _zipCodeController.text = profile.zipCode;
        });
      }
    }
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final firestoreService = Provider.of<FirestoreService>(context, listen: false);
      final userId = authService.currentUser?.uid;

      if (userId != null) {
        final total = widget.cartItems.fold<double>(
          0,
          (sum, item) => sum + item.totalPrice,
        );

        final order = Order(
          id: '',
          userId: userId,
          items: widget.cartItems
              .map((item) => OrderItem(
                    bookId: item.bookId,
                    title: item.title,
                    author: item.author,
                    price: item.price,
                    quantity: item.quantity,
                  ))
              .toList(),
          totalAmount: total,
          shippingAddress: _addressController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          zipCode: _zipCodeController.text.trim(),
          phone: _phoneController.text.trim(),
          status: OrderStatus.pending,
          createdAt: DateTime.now(),
        );

        await firestoreService.createOrder(userId, order);
        await firestoreService.clearCart(userId);

        if (mounted) {
          Helpers.showSnackBar(context, 'Order placed successfully!');
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      }
    } catch (e) {
      if (mounted) {
        Helpers.showSnackBar(context, 'Failed to place order: ${e.toString()}',
            isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.cartItems.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Shipping Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.home_outlined),
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                prefixIcon: Icon(Icons.location_city_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your city';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _stateController,
                    decoration: const InputDecoration(
                      labelText: 'State',
                      prefixIcon: Icon(Icons.map_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter state';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _zipCodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'ZIP Code',
                      prefixIcon: Icon(Icons.pin_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...widget.cartItems.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${item.title} x${item.quantity}',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                      Text(
                        Helpers.formatPrice(item.totalPrice),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  Helpers.formatPrice(total),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _placeOrder,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Place Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
