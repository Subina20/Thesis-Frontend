import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_recommendation/provider/userProvider.dart';

class SecondScreen extends ConsumerStatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends ConsumerState<SecondScreen> {
  String selectedAcneType = '';
  List<String> acneImages = [
    'https://images-prod.healthline.com/hlcmsresource/images/Image-Galleries/Inflamed-Acne/5970-acne_papules-642x361-slide2.jpg',
    'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/comedos.jpg?w=1155',
    'https://gladskin.com/cdn/shop/articles/cystic_agne-844415.png?v=1677712903',
    'https://dermcollective.com/wp-content/uploads/2019/12/Nodular-Acne.jpg',
  ];

  void setSelectedAcneType(String type) {
    setState(() {
      selectedAcneType = type;
    });
  }

  @override
  void initState() {
    super.initState();
    // Check if the userProvider has a saved acne type, and if yes, set it as the selectedAcneType
    final userInfo = ref.read(userProvider);
    print(userInfo.user!);
    if (userInfo.user != null) {
      setSelectedAcneType(userInfo.user!.acneType);
    }
  }

  void showMoreImagesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('More Images on $selectedAcneType acne'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              itemCount: acneImages.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: createAcneImageWidgetforMore(
                      selectedAcneType, acneImages[index]),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      const Text(
                        'What types of acne do you typically experience?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            createAcneImageWidget('inflammatory',
                                'https://images-prod.healthline.com/hlcmsresource/images/Image-Galleries/Inflamed-Acne/5970-acne_papules-642x361-slide2.jpg'),
                            createAcneImageWidget('comedonal',
                                'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/comedos.jpg?w=1155'),
                            createAcneImageWidget('cystic',
                                'https://gladskin.com/cdn/shop/articles/cystic_agne-844415.png?v=1677712903'),
                            createAcneImageWidget('nodular',
                                'https://dermcollective.com/wp-content/uploads/2019/12/Nodular-Acne.jpg'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createAcneImageWidget(String type, String imageUrl) {
    final isTypeSelected = type == selectedAcneType;
    return InkWell(
      onTap: () {
        setSelectedAcneType(type);
        final userInfo = ref.read(userProvider);
        userInfo.updateUser(acneType: type);
        showMoreImagesDialog();
      },
      child: Container(
        decoration: BoxDecoration(
          border: isTypeSelected
              ? Border.all(color: Colors.green, width: 10)
              : null,
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

Widget createAcneImageWidgetforMore(String type, String imageUrl) {
  return InkWell(
    onTap: () {},
    child: Image.network(
      imageUrl,
      fit: BoxFit.cover,
    ),
  );
}
