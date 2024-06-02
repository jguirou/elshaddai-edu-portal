
import 'package:intl/intl.dart';

class Formatter {

  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'fr_FR', symbol: "€").format(amount);
  }

  static String formatPhoneNumber(String  phoneNumber){
    if(phoneNumber.length == 10){
      return '${phoneNumber.substring(0,2)} ${phoneNumber.substring(2,4)} ${phoneNumber.substring(4,6)} ${phoneNumber.substring(6,8)} ${phoneNumber.substring(8)}';
    } else if(phoneNumber.length == 14){
      return '${phoneNumber.substring(0,2)} ${phoneNumber.substring(2,4)} ${phoneNumber.substring(4,6)} ${phoneNumber.substring(6,8)} ${phoneNumber.substring(8)}';
    }
    return phoneNumber;
  }

  static String internationalFormatPhoneNumber(String  phoneNumber){

    // Remove any one-digit characters from the phone numbers
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code from digitsOnly
    String countryCode = '+${digitsOnly.substring(0,2)}';
    digitsOnly = digitsOnly.substring(2);


    // Add remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while(i< digitsOnly.length){
      int groupLength = 2;
      if(i == 0 && countryCode == '+1'){

        groupLength = 3;
      }
      int end = i+ groupLength;
      formattedNumber.write(digitsOnly.substring(i,end));
      if(end < digitsOnly.length ){
        formattedNumber.write(' ');
      }
      i = end ;

    }
    return phoneNumber;
  }
}