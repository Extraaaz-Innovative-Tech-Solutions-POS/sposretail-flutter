import 'package:flutter/material.dart';
import 'package:spos_retail/views/widgets/app_bar.dart';

class InvoiceSetup extends StatefulWidget {
  const InvoiceSetup({super.key});

  @override
  State<InvoiceSetup> createState() => _InvoiceSetupState();
}

class _InvoiceSetupState extends State<InvoiceSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(context, "Invoice Setup", ""),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).focusColor,
                            border: Border.all(
                                color: Theme.of(context).highlightColor),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ListTile(
                            onTap: () {},
                            title: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Invoice',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(children: [
                                  Text('',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .highlightColor)),
                                  SizedBox(width: 8),
                                  Text('',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .highlightColor)),
                                ]),
                                Row(
                                  children: [
                                    Text('',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor)),
                                    const SizedBox(width: 8),
                                    Text('',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor)),
                                    const SizedBox(width: 8),
                                    Text('',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }))
          ],
        ));
  }
}
