enum OrderStrings {
  errorOrderTitleText('Sipariş Yüklenemedi!'),
  errorOrderSubTitleText(
      'Siparişler yüklenirken bir hata oluştu, daha sonra tekrar deneyiniz.'),

  loadingOrderTitleText('Sipariş Yükleniyor'),
  loadingOrderSubTitleText('Lütfen Bekleyiniz...'),

  noOrderTitleText('Siparişiniz Bulunmamaktadır!'),
  noOrderSubTitleText(
      'Henüz sipariş vermediniz isterseniz sipariş verebilirsiniz.');

  final String value;
  const OrderStrings(this.value);
}
