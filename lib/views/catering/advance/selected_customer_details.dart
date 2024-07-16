import 'package:intl/intl.dart';
import '../../widgets/export.dart';

class CateringAdvanceCustomerDetails extends StatefulWidget {
  String? name;
  String? phone;
  String? address;
  String? tableId;
  List? items;
  String? customerId;
  CateringAdvanceCustomerDetails(
      {super.key,
      required this.name,
      required this.phone,
      required this.address,
      required this.tableId,
      required this.items,
      required this.customerId});

  @override
  State<CateringAdvanceCustomerDetails> createState() =>
      _CateringAdvanceCustomerDetailsState();
}

class _CateringAdvanceCustomerDetailsState
    extends State<CateringAdvanceCustomerDetails> {
  DateTime startDate = DateTime.now().add(const Duration(days: 30));
  String formattedStartDate = "";
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _formattedSelectedTime = '';
  final cateringOrderController = Get.put(CateringOrderController());

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay initialTime = _selectedTime;

    // If _formattedSelectedTime is empty, set it to the current time in 12-hour format
    if (_formattedSelectedTime.isEmpty) {
      initialTime = TimeOfDay.now();
      _formattedSelectedTime = _formatTime(initialTime);
      setState(() {});
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      // Format the selected time in 12-hour format
      String formattedTime = _formatTime(picked);

      // Update the UI or store the formatted time as needed
      setState(() {
        _selectedTime = picked;
        _formattedSelectedTime =
            formattedTime; // Assign the formatted time to _formattedSelectedTime
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    // Format the time in 12-hour format
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    String formattedTime =
        '$hour:${time.minute.toString().padLeft(2, '0')} $period';
    return formattedTime;
  }

  startDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
        // barrierColor: Theme.of(context).highlightColor,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: (365 * 5))));

    setState(() {
      startDate = selectedDate as DateTime;
      formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
    });

    return formattedStartDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, "Advance Order Details", ""),
      body: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            border: Border.all(color: Theme.of(context).highlightColor),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ListTile(
              title: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: customText(
                  'Customer',color: Theme.of(context).highlightColor),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(children: [
                customText('Name:',color: Theme.of(context).highlightColor),
                const SizedBox(width: 8),
                customText(widget.name!,color: Theme.of(context).highlightColor),
              ]),
              Row(
                children: [
                  customText('Phone:',color: Theme.of(context).highlightColor),
                  const SizedBox(width: 8),
                  customText(widget.phone!,color: Theme.of(context).highlightColor)
                ],
              ),
              Row(
                children: [
                  customText('Address:',color: Theme.of(context).highlightColor),
                  const SizedBox(width: 8),
                  customText(widget.address!,color: Theme.of(context).highlightColor)
                ],
              )
            ],
          )),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              datePick(context, false,
                  title:
                      formattedStartDate.isNotEmpty ? formattedStartDate : null,
                  color: Theme.of(context).highlightColor, onpress: () {
                startDatePicker();
              }),
              const SizedBox(width: 10),
              datePick(context, true,
                  title: _formattedSelectedTime.isEmpty
                      ? "Select Time"
                      : _formattedSelectedTime,
                  color: Theme.of(context).highlightColor, onpress: () {
                _selectTime(context);
              }),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              onPressed: () {
                if (_formattedSelectedTime.isEmpty ||
                    formattedStartDate.isEmpty) {
                  snackBarBottom(
                      "Error", "Please Select Date and Time", context);
                } else {
                  cateringOrderController.confirmCatAdvOrder(
                      widget.tableId, widget.items, widget.customerId, 
                      "$formattedStartDate $_formattedSelectedTime "
                      );

                      
                      
                }
              },
              child: customText("Proceed to Order",
                  color: Theme.of(context).scaffoldBackgroundColor)),
        ),
      ]),
    );
  }
}
