import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_recommendation/provider/userProvider.dart';
import 'package:url_launcher/url_launcher.dart';

// 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 CHATGPT KEY

class FinalResult extends ConsumerStatefulWidget {
  const FinalResult({super.key});
  @override
  _FinalResultState createState() => _FinalResultState();
}

class _FinalResultState extends ConsumerState<FinalResult> {
  Future<List<dynamic>>? futureData;

  String? age;
  String? skinType;
  String? acneType;

  @override
  void initState() {
    super.initState();

    final userData = ref.read(userProvider);
    age = userData.user!.age.toString();
    skinType = userData.user!.skinType;
    acneType = userData.user!.acneType;

    futureData = fetchData();
  }

  Future<String> searchProductKind(String message) async {
    OpenAI.apiKey = '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';
    OpenAI.organization = 'org-SIIvtbgihHnsy4t7h49olKuM';

    final chatCompletion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: 'What kind of product is $message in a single word?',
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    return chatCompletion.choices.first.message.content;
  }

  Future<List<dynamic>> fetchData() async {
    const url = 'http://192.168.191.146::8000/skincare/skin_care_recommendations/';
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    final body = {
      'age': age,
      'skin_type': skinType, 
      'acne_type': acneType,
    };

    try {
      final dio = Dio();
      final response =
          await dio.post(url, data: body, options: Options(headers: headers));
      print(response);

      if (response.statusCode == 200) {
        final dataList = response.data as List<dynamic>;
        final filteredData =
            removeDuplicates(dataList, ['product_name', 'brand']);
        return filteredData;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while making the request: $e');
      throw Exception(e);
    }
  }

  List<dynamic> removeDuplicates(List<dynamic> list, List<String> fields) {
    final Set<String> uniqueKeys = <String>{};
    final List<dynamic> filteredList = [];

    for (var item in list) {
      final key = fields.map((field) => item[field].toString()).join('-');
      if (!uniqueKeys.contains(key)) {
        uniqueKeys.add(key);
        filteredList.add(item);
      }
    }

    return filteredList;
  }

  Future<List<dynamic>> searchProduct(String productName) async {
    String apiKey =
        '5646482bfce361a551b164781b7e153b893288ce30e016011ebe35932826a476';
    final encodedProductName = Uri.encodeQueryComponent(productName);

    final url =
        'https://serpapi.com/search.json?engine=google_shopping&q=$encodedProductName&google_domain=google.com&num=5&api_key=$apiKey';

    try {
      final dio = Dio();
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final data =
            response.data['shopping_results']; // No need for jsonDecode here
        return data;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while searching product: $e');
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  Container()
                ],
              ),
              const ListTile(
                minVerticalPadding: 20,
                title: Text(
                  'Skincare Products Recommended',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'You can tap on any product to view the listing on google shopping',
                  style: TextStyle(fontSize: 14),
                  softWrap: true,
                ),
              ),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: futureData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While the Future is still ongoing, show a loading indicator
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // If there's an error in the Future, show an error message
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                            child: Text(
                                'Sorry! We couldn\'t find suitable products for your skin condition at the moment!')),
                      );
                    } else {
                      // If the Future completes successfully, display the data
                      final data = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          final productName = item['product_name'];
                          final brand = item['brand'];
                          return ListTile(
                            title: Text(productName),
                            subtitle: Text(brand),
                            // trailing: FutureBuilder<String?>(
                            //   future: searchProductKind(productName),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.connectionState == ConnectionState.waiting) {
                            //       return const CircularProgressIndicator();
                            //     } else if (snapshot.hasError) {
                            //       return Text('Error: ${snapshot.error}');
                            //     } else {
                            //       // Display the product kind from the snapshot data
                            //       final productKind = snapshot.data;
                            //       return Text(productKind ?? 'Product kind not found');
                            //     }
                            //   },
                            // ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ProductCardsDialog(
                                    productName: productName,
                                    searchProduct: searchProduct,
                                  );
                                },
                              ).then((selectedProductData) {
                                if (selectedProductData != null) {
                                  // Now you have the selected product data, do something with it
                                }
                              });
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCardsDialog extends StatelessWidget {
  final String productName;
  final Future<List<dynamic>> Function(String) searchProduct;

  const ProductCardsDialog({
    super.key,
    required this.productName,
    required this.searchProduct,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Products for $productName'),
      content: FutureBuilder<List<dynamic>>(
        future: searchProduct(productName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data ?? [];
            return SingleChildScrollView(
                // Wrap the Column with SingleChildScrollView
                child: Column(
              children: data
                  .map((productData) => ProductCard(
                        productData: productData,
                        onTap: (val) {},
                      ))
                  .toList(),
            ));
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> productData;
  final Function(Map<String, dynamic>) onTap;

  const ProductCard(
      {super.key, required this.productData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () async {
          Uri url = Uri.parse(productData['product_link']);
          if (await canLaunchUrl(url)) {
            launchUrl(url);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(productData['thumbnail']),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productData['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      productData['price'],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
