import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

import '../data/vos/banner_vo.dart';
import '../viewItems/banner_view.dart';

class HorizontalBannerView extends StatefulWidget {
  final List<BannerVO>? mBannersList;
  final Function(int) onTapBannerView;
  HorizontalBannerView(this.mBannersList, {required this.onTapBannerView});

  @override
  State<HorizontalBannerView> createState() => _HorizontalBannerViewState();
}

class _HorizontalBannerViewState extends State<HorizontalBannerView> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: MARGIN_MEDIUM_2,
          );
        },
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,

          itemCount: widget.mBannersList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  this.widget.onTapBannerView(index);
                  this.selectedIndex = index;
                });
              },
              child: Container(
                  // width: MediaQuery.of(context).size.width,
                child: (this.widget.mBannersList != null)
                    ? Center(
                        child: Container(
                            // width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
                              border: (index == this.selectedIndex)
                                  ? Border.all(color: Colors.yellow, width: 2.0)
                                  : Border.all(
                                      width: 0.0, color: Colors.transparent),
                            ),
                            child:
                                BannerView(this.widget.mBannersList?[index])),
                      )
                    : Container(),
              ),
            );
          }),
    );
  }
}
