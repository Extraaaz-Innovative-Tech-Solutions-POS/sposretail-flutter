import 'package:shared_preferences/shared_preferences.dart';

class InvoiceManager {
  static const _keyInvoiceId = 'invoice_id';
  static const _keySavedDate = 'saved_date';

  late SharedPreferences _prefs;

  int? _currentInvoiceId;
  DateTime? _savedDate;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _currentInvoiceId = _prefs.getInt(_keyInvoiceId) ?? 0;
    final savedDateMillis = _prefs.getInt(_keySavedDate);
    _savedDate = savedDateMillis != null ? DateTime.fromMillisecondsSinceEpoch(savedDateMillis) : null;
  }

  int? get currentInvoiceId => _currentInvoiceId;

  Future<void> updateInvoiceId() async {
    final currentDate = DateTime.now();
    if (_savedDate == null || _savedDate!.day != currentDate.day) {
      _currentInvoiceId = 1; // Start a new sequence for the new day
    } else {
      _currentInvoiceId = (_currentInvoiceId ?? 0) + 1;
    }
    _savedDate = currentDate;
    await _prefs.setInt(_keyInvoiceId, _currentInvoiceId!);
    await _prefs.setInt(_keySavedDate, _savedDate!.millisecondsSinceEpoch);
  }

  Future<void> resetInvoiceId() async {
    _currentInvoiceId = 0;
    _savedDate = null;
    await _prefs.remove(_keyInvoiceId);
    await _prefs.remove(_keySavedDate);
  }
}
