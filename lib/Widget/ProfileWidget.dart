import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePatch;
  final VoidCallback onCliced;

  const ProfileWidget({
    Key? key,
    required this.imagePatch,
    required this.onCliced,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 3,
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 0,
            child: buildEditIcon(Colors.cyan)),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePatch);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onCliced),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    clor: Colors.white,
    all: 3,
      child: buildCircle(
      clor: color,
      all: 8,
      child: Icon(
        Icons.edit,
        size: 20,
        color: Colors.white,
        ),
      ),
  );

  Widget buildCircle({
  required Widget child,
  required double all,
  required Color clor,
    required
}) =>
    ClipOval(
      child: Container(
      padding:  EdgeInsets.all(all),
      color: clor,
      child: child,
      ),
    );
}
