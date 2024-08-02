// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class WhatsAppService {
//   final String _baseUrl = 'https://graph.facebook.com/v17.0/'; // Update this URL if needed
//   final String _accessToken; // Your WhatsApp Business API access token
//   final String _phoneNumberId; // Your WhatsApp Business account phone number ID

//   WhatsAppService({required String accessToken, required String phoneNumberId})
//       : _accessToken = accessToken,
//         _phoneNumberId = phoneNumberId;

//   Future<WhatsAppResponse> sendMessage({
//     required String phoneNumber,
//     required String text,
//     bool previewUrl = false,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$_baseUrl$_phoneNumberId/messages'),
//         headers: {
//           'Authorization': 'Bearer $_accessToken',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'messaging_product': 'whatsapp',
//           'to': phoneNumber,
//           'type': 'text',
//           'text': {'preview_url': previewUrl, 'body': text},
//         }),
//       );

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         return WhatsAppResponse(
//           success: true,
//           messageId: responseData['messages'][0]['id'],
//           httpCode: response.statusCode,
//         );
//       } else {
//         final errorData = jsonDecode(response.body);
//         return WhatsAppResponse(
//           success: false,
//           httpCode: response.statusCode,
//           errorMessage: errorData['error']['message'],
//         );
//       }
//     } catch (e) {
//       return WhatsAppResponse(
//         success: false,
//         httpCode: 500,
//         errorMessage: 'An unexpected error occurred: ${e}',
//       );
//     }
//   }
// }

// class WhatsAppResponse {
//   final bool success;
//   final String? messageId;
//   final int httpCode;
//   final String? errorMessage;

//   WhatsAppResponse({
//     required this.success,
//     this.messageId,
//     required this.httpCode,
//     this.errorMessage,
//   });

//   bool isSuccess() => success;
//   String? getMessageId() => messageId;
//   int getHttpCode() => httpCode;
//   String? getErrorMessage() => errorMessage;
// }