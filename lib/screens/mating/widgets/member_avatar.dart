import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MemberAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  const MemberAvatar({
    Key? key,
    this.imageUrl,
    this.size = 42,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ??
          "http://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2021/09/27/OCW92k0OLl2y637683075936484992.jpg",
      imageBuilder: (context, imageProvider) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )),
      ),
      errorWidget: (context, url, error) => SizedBox(
        width: size,
        height: size,
        child: const CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('assets/images/noperson.png'),
        ),
      ),
    );
  }
}
