class Language{
  static bool isEn = true;

  Map<String, String> textEn = {
    'home': 'HOME',
    'item_capture': 'ITEM CAPTURE',
    'asset_verification': 'ASSET VERIFICATION',
    'asset_counter': 'ASSET COUNTER',
    'asset_position': 'ASSETS POSITION',
    'about': 'ABOUT US',
    'settings': 'SETTINGS',
    'upload': 'UPLOAD',
    'exel': 'EXCEL',
    'open_page_error': 'This transaction not assign to you ',
    'error_occurred': 'An error Occurred ',
    'ok': 'ok',
    'done': 'DONE',
    'capture_header_title': 'ITEM',
    'capture_header_subTitle': 'Capture',
    'verification_header_title': 'ASSETS ',
    'verification_header_subTitle': 'VERIFICATION',
    'counter_header_title': 'ASSETS ',
    'counter_header_subTitle': 'Counter',
    'setting_header_title': 'ASSETS ',
    'setting_header_subTitle': 'SETTINGS',
    'asset_information_title': 'ASSET LOCATION INFORMATION',
    'country': 'COUNTRY',
    'city': 'CITY',
    'area': 'AREA',
    'location_type': 'LOCATION TYPE',
    'floor': 'FLOOR NO',
    'section': 'SECTION NO',
    'department': 'DEPARTMENT',
    'main_category': 'Main CATEGORY',
    'category': 'CATEGORY',
    'items': 'ITEMS',
    'description': 'DESCRIPTION',
    'brand': 'BRAND',
    'note': 'NOTES',
    'width': 'WIDTH',
    'height': 'HEIGHT',
    'length': 'LENGTH',
    'quantity': 'QUANTITY',
    'photo': 'PHOTO',
    'hint_cm_label': 'ENTER VALUE IN CM',
    'user_name': 'USER NAME',
    'language': 'LANGUAGE',
    'validation': 'Fill in the empty fields',
    'validate_numbers': 'Pleas enter valid numbers',
    'validate_color': 'Pleas choose color',
    'successful_upload': 'Transaction done successfully',
    'login_again': 'Please Log in again to get another transaction',
    'item_total': 'ITEM TOTAL',
    'assets_total': 'ASSETS TOTAL',
    'remain': 'REMAIN',
    'add': 'ADD ',
    'choose_color': 'CHOOSE COLOR',
    'pick_color': 'Pick a color!',
    'get_color': 'Got it',
    'barcode': 'BARCODE',
    'asset_details': 'ASSET DETAILS',
    'serial': 'SERIAL NO',
    'update_asset': 'Updated',
    'tab_barcode': 'Tap to scan barcode',
    'no_item_found': 'There is no item found with this barcode',
    'asset_desc': 'ASSET DESC',
    'no': 'NO',
    'type': 'TYPE',
    'qnt_table': 'QNT',
    'desc_table': 'DESC',
    'check_table': 'CHECK',
    'date': 'DATE',
    'time': 'TIME',
  };

  Map<String, String> textAr = {
    'home': 'الرئيسية',
    'item_capture': 'التقاط عنصر',
    'asset_verification': 'تاكيد الاصول',
    'asset_counter': 'جرد الاصول',
    'asset_position': 'مكان الأصول',
    'about': 'عنا',
    'settings': 'الاعدادات',
    'upload': 'رفع',
    'exel': 'ايكسل',
    'open_page_error': 'هذه الصفحة ليست متاحة لك',
    'error_occurred': 'حدث خطأ ما',
    'ok': 'تم',
    'done': 'تم',
    'capture_header_title': 'إلتقاط ',
    'capture_header_subTitle': 'عنصر',
    'verification_header_title': 'تأكيد ',
    'verification_header_subTitle': 'الأصل',
    'counter_header_title': 'جرد ',
    'counter_header_subTitle': 'الأصل',
    'setting_header_title': 'اعدادات ',
    'setting_header_subTitle': 'الاصول',
    'asset_information_title': 'معلومات مواقع الاصول',
    'country': 'بلد',
    'city': 'مدينة',
    'area': 'منطقة',
    'location_type': 'نوع الموقع',
    'floor': 'الطابق',
    'section': 'الوحدة',
    'department': 'القسم',
    'main_category': 'الصنف الأساسي',
    'category': 'الصنف',
    'items': 'العناصر',
    'description': 'الوصف',
    'brand': 'البراند',
    'note': 'ملاحظات',
    'width': 'العرض',
    'height': 'الطول',
    'length': 'الأمتداد',
    'quantity': 'الكمية',
    'photo': 'الصورة',
    'hint_cm_label': 'ادخل قيمة بالسم',
    'user_name': 'اسم المستخدم',
    'language': 'اللغة',
    'validation': 'املأ الحقول الفارغة',
    'validate_numbers': 'الرجاء ادخال ارقام صحيحة',
    'validate_color': 'الرجاء اختيار لون',
    'successful_upload': 'الإجراء تم بنجاح',
    'login_again': 'الرجاء تسجيل الدخول مجددا للحصول على اجراء اخر',
    'item_total': 'مجموع العناصر',
    'assets_total': 'مجموع الأصول',
    'remain': 'متبقى',
    'add': 'إضافة ',
    'choose_color': 'إختر لون',
    'pick_color': 'إختر لون',
    'get_color': 'اختيار',
    'barcode': 'باركود',
    'asset_details': 'تفاصيل الاصل',
    'serial': 'سيريال',
    'update_asset': 'تم التعديل',
    'tab_barcode': 'اضغط لمسح الباركود',
    'no_item_found': 'لا يوجد عنصر بهذا الباركود',
    'asset_desc': 'وصف الأصل',
    'no': 'العدد',
    'type': 'النوع',
    'qnt_table': 'الكمية',
    'desc_table': 'الوصف',
    'check_table': 'فحص',
    'date': 'التاريخ',
    'time': 'الوقت',
  };

  changeLan(bool lan){
    isEn = lan;
  }

  String getTxt(String txt){
    if(isEn) return textEn[txt]!;
    return textAr[txt]!;
  }

}