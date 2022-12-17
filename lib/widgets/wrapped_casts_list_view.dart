import 'package:flutter/material.dart';

import '../data/vos/credit_vo.dart';
import '../resources/dimens.dart';
import '../viewItems/cast_view.dart';

class WrappedCastsListView extends StatelessWidget {
  final List<CreditVO>? castsList;
  WrappedCastsListView(this.castsList);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        children: castsList?.map((cast) {
              return Container(
                width: MediaQuery.of(context).size.width / 4.5,
                height: MediaQuery.of(context).size.width / 4,
                child: Column(
                  children: [
                    CastView(cast.profilePath ?? ""),
                    SizedBox(height: MARGIN_SMALL),
                    Expanded(
                      child: Text(
                        cast.originalName ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: TEXT_REGULAR),
                      ),
                    )
                  ],
                ),
              );
            }).toList() ??
            [],
      ),
    );
    // return Container(
    //     child: ListView.builder(
    //       scrollDirection: Axis.horizontal,
    //       itemCount: castsList?.length ?? 0,
    //       itemBuilder: (BuildContext context, int index) {
    //         return Container(
    //           width: MediaQuery.of(context).size.width / 4,
    //           child: Column(
    //             children: [
    //               CastView(castsList?[index].profilePath ?? ""),
    //               SizedBox(height: MARGIN_SMALL),
    //               Expanded(
    //                 child: Text(
    //                   castsList?[index].originalName ?? "",
    //                   textAlign: TextAlign.center,
    //                   style:
    //                   TextStyle(color: Colors.white, fontSize: TEXT_REGULAR),
    //                 ),
    //               )
    //             ],
    //           ),
    //         );
    //       },
    //     )
    // );
  }
}
