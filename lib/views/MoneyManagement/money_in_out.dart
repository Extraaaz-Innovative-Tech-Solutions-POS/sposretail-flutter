import 'package:spos_retail/views/widgets/export.dart';

class MoneyInOut extends StatelessWidget {
  const MoneyInOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context, "Money In", '',
        action: [
          IconButton(
            onPressed: (){},
             icon: Icon(Icons.edit)
             ),

              IconButton(
            onPressed: (){},
             icon: Icon(Icons.delete)
             ),
        ]
        ),
      body: Center(
        child: Text("MoneyInOut"),
      ),
    );
  }
}