import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget profilePicture(double size,userProfile) {
  return userProfile.isAuthenticated ? CachedNetworkImage(
    imageUrl: userProfile.profileImage,
    imageBuilder: (context, imageProvider) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    ),
    placeholder: (context, url) => CircularProgressIndicator.adaptive(),
    errorWidget: (context, url, error) => Icon(Icons.error),
  ) : CircleAvatar(
  child: Icon(Icons.person, size: size/2),
  );
}
