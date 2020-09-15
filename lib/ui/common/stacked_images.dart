import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../network/response/recent_people.dart';
import '../../res/app_colors.dart';
import '../../res/styles.dart';

class StackedImages extends StatelessWidget {
  const StackedImages({Key key, this.recentLikes}) : super(key: key);

  final List<RecentPeople> recentLikes;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      width: getWidth(),
      child: Stack(
        children: <Widget>[
          if (getImagesCount() > 0)
            Positioned(
              left: 0,
              child: getCircularImage(recentLikes[0].image, recentLikes[0].fullName),
            )
          else
            Container(),
          if (getImagesCount() > 1)
            Positioned(
              left: 11,
              child: getCircularImage(recentLikes[1].image, recentLikes[1].fullName),
            )
          else
            Container(),
          if (getImagesCount() > 2)
            Positioned(
              left: 22,
              child: getCircularImage(recentLikes[2].image, recentLikes[2].fullName),
            )
          else
            Container(),
          if (getImagesCount() > 3)
            Positioned(
              left: 33,
              child: getCircularImage(recentLikes[3].image, recentLikes[3].fullName),
            )
          else
            Container()
        ],
      ),
    );
  }

  Widget getCircularImage(String url, String fullName) {
    return Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: Colors.white, style: BorderStyle.solid)),
        child: CircularImageViewNamePlaceHolder(
          url: url,
          size: 21,
          callBack: null,
          name: fullName,
        ));
  }

  int getImagesCount() {
    if (recentLikes.length < 4) {
      return recentLikes.length;
    }
    return 4;
  }

  double getWidth() {
    switch (recentLikes.length) {
      case 0:
        return 0;
      case 1:
        return 21;
      case 2:
        return 32;
      case 3:
        return 43;
      default:
        return 55;
    }
  }
}

class StackedImagesVotesAndTimeLeft extends StatelessWidget {
  const StackedImagesVotesAndTimeLeft(
      {@required this.votes, this.recentPeople, this.timeLeft, Key key})
      : super(key: key);

  final List<RecentPeople> recentPeople;
  final int votes;
  final int timeLeft;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        StackedImages(recentLikes: recentPeople),
        const SizedBox(width: 8),
        Text('$votes Votes • $timeLeft Hours remaining',
            style: tsBoldWhite12.copyWith(color: AppColors.whiteOpacity60))
      ],
    );
  }
}

class CircularImageViewNamePlaceHolder extends StatelessWidget {
  CircularImageViewNamePlaceHolder({
    @required this.url,
    @required this.callBack,
    @required this.name,
    this.size = 84,
    this.showWhiteBorder = true,
    this.backgroundColor = AppColors.darkGrey,
    this.textColor = AppColors.white,
  });

  final double size;
  String url;
  final String name;
  final bool showWhiteBorder;
  final Function callBack;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    url ??= '';
    return GestureDetector(
        onTap: () {
          if (callBack != null) callBack();
        },
        child: CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: showWhiteBorder ? 2.0 : 0.0,
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: CachedNetworkImageProvider(url)))),
            placeholder: (context, url) => Container(
                  width: size,
                  height: size,
                  child: Container(
                    width: size,
                    height: size,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: backgroundColor,
                        border: Border.all(
                          color: Colors.white,
                          width: showWhiteBorder ? 2.0 : 0.0,
                        )),
                    child: Text(
                      getInitials(name),
                      style: TextStyle(
                          color: textColor, fontSize: size * .323, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
            errorWidget: (context, url, error) => Container(
                  width: size,
                  height: size,
                  child: Container(
                    width: size,
                    height: size,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: backgroundColor,
                        border: Border.all(
                          color: Colors.white,
                          width: showWhiteBorder ? 2.0 : 0.0,
                        )),
                    child: Text(
                      getInitials(name),
                      style: TextStyle(
                          color: textColor, fontSize: size * .323, fontWeight: FontWeight.w700),
                    ),
                  ),
                )));
  }

  String getInitials(String name) {
    try {
      return name.isNotEmpty
          ? name.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase()
          : '';
    } catch (e) {
      return 'NA';
    }
  }
}
