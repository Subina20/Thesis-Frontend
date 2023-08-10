import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_recommendation/models/userModel.dart';

final userProvider = ChangeNotifierProvider<UserProvider>((ref) {
  return UserProvider();
});

class UserProvider extends ChangeNotifier {
  UserInfo? _user;

  UserInfo? get user => _user;

  void updateUser({
    String? name,
    String? gender,
    int? age,
    String? occupation,
    String? skinType,
    String? acneType,
    String? openToNewProducts,
    double? acneSeverity,
    String? userImage1,
    String? userImage2,
  }) {
    _user = UserInfo(
      name: name ?? _user?.name ?? '',
      gender: gender ?? _user?.gender ?? '',
      age: age ?? _user?.age ?? 0,
      occupation: occupation ?? _user?.occupation ?? '',
      skinType: skinType ?? _user?.skinType ?? '',
      acneType: acneType ?? _user?.acneType ?? '',
      openToNewProducts: openToNewProducts ?? _user?.openToNewProducts ?? '',
      acneSeverity: acneSeverity ?? _user?.acneSeverity ?? 0,
      userImage1: userImage1 ?? _user?.userImage1 ?? '',
      userImage2: userImage2 ?? _user?.userImage2 ?? '',
    );
    notifyListeners();
  }

  Future<void> uploadUserDataToFirebase() async {
    try {
      // Get the Firestore instance
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get a reference to the "users" collection
      final CollectionReference usersRef = firestore.collection('users');

      // Add the user data to the collection with an automatically generated userId
      await usersRef.add({
        'name': _user?.name ?? '',
        'gender': _user?.gender ?? '',
        'age': _user?.age ?? 0,
        'occupation': _user?.occupation ?? '',
        'skinType': _user?.skinType ?? '',
        'acneType': _user?.acneType ?? '',
        'openToNewProducts': _user?.openToNewProducts ?? '',
        'acneSeverity': _user?.acneSeverity ?? 0,
        'userImage1': _user?.userImage1 ?? '',
        'userImage2': _user?.userImage2 ?? '',
      });

      // You can also get the generated document ID if you need it
      // final DocumentReference newUserDocRef = await usersRef.add({ ... });
      // final String generatedUserId = newUserDocRef.id;

      // You can do additional actions after successful upload if needed
    } catch (e) {
      print('Error uploading user data: $e');
      throw Exception('Error uploading user data: $e');
    }
  }
}
