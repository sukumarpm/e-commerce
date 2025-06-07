import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String? _productType;
  String? _size;
  String? _category;
  bool _isAvailable = true;
  String? imageurlN1 = '';
  String? imageurlN2 = '';
  String? imageurlN3 = '';
  late double _deviceHeight;
  late double _deviceWidth;
  bool isLoading = false;
  String _selectedValuesJson = 'Nothing to show';
  late List<Ingredient> _selectedIngredients;
  final List<String> _sizes = ['casual', 'shirt', 'men', 'fashion'];
  final String _selectedSize = '';
  bool _isFeatured = false;
  bool _isOnSale = false;
  final bool _isNew = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _imageurlController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _productTypeController = TextEditingController();
  final TextEditingController _isAvailableController = TextEditingController();
  final TextEditingController _isFeaturedController = TextEditingController();
  final TextEditingController _isOnSaleController = TextEditingController();
  final TextEditingController _isNewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedIngredients = [];
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Product Image',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                // GestureDetector(
                //   onTap: () {
                //     // Add image picker logic here
                //   },
                //   child: Container(
                //     height: 150,
                //     width: double.infinity,
                //     color: Colors.grey[300],
                //     child: Icon(Icons.add_a_photo,
                //         size: 50, color: Colors.grey[700]),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(6),
                      child: imageurlN1 == ''
                          ? (!isLoading
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Container(
                                    height: _deviceWidth / 4,
                                    width: _deviceWidth / 4,
                                    color: Colors.white,
                                    child: GestureDetector(
                                      onTap: () => {},
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black87,
                                        radius: 10,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(
                                              Icons.cloud_upload_outlined),
                                          color: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Color(0xFF7F7F7F)),
                                      left:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                      right:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                      bottom:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                    ),
                                  ),
                                  child: const Align(
                                      alignment: Alignment.center,
                                      child: Text('MAP AREA')),
                                ))
                          : CachedNetworkImage(
                              imageUrl: imageurlN1!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: _deviceWidth / 4,
                                height: _deviceWidth / 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.black,
                              ),
                            ),
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(6),
                      child: imageurlN2 == ''
                          ? (!isLoading
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Container(
                                    height: _deviceWidth / 4,
                                    width: _deviceWidth / 4,
                                    color: Colors.white,
                                    child: GestureDetector(
                                      onTap: () => {},
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black87,
                                        radius: 10,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(
                                              Icons.cloud_upload_outlined),
                                          color: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Color(0xFF7F7F7F)),
                                      left:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                      right:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                      bottom:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                    ),
                                  ),
                                  child: const Align(
                                      alignment: Alignment.center,
                                      child: Text('MAP AREA')),
                                ))
                          : CachedNetworkImage(
                              imageUrl: imageurlN2!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: _deviceWidth / 4,
                                height: _deviceWidth / 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.black,
                              ),
                            ),
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(6),
                      child: imageurlN3 == ''
                          ? (!isLoading
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Container(
                                    height: _deviceWidth / 4,
                                    width: _deviceWidth / 4,
                                    color: Colors.white,
                                    child: GestureDetector(
                                      onTap: () => {},
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black87,
                                        radius: 10,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(
                                              Icons.cloud_upload_outlined),
                                          color: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Color(0xFF7F7F7F)),
                                      left:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                      right:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                      bottom:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                    ),
                                  ),
                                  child: const Align(
                                      alignment: Alignment.center,
                                      child: Text('MAP AREA')),
                                ))
                          : CachedNetworkImage(
                              imageUrl: imageurlN3!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: _deviceWidth / 4,
                                height: _deviceWidth / 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(labelText: 'Brand'),
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product Brand';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TypeAheadFormField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _productTypeController,
                    decoration:
                        const InputDecoration(labelText: 'Product Type'),
                  ),
                  suggestionsCallback: (pattern) {
                    return [
                      'Electronics',
                      'Clothing',
                      'Accessories',
                      'Footwear',
                      'Home & Kitchen',
                      'Beauty & Health',
                      'Sports & Outdoors',
                      'Toys & Games',
                      'Books',
                      'Automotive',
                      'Grocery',
                      'Pet Supplies',
                      'Office Supplies',
                      'Musical Instruments',
                      'Jewelry',
                      'Watches',
                      'Furniture',
                      'Gardening',
                      'Tools & Home Improvement',
                      'Baby Products',
                      'Arts & Crafts',
                      'Computers & Laptops',
                      'Mobile Phones & Accessories',
                      'Cameras & Photography',
                      'Video Games & Consoles',
                      'Smart Home Devices',
                      'Travel & Luggage',
                      'Health & Personal Care',
                      'Food & Beverages',
                      'Fitness & Exercise',
                      'Outdoor Recreation',
                      'Camping & Hiking',
                      'Fishing & Hunting',
                      'Cycling & Biking',
                      'Running & Jogging',
                      'Yoga & Pilates',
                      'Swimming & Water Sports',
                      'Winter Sports',
                      'Team Sports',
                      'Individual Sports',
                      'Racquet Sports',
                      'Water Sports',
                      'Combat Sports',
                      'Motor Sports',
                      'Extreme Sports',
                      'Board Sports',
                      'Adventure Sports',
                      'Dance & Cheer',
                      'Gymnastics & Cheerleading',
                      'Martial Arts & Self-Defense',
                      'Sports Memorabilia',
                      'Sports Apparel & Footwear',
                      'Sports Equipment & Gear',
                      'Sports Nutrition & Supplements',
                      'Sports Accessories & Gadgets',
                      'Sports Technology & Wearables',
                      'Sports Training & Coaching',
                      'Sports Fan Gear & Merchandise',
                      'Sports Collectibles & Memorabilia',
                      'Sports Books & Magazines',
                      'Sports Movies & Documentaries',
                      'Sports Video Games & Consoles',
                      'Sports Tickets & Experiences',
                    ]
                        .where((type) =>
                            type.toLowerCase().contains(pattern.toLowerCase()))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _productTypeController.text = suggestion;
                      _productType = suggestion;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a product type';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _productType = value;
                  },
                ),
                const SizedBox(height: 16),
                TypeAheadFormField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _sizeController,
                    decoration: const InputDecoration(labelText: 'Size'),
                  ),
                  suggestionsCallback: (pattern) {
                    return [
                      'Small',
                      'Medium',
                      'Large',
                      'S',
                      'M',
                      'L',
                      'XL',
                      'XXL',
                      'narrow fit',
                      'regular fit',
                      'loose fit',
                      'slim fit',
                      'oversized fit',
                      'athletic fit',
                      'relaxed fit',
                      'tailored fit',
                      'boxy fit',
                      'cropped fit',
                      'high-waisted fit',
                      'low-rise fit',
                      'mid-rise fit',
                      'skinny fit',
                      'straight fit',
                      'bootcut fit',
                      'flared fit',
                      'wide-leg fit',
                      'tapered fit',
                      'cargo fit',
                      'jogger fit',
                      'chino fit',
                      'bermuda fit',
                      'culotte fit',
                      'palazzo fit',
                      'paperbag fit',
                      'A-line fit',
                      'fit-and-flare fit',
                      'empire fit',
                      'sheath fit',
                      'shift fit',
                      'maxi fit',
                      'midi fit',
                      'mini fit',
                      'swing fit',
                      'peplum fit',
                      'wrap fit',
                      'tunic fit',
                      'kimono fit',
                      'duster fit',
                      'trench fit',
                      'bomber fit',
                      'denim fit',
                      'puffer fit',
                      'parka fit',
                      'windbreaker fit',
                      'raincoat fit',
                      'anorak fit',
                      'utility fit',
                      'field fit',
                      'military fit',
                      'hiking fit',
                      'outdoor fit',
                      'camping fit',
                      'fishing fit',
                    ]
                        .where((size) =>
                            size.toLowerCase().contains(pattern.toLowerCase()))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _sizeController.text = suggestion;
                      _size = suggestion;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a size';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _size = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _qtyController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _discountController,
                  decoration: const InputDecoration(labelText: 'Discount (%)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter discount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: ['Men', 'Women', 'Kids']
                      .map((category) => DropdownMenuItem(
                          value: category, child: Text(category)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Availability'),
                  value: _isAvailable,
                  activeTrackColor: Colors.black54,
                  onChanged: (value) {
                    setState(() {
                      _isAvailable = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tags',
                      style: GoogleFonts.sen(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 9, 0, 0),
                              fontSize: 14)),
                    ),
                    SingleChildScrollView(
                        child: SizedBox(
                      width: _deviceWidth * .9,
                      child: FlutterTagging<Ingredient>(
                        initialItems: _selectedIngredients,
                        textFieldConfiguration: const TextFieldConfiguration(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xffE3EBF2),
                            hintText: 'Type to search',
                            labelText: 'Type to search..',
                            labelStyle:
                                TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                        ),
                        findSuggestions: getIngredients,
                        additionCallback: (value) {
                          // return Ingredient(
                          //   name: value,
                          //   position: 0,
                          // );
                          return Ingredient(
                            name: value,
                          );
                        },
                        onAdded: (language) {
                          // api calls here, triggered when add to tag button is pressed
                          // return Ingredient(
                          //     name: language.name, position: -1);
                          return Ingredient(name: language.name);
                        },
                        configureSuggestion: (lang) {
                          return SuggestionConfiguration(
                            title: Text(lang.name),
                            // subtitle: Text(lang.name),
                            additionWidget: const Chip(
                              avatar: Icon(
                                Icons.add_circle,
                                color: Colors.white,
                              ),
                              label: Text('Add New Tag'),
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300,
                              ),
                              backgroundColor: Colors.black54,
                            ),
                          );
                        },
                        configureChip: (lang) {
                          return ChipConfiguration(
                            label: Text(lang.name),
                            backgroundColor: Colors.black54,
                            labelStyle: const TextStyle(color: Colors.white),
                            deleteIconColor: Colors.white,
                          );
                        },
                        onChanged: () {
                          setState(() {
                            _selectedValuesJson = _selectedIngredients
                                .map<String>((lang) => '\n${lang.toJson()}')
                                .toList()
                                .toString();
                            _selectedValuesJson =
                                _selectedValuesJson.replaceFirst('}]', '}]');
                          });
                        },
                      ),
                    )),
                  ],
                ),
                CheckboxListTile(
                  value: _isFeatured,
                  checkColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      _isFeatured = value!;
                    });
                  },
                  title: const Text('Is Featured'),
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  value: _isOnSale,
                  checkColor: Colors.black87,
                  onChanged: (value) {
                    setState(() {
                      _isOnSale = value!;
                    });
                  },
                  title: const Text('Is on Sale'),
                ),
                const SizedBox(height: 8),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        final productData = {
                          'name': _nameController.text,
                          'imageurl': imageurlN1,
                          'brand': _brandController.text,
                          'description': _descriptionController.text,
                          'productType': _productType,
                          'size': _size,
                          'price': double.tryParse(_priceController.text),
                          'discount': double.tryParse(_discountController.text),
                          'category': _category,
                          'isAvailable': _isAvailable,
                          'isFeatured': _isFeatured,
                          'isOnSale': _isOnSale,
                          'isNew': _isNew,
                          'tags': _selectedValuesJson,
                          'reviews': [],
                          'rating': 0.0,
                          'createdAt': DateTime.now(),
                          'updatedAt': DateTime.now(),

                          // 'description': _descriptionController.text,
                          // 'productType': _productType,
                          // 'size': _size,
                          // 'price': double.tryParse(_priceController.text),
                          // 'discount': double.tryParse(_discountController.text),
                          // 'category': _category,
                          // 'isAvailable': _isAvailable,
                        };
                        // Add product to Firestore
                        // Ensure that the product ID is unique
                        // and increment the ID in the genprodid collection
                        // before adding the product to the products collection
                        // This is a simplified example; you may want to handle errors and exceptions
                        // more gracefully in a real application
                        try {
                          final genProdIdDoc = await _firestore
                              .collection('genprodid')
                              .doc('current')
                              .get();
                          if (!genProdIdDoc.exists) {
                            await _firestore
                                .collection('genprodid')
                                .doc('current')
                                .set({'id': 0});
                          }

                          final currentProdId = genProdIdDoc.data()?['id'] ?? 0;
                          final newProdId = currentProdId + 1;

                          final existingProduct = await _firestore
                              .collection('products')
                              .where('name', isEqualTo: _nameController.text)
                              .get();

                          if (existingProduct.docs.isNotEmpty) {
                            throw Exception(
                                'Product already exists in the collection');
                          }
                          productData['productId'] = newProdId;
                          await _firestore
                              .collection('products')
                              .doc(newProdId.toString())
                              .set(productData);

                          await _firestore
                              .collection('genprodid')
                              .doc('current')
                              .update({'id': newProdId});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Product added successfully!')),
                          );
                          // Update stock collection
                          final stockDoc = await _firestore
                              .collection('stock')
                              .doc(newProdId.toString())
                              .get();

                          if (stockDoc.exists) {
                            // If stock exists, update the quantity
                            final currentStock =
                                stockDoc.data()?['quantity'] ?? 0;
                            await _firestore
                                .collection('stock')
                                .doc(newProdId.toString())
                                .update({
                              'quantity': currentStock +
                                  int.tryParse(_qtyController.text)!,
                            });
                          } else {
                            // If stock does not exist, create a new stock entry
                            await _firestore
                                .collection('stock')
                                .doc(newProdId.toString())
                                .set({
                              'quantity': int.tryParse(_qtyController.text)!,
                            });
                          }
                          _formKey.currentState!.reset();
                          _nameController.clear();
                          _descriptionController.clear();
                          _priceController.clear();
                          _qtyController.clear();
                          _discountController.clear();
                          _brandController.clear();
                          _productTypeController.clear();
                          _sizeController.clear();
                          _category = null;
                          _productType = null;
                          _size = null;
                          _isAvailable = true;
                          _isFeatured = false;
                          _isOnSale = false;
                          _selectedValuesJson = '';
                          _selectedIngredients.clear();
                          imageurlN1 = '';
                          setState(() {
                            _productType = null;
                            _size = null;
                            _category = null;
                            _isAvailable = true;
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                          print('Error adding product: $e');
                        }
                      }
                    },
                    child: const Text('Add Product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Mocks fetching language from network API with delay of 500ms.
Future<List<Ingredient>> getIngredients(String query) async {
  await Future.delayed(const Duration(milliseconds: 500), null);
  return <Ingredient>[
    const Ingredient(name: 'Casuals'),
    const Ingredient(name: 'Electronics'),
    const Ingredient(name: 'Fashon'),
    const Ingredient(name: 'Grocery'),
    const Ingredient(name: 'Health & Beauty'),
    const Ingredient(name: 'Home & Living'),
    const Ingredient(name: 'Kids'),
  ]
      .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
}

/// Ingredient Class
class Ingredient extends Taggable {
  ///
  final String name;

  ///
  // final int position;

  /// Creates Ingredient
  const Ingredient({
    required this.name,
    // required this.position,
  });

  @override
  List<Object> get props => [name];

  /// Converts the class to json string.
  String toJson() => '''  {
    "name": "$name"
  }''';
}
