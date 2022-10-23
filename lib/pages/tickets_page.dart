import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import '../data/vos/ticket_vo.dart';
import 'ticket_confirmation_page.dart';

class TicketsPage extends StatelessWidget {
  List<TicketVO> ticketList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: ticketList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    // TicketView(ticketList?[index]),
                    SizedBox(height: MARGIN_MEDIUM),
                  ],
                );
              }
          )
        ),
      ),
    );
  }
}
