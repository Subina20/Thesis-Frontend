import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skincare_recommendation/models/userModel.dart';
import 'package:skincare_recommendation/provider/userProvider.dart';

class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? _selectedImage1URL;
  String? _selectedImage2URL;

  bool focused = false;

  @override
  void initState() {
    // Fetch the current name from UserProvider and set it to the _nameController
    _nameController.text = ref.read(userProvider).user?.name ?? '';
    super.initState();
  }

  Future<void> _pickImageAndUpload(ImageSource source, int samplenumber) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile == null) return;

      // Upload the image to Firebase Storage
      final File file = File(pickedFile.path);
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      final Reference reference = _storage.ref().child('user_images/$fileName');
      final UploadTask uploadTask = reference.putFile(file);
      await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded image
      final String downloadURL = await reference.getDownloadURL();

      setState(() {
        // Set the appropriate selected image URL based on the source
        if (samplenumber == 1) {
          _selectedImage1URL = downloadURL;
          ref.read(userProvider).updateUser(userImage1: _selectedImage1URL);
        } else {
          _selectedImage2URL = downloadURL;
          ref.read(userProvider).updateUser(userImage2: _selectedImage2URL);
        }
      });
    } catch (e) {
      // Handle any errors that occur during the image picking/uploading process
      print('Error picking/uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final UserInfo? user = ref.read(userProvider).user;

    // Perform a null check on the user variable
    final bool hasUserImage1 =
        user?.userImage1 != null && user!.userImage1.isNotEmpty;
    final bool hasUserImage2 =
        user?.userImage2 != null && user!.userImage2.isNotEmpty;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  // Wrap with SingleChildScrollView
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      const Text(
                        'Well First Thing First',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'What\'s your name?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        controller: _nameController,
                        focusNode: _nameNode,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter your username',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          ref
                              .read(userProvider)
                              .updateUser(name: _nameController.text);
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Please click sample images of your skin'),
                      const SizedBox(height: 20),
                      if (!isKeyboardVisible) // Hide the Row only when the keyboard is not visible
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () =>
                                  _pickImageAndUpload(ImageSource.camera, 1),
                              child:
                                  hasUserImage1 // Use the hasUserImage1 variable here
                                      ? SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Image.network(
                                            user.userImage1, // Use the user variable here
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                        ),
                            ),
                            InkWell(
                              onTap: () =>
                                  _pickImageAndUpload(ImageSource.camera, 2),
                              child:
                                  hasUserImage2 // Use the hasUserImage2 variable here
                                      ? SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Image.network(
                                            user.userImage2, // Use the user variable here
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                        ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
