import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _shippingAddressController =
      TextEditingController();
  final TextEditingController _shippingStreetController =
      TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool _isBillingSameAsDelivery = false;
  String _selectedPaymentMethod = 'Credit Card';
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;

  final List<String> _paymentMethods = [
    'Credit Card',
    'PayPal',
    'UPI',
    'Net Banking'
  ];
  final List<String> _shippingMethods = [
    'Standard Shipping',
    'Express Shipping',
    'Next Day Delivery'
  ];
  final String _selectedShippingMethod = 'Standard Shipping';
  final List<String> _billingMethods = [
    'Same as Delivery Address',
    'Different Billing Address'
  ];
  final String _selectedBillingMethod = 'Same as Delivery Address';
  final List<String> _orderSummary = [
    'Item 1: \$50',
    'Item 2: \$30',
    'Shipping: \$10',
    'Total: \$90'
  ];
  @override
  initState() {
    super.initState();
    _navigationService = _getIt<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _navigationService.pushNamed("/mycart");
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Items in your cart:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            // ..._orderSummary.map((item) {
            //   return Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 4.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           item.split(':')[0], // Extracting item name
            //           style: const TextStyle(fontSize: 14),
            //         ),
            //         Text(
            //           item.split(':')[1], // Extracting item price
            //           style: const TextStyle(
            //               fontSize: 14, fontWeight: FontWeight.bold),
            //         ),
            //       ],
            //     ),
            //   );
            // }),

            const SizedBox(height: 20),
            TextField(
              controller: _contactNameController,
              decoration: const InputDecoration(labelText: 'Contact Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _shippingAddressController,
              decoration:
                  const InputDecoration(labelText: 'Shipping Address 1'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _shippingStreetController,
              decoration: const InputDecoration(labelText: 'Shipping Street'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _landmarkController,
              decoration: const InputDecoration(labelText: 'Landmark'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Payment Methods',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _paymentMethods.map((method) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = method;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: _selectedPaymentMethod == method
                            ? Colors.blue
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        method,
                        style: TextStyle(
                          color: _selectedPaymentMethod == method
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            _selectedPaymentMethodWidget,
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isBillingSameAsDelivery,
                  onChanged: (value) {
                    setState(() {
                      _isBillingSameAsDelivery = value!;
                    });
                  },
                ),
                const Text('Billing address is the same as delivery address',
                    style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Place order logic
                },
                child: const Text('Place Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  get _selectedPaymentMethodWidget {
    switch (_selectedPaymentMethod) {
      case 'Credit Card':
        return _buildCreditCardInput();
      case 'PayPal':
        return _buildPayPalInput();
      case 'UPI':
        return _buildUPIInput();
      case 'Net Banking':
        return _buildNetBankingInput();
      default:
        return Container();
    }
  }

  Widget _buildUPIInput() {
    final TextEditingController upiIdController = TextEditingController();

    return SizedBox(
      height: 150,
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UPI Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: upiIdController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'UPI ID',
              hintText: 'example@upi',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayPalInput() {
    final TextEditingController emailController = TextEditingController();

    return SizedBox(
      height: 150,
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PayPal Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'PayPal Email',
              hintText: 'example@paypal.com',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetBankingInput() {
    final TextEditingController accountNumberController =
        TextEditingController();
    final TextEditingController ifscCodeController = TextEditingController();

    return SizedBox(
      height: 200,
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Net Banking Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: accountNumberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Account Number',
              hintText: 'Enter your account number',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: ifscCodeController,
            decoration: const InputDecoration(
              labelText: 'IFSC Code',
              hintText: 'Enter your bank IFSC code',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCardInput() {
    final TextEditingController cardNumberController = TextEditingController();
    final TextEditingController expiryDateController = TextEditingController();
    final TextEditingController cvvController = TextEditingController();
    final TextEditingController cardHolderNameController =
        TextEditingController();

    return SizedBox(
      height: 300,
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Credit Card Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: cardNumberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Card Number',
              hintText: '1234 5678 9012 3456',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: expiryDateController,
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              labelText: 'Expiry Date',
              hintText: 'MM/YY',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: cvvController,
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'CVV',
              hintText: '123',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: cardHolderNameController,
            decoration: const InputDecoration(
              labelText: 'Card Holder Name',
            ),
          ),
        ],
      ),
    );
  }
}
