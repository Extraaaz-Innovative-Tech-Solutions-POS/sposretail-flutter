import '../../widgets/export.dart';

class AdditionalNotes extends StatefulWidget {
  const AdditionalNotes({super.key});

  @override
  State<AdditionalNotes> createState() => _AdditionalNotesState();
}

class _AdditionalNotesState extends State<AdditionalNotes> {
  final _printernameController = TextEditingController();

  String? noteAdded;
  @override
  void initState() {
    super.initState();
    getSharedPrefrenceLocal();
  }

  saveNotes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("AddNote", _printernameController.text).whenComplete(
      () {
        snackBarBottom("Sucess", "Note Saved Sucessfully", context);
        getSharedPrefrenceLocal();
      },
    );
    setState(() {});
  }

  getSharedPrefrenceLocal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    noteAdded = pref.getString("AddNote");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, "Additional Notes", ""),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Add Notes",
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  color: Theme.of(context).focusColor,
                  child: TextField(
                    controller: _printernameController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Theme.of(context).highlightColor),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).highlightColor),
                        ),
                        hintText: 'Enter Your Note',
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                )),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  saveNotes();
                 
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side:
                            BorderSide(color: Theme.of(context).primaryColor))),
                child: Text(
                  "Save",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Your Notes......."),
            ),
            Container(
                height: 60.0,
                width: double.infinity,
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    border:
                        Border.all(color: Theme.of(context).highlightColor)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: customText(
                    noteAdded ?? "Not Connected",
                    color: Theme.of(context).primaryColor, 
                  ),
                ),
              ),
          ],
        ));
  }
}
