import 'package:flutter/material.dart';
import 'package:spos_retail/views/MoneyManagement/money_in_out.dart';
import 'package:spos_retail/views/widgets/export.dart';

class MoneyListItem extends StatelessWidget {
  final String customerName;
  final String money;
  final String paymentMethod;
  final String date;

  const MoneyListItem({
    Key? key,
    required this.customerName,
    required this.money,
    required this.paymentMethod,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Get.to(MoneyInOut());
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(5)
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Theme.of(context).primaryColor,strokeAlign: BorderSide.strokeAlignInside ),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Text(
                      customerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            money,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
      
                          SizedBox(width: 14,),
      
                          Divider(height: 20,color: Theme.of(context).primaryColor,thickness: 1,),
      
                          Text(
                            paymentMethod,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
