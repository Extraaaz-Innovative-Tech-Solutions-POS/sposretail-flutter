import 'export.dart';

Widget textFieldWithHeading(
     // key,
      String heading,
      BuildContext context,
      String hinttext,
      TextInputType keyboardtype,
      {onchanged, key, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: customText(heading,
                font: 16.0,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor)),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: key,
            child: SizedBox(
              height: 55,
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardtype,
                style: TextStyle(color: Theme.of(context).highlightColor),
                decoration: InputDecoration(
                  hintText: hinttext,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0), 
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    //gapPadding: 5.0,
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).highlightColor),
                  ),
                ),
                onChanged: onchanged,
                validator: (value) {
                  if (value == "") {
                    return 'Please Enter $heading';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
          ),
        ),
      ],
    );
  }