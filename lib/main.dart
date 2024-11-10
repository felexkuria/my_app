import 'package:flutter/material.dart';

void main() {
  runApp(const VendorProfitCalculator());
}

class VendorProfitCalculator extends StatelessWidget {
  const VendorProfitCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vendor Profit Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ProfitCalculatorScreen(),
    );
  }
}

class ProfitCalculatorScreen extends StatefulWidget {
  const ProfitCalculatorScreen({super.key});

  @override
  _ProfitCalculatorScreenState createState() => _ProfitCalculatorScreenState();
}

class _ProfitCalculatorScreenState extends State<ProfitCalculatorScreen> {
  final _priceController = TextEditingController();
  final _buyingPriceController = TextEditingController();
  String? _selectedCategory;
  String? _shippingMethod = 'drop-shipping';
  double? _profit;
  double? _realProfit;

  // Predefined profit values based on category and shipping method
  final Map<String, Map<String, double>> shippingCosts = {
    'Audio & HiFi': {'drop-shipping': 250, 'jumia-express': 120},
    'Beauty Appliances': {'drop-shipping': 60, 'jumia-express': 30},
    'Bedding': {'drop-shipping': 120, 'jumia-express': 60},
    'Bulky Sporting Goods': {'drop-shipping': 400, 'jumia-express': 350},
    'Camera': {'drop-shipping': 120, 'jumia-express': 60},
    'Computers': {'drop-shipping': 250, 'jumia-express': 120},
    'Cooktops': {'drop-shipping': 120, 'jumia-express': 60},
    'Desktop & Peripherals': {'drop-shipping': 120, 'jumia-express': 60},
    'Diapers': {'drop-shipping': 60, 'jumia-express': 30},
    'Electronics Accessories': {'drop-shipping': 60, 'jumia-express': 30},
    'Fashion': {'drop-shipping': 60, 'jumia-express': 30},
    'Gaming Consoles': {'drop-shipping': 120, 'jumia-express': 60},
    'Grocery': {'drop-shipping': 250, 'jumia-express': 60},
    'Health & Beauty': {'drop-shipping': 60, 'jumia-express': 30},
    'Home': {'drop-shipping': 120, 'jumia-express': 60},
    'Kids & Baby': {'drop-shipping': 60, 'jumia-express': 60},
    'Large Appliances': {'drop-shipping': 400, 'jumia-express': 350},
    'Lighting': {'drop-shipping': 120, 'jumia-express': 60},
    'Luggage & Travel Gear': {'drop-shipping': 120, 'jumia-express': 60},
    'Mobile Phones': {'drop-shipping': 120, 'jumia-express': 60},
    'Other': {'drop-shipping': 120, 'jumia-express': 60},
    'Small Appliances': {'drop-shipping': 120, 'jumia-express': 60},
    'Sporting Goods': {'drop-shipping': 350, 'jumia-express': 350},
    'Tablets': {'drop-shipping': 120, 'jumia-express': 60},
    'Televisions': {'drop-shipping': 400, 'jumia-express': 200},
    'TV Accessories': {'drop-shipping': 120, 'jumia-express': 60},
    'Video Games': {'drop-shipping': 120, 'jumia-express': 60},
    'Water Dispensers': {'drop-shipping': 120, 'jumia-express': 60},
  };

  List<String> categories = [
    'Audio & HiFi',
    'Beauty Appliances',
    'Bedding',
    'Bulky Sporting Goods',
    'Camera',
    'Computers',
    'Cooktops',
    'Desktop & Peripherals',
    'Diapers',
    'Electronics Accessories',
    'Fashion',
    'Gaming Consoles',
    'Grocery',
    'Health & Beauty',
    'Home',
    'Kids & Baby',
    'Large Appliances',
    'Lighting',
    'Luggage & Travel Gear',
    'Mobile Phones',
    'Other',
    'Small Appliances',
    'Sporting Goods',
    'Tablets',
    'Televisions',
    'TV Accessories',
    'Video Games',
    'Water Dispensers'
  ];

  void calculateProfit() {
    final double price = double.tryParse(_priceController.text) ?? 0;
    final double buyingPrice =
        double.tryParse(_buyingPriceController.text) ?? 0;
    if (_selectedCategory == null || price == 0 || buyingPrice == 0) return;

    final shippingCost = shippingCosts[_selectedCategory!]![_shippingMethod!]!;

    setState(() {
      _profit = price - buyingPrice - shippingCost;
      _realProfit = _profit! - (price * 0.1); // Example: 10% tax deduction
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Profit Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Category',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              hint: const Text('Select Category'),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selling Price (KSH)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Selling Price',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Buying Price (KSH)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            TextField(
              controller: _buyingPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Buying Price',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Shipping Method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            DropdownButton<String>(
              value: _shippingMethod,
              onChanged: (value) {
                setState(() {
                  _shippingMethod = value;
                });
              },
              items: [
                'drop-shipping',
                'jumia-express',
              ].map((method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateProfit,
              child: const Text('Calculate Profit'),
            ),
            const SizedBox(height: 32),
            if (_profit != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profit: KSH ${_profit!.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Real Profit (after deductions): KSH ${_realProfit!.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
