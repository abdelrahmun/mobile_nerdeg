//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// enum SnackBarStates { ERROR, SUCCESS, NORMAL }
//
// const double baseHeight = 844.0;
// const double baseWidth = 390.0;
//
// double screenAwareHeight(double size, BuildContext context) {
//   double drawingHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
//   return size * drawingHeight / baseHeight;
// }
//
// double screenAwareSize(double size, BuildContext context) {
//   double drawingHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
//   return size * drawingHeight / baseHeight;
// }
//
// double screenAwareWidth(double size, BuildContext context) {
//   double drawingWidth = MediaQuery.of(context).size.width - 16;
//   return size * drawingWidth / baseWidth;
// }
//
// class Utils {
//   static String subtractEndpointFromURL(String url) => url.split('v1/')[1];
//
//
//   static showToast({
//     required String message,
//     int duration = 2,
//     SnackBarStates state = SnackBarStates.NORMAL,
//   }) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: state == SnackBarStates.NORMAL
//           ? Colors.white
//           : state == SnackBarStates.ERROR
//               ? Colors.red
//               : Colors.green,
//       textColor: state == SnackBarStates.NORMAL ? Colors.black : Colors.white,
//       fontSize: 16.0,
//     );
//   }
//
//   static showLoaderDialog(BuildContext context, {String message = ''}) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 16.0,
//             horizontal: 16.0,
//           ),
//           insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//           content: Row(
//             children: [
//               SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
//               const SizedBox(width: 12),
//               Text(
//                 '${AppLocalizations.translateInstant('loading', defaultText: 'Loading...')} $message',
//                 style: Theme.of(context).textTheme.displaySmall,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   static Widget getPriceText(
//     context, {
//     required double price,
//     String? currency,
//     String? selection,
//     double priceFontSize = 20,
//     double selectionFontSize = 12,
//     FontWeight priceFontWeight = FontWeight.w500,
//     FontWeight selectionFontWeight = FontWeight.w400,
//     Color? priceColor,
//     Color? selectionColor,
//     bool hasDecimal = true,
//     TextAlign align = TextAlign.start,
//     CrossAxisAlignment? alignment,
//   }) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: alignment ?? CrossAxisAlignment.end,
//       children: [
//         Text(
//           '${hasDecimal ? Constants.priceFormat.format(price) : Constants.priceTotalFormat.format(price)} ${currency ?? AppLocalizations.translateInstant('AED', defaultText: 'AED')}',
//           style: Theme.of(context).textTheme.displayMedium!.copyWith(
//                 fontSize: priceFontSize,
//                 color: priceColor ?? AppColors.almostTotalBlackColor,
//                 fontWeight: priceFontWeight,
//               ),
//         ),
//         if (selection != null)
//           Text(
//             selection,
//             style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                   fontSize: selectionFontSize,
//                   color: selectionColor ?? AppColors.thirdTextColor,
//                   fontWeight: selectionFontWeight,
//                 ),
//           ),
//       ],
//     );
//   }
//
//   static void dismissKeyboard(BuildContext context) {
//     FocusScopeNode currentFocus = FocusScope.of(context);
//     if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
//       currentFocus.focusedChild?.unfocus();
//     }
//   }
//
//   static bool isDarkMode(context) {
//     final brightness = MediaQuery.of(context).platformBrightness;
//     return brightness == Brightness.dark;
//   }
//
//   static String obscureInput(String input) {
//     if (input.contains('@')) {
//       // Case for email
//       List<String> parts = input.split('@');
//       String username = parts[0];
//       String domain = parts[1];
//
//       if (username.length > 1) {
//         username = username[0] + '*' * (username.length - 2) + username[username.length - 1];
//       }
//
//       if (domain.contains('.') && domain.length > 3) {
//         int lastDotIndex = domain.lastIndexOf('.');
//         String domainPrefix = domain.substring(0, lastDotIndex);
//         String domainSuffix = domain.substring(lastDotIndex);
//
//         if (domainPrefix.length > 1) {
//           domainPrefix = domainPrefix[0] + '*' * (domainPrefix.length - 1);
//         }
//
//         domain = '$domainPrefix$domainSuffix';
//       }
//
//       return '$username@$domain';
//     } else if (RegExp(r'^[+\d]+$').hasMatch(input)) {
//       // Case for numeric input
//       String prefix = input[0] == '+' ? '+' : '';
//       String numbers = input.replaceAll(RegExp(r'[^\d]'), '');
//
//       if (numbers.length > 1) {
//         numbers = numbers[0] + '*' * (numbers.length - 2) + numbers[numbers.length - 1];
//       }
//
//       return '$prefix$numbers';
//     } else {
//       return input; // Return input as is for other cases
//     }
//   }
//
//   static bool isValidEmailOrPhoneNumber(String input) {
//     if (input.contains('@')) {
//       // Case for email
//       List<String> parts = input.split('@');
//       if (parts.length != 2 || parts[0].isEmpty) {
//         return false; // Invalid email format
//       }
//       // Check if the domain part has at least one dot and characters after the last dot
//       if (!parts[1].contains('.') || parts[1].split('.').last.isEmpty) {
//         return false; // Invalid email format
//       }
//     } else if (!RegExp(r'^[+\d]+$').hasMatch(input)) {
//       return false; // Neither a valid email nor a numeric input
//     }
//
//     return true;
//   }
//
//   static String? passwordValidation(String? value, {String? confirmationValue}) {
//     if (value == null) {
//       return AppLocalizations.translateInstant('please_enter_valid_password',
//           defaultText: 'Please enter valid password');
//     } else if (value.isEmpty) {
//       return AppLocalizations.translateInstant('please_enter_valid_password',
//           defaultText: 'Please enter valid password');
//     } else if (value.length < 8) {
//       return AppLocalizations.translateInstant('password_must_me_more_than_8_char',
//           defaultText: 'Password must be more than 8 characters');
//     } else if (confirmationValue != null) {
//       if (confirmationValue != value) {
//         return AppLocalizations.translateInstant('passwords_do_not_match.', defaultText: 'Passwords do not match');
//       }
//     }
//     return null;
//   }
//
//   static String? validateFormInput(String? value,
//       {String? inputName, int minLength = 4, required String nullCaseMessage, required String validCaseMessage}) {
//     if (value == null) {
//       return nullCaseMessage;
//     } else if (value.length < minLength) {
//       return validCaseMessage;
//     }
//     return null;
//   }
//
//   static Future<String> compressImageWebp(String imagePath) async {
//     try {
//       final dir = await path_provider.getTemporaryDirectory();
//       final imageBaseName = path.basename(imagePath);
//       final targetPath = '${dir.absolute.path}/$imageBaseName.webp';
//
//       var result = await FlutterImageCompress.compressAndGetFile(
//         imagePath,
//         targetPath,
//         quality: 80,
//         format: CompressFormat.webp,
//       );
//
//       return result!.path;
//     } catch (e) {
//       debugPrint(e.toString());
//       return '';
//     }
//   }
// }
