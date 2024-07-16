import 'package:spos_retail/views/widgets/export.dart';

//|| _passwordcontroller.text.length == 10

class Updatestaff extends StatelessWidget {
  const Updatestaff({Key? key}) : super(key: key);
  static const Color Orange = Color.fromARGB(0, 255, 180, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Center(
              child: customText(
                "Update Staff",
                font: 30.0,
              ),
            ),
          ),
          _buildTextFieldWithHeading(context, "Name"),
          const SizedBox(height: 5),
          _buildTextFieldWithHeading(context, "Email Id"),
          const SizedBox(height: 5),
          _buildTextFieldWithHeading(context, "Phone"),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Update'),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildTextFieldWithHeading(context, String heading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            heading,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50,
              child: TextField(
                keyboardType: TextInputType.text,
                style:
                    TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 11, 11, 11),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
