import 'package:flutter/material.dart';

import '../model/profile_title_model.dart';

ProfileData dimProfile = ProfileData(
  name: "Setha Vathanak",
  position: "Flutter Developer",
  avatarUrl: 'assets/images/w8/cat.png',
  tiles: [
    TileData(icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
    TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
    
    TileData(icon: Icons.email, title: "Mail", value: "sethavatahank.sao@student.cadt.edu.kh"),
    TileData(icon: Icons.code, title: "GitHub", value: "@obviouslynotdim"),
    TileData(icon: Icons.work, title: "Experience", value: "-8+ Years in Dev (this user is cooked!)"),
    TileData(icon: Icons.favorite, title: "Favorite Tech", value: "Dart/Flutter"),
    TileData(icon: Icons.language, title: "Languages", value: "Khmer, Japanese, English"),
  ],
);

