
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:volco/widgets/custom_image_view.dart';

class EventCatogoryCard extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;
  final Color? color;
  final Function() onPressed;

  const EventCatogoryCard({required this.text, required this.imageUrl, this.subtitle ="", required this.onPressed, this.color,Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // width: 150,
        // height: 150,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color??Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withAlpha(50)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CustomImageView(
              imagePath: imageUrl,
              height: 50,
              width: 50,
            ),
            SizedBox(height: 20,),
            AutoSizeText(text,
                minFontSize: 18,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                )),

            Text(
              subtitle ,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),

          ],
        ),
      ),
    );
  }
}
