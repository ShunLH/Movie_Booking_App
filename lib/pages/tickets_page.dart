import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/title_text_view.dart';

import 'ticket_confirmation_page.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    TicketView(),
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
