class ApiConstance {
  static const String BASEURL = 'https://accept.paymob.com/api/';
  static const String APIKEY =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnVZVzFsSWpvaWFXNXBkR2xoYkNJc0ltTnNZWE56SWpvaVRXVnlZMmhoYm5RaUxDSndjbTltYVd4bFgzQnJJam8xTXpNNE1UVjkuTWZUdlF0WC1idlIwbjdyX2lwQnQ3S2tFYnAtdlJHTzc0NXJRcTZITDJ4QklaTlZPSG9weGJpRjNXR3d5Um0zejBtb0pOYVh6TlU2VzJzbGUwQm5oLWc=';

  static const String FIRST_TOKEN_ENDPOINT = 'auth/tokens';
  static const String ORDER_ID_ENDPOINT = 'ecommerce/orders';
  static const String FINAL_TOKEN_ENDPOINT = 'acceptance/payment_keys';
  static const String REFCODE_ENDPOINT = 'acceptance/payments/pay';

  static String PAYMENT_FIRST_TOKEN = '';
  static String PAYMENT_ORDER_ID = '';

  static String PAYMENT_FINAL_TOKEN_VISA = '';
  static String PAYMENT_FINAL_TOKEN_KIOSK = '';

  static String REFCODE = '';

  static const String INTEGRATION_ID_VISACARD = '2844106';
  static const String INTEGRATION_ID_KIOSK = '2844127';

  static const String FRAME_URL =
      'https://accept.paymob.com/api/acceptance/iframes/680789?payment_token=';
}
