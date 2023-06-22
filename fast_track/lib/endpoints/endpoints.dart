class EndPoints{
  EndPoints._();
  static const String ip_address="172.16.41.57:9000";

  // base url
  static const String getTokeUrl = "http://$ip_address/v1/api/token";
  static const String registerUrl = "http://$ip_address/v1/api/registration";
  static const String confirmTokenUrl="http://$ip_address/api/v1/registration/confirm";
  static const String resetUrl="http://$ip_address/api/v1/registration/reset";
  static const String resendUrl="http://$ip_address/api/v1/registration/resend";
  static const String forgortPassUrl="http://$ip_address/api/v1/registration/forgot";
  static const String contactUrl="http://$ip_address/api/v1/registration/contact";
  static const String incidentUrl="http://$ip_address/v1/api/incident";
  static const String complaintUrl="http://$ip_address/v1/api/incident";


  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;






}