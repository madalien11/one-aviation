String priceFormatter(String price) {
  String result = '';
  double num = double.parse(price);
  result = num.ceil().toString();
  return '€ ' + result;
}
