import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../../../auth/data/model/user_model.dart';

class ProfileImageSection extends StatelessWidget {
  final   UserModel user;
  final File? selectedImage;
  final VoidCallback onPickImage;

  const ProfileImageSection({
    super.key,
    required this.user,
    required this.selectedImage,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: selectedImage != null
              ? FileImage(selectedImage!)
              : (user.photoURL != null ? NetworkImage(user.photoURL!) : null),
          child: (selectedImage == null && user.photoURL == null)
              ? const Icon(Icons.person, size: 50)
              : null,
        ),
        TextButton(
          onPressed: onPickImage,
          child: const Text('Change Profile Image'),
        ),
      ],
    );
  }
}
