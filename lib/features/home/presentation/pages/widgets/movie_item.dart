import "package:flutter/material.dart";

import "package:flutter_clean_architecture/core/utils/utils.dart";
import "package:flutter_clean_architecture/core/widgets/blur_text.dart";
import "package:flutter_clean_architecture/core/widgets/custom_cached_network_image.dart";

class MovieItem extends StatelessWidget {
  const MovieItem({super.key});

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: SizedBox(
              width: 128,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: AppUtils.kBorderRadius8,
                          child: CustomCachedNetworkImage(
                            imageUrl:
                                "https://firebasestorage.googleapis.com/v0/b/sample-bloc-5b8b9.appspot.com/o/movie_photo.webp?alt=media",
                            width: 128,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => alignLogo,
                            errorWidget: (_, __, ___) => alignLogo,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppUtils.kGap6,
                  const Text(
                    "Oliftaxon",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Сериал",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 0,
            child: BlurText(text: "Экслюзив"),
          ),
        ],
      );
}
