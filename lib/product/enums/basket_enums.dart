enum BasketStrings {
  basketErrorTitleText('Sepet Yüklenmedi'),
  basketErrorDescriptionText(
      'Sepet yüklenirken bir hata oluştu, daha sonra tekrar deneyiniz.'),

  basketLoadingTitleText('Sepet Yükleniyor'),
  basketLoadingDescriptionText('Lütfen Bekleyiniz...'),

  basketNoProductTitleText('Sepetinizde Henüz Ürün Yok'),
  basketNoProductDescriptionText(
      'Sepetinizde henüz ürün yok alışverişe başlayın ve sepetinizi doldurun!'),

  orderEndTitleText('Siparişinizi Başarıyla Oluşturuldu!'),
  orderEndDescriptionText(
      'Vermiş olduğunuz sipariş için teşekkür ederiz, siparişinizi profilinizde bulunan siparişlerim sayfası ile takip edebilirsiniz.'),
  orderButtonText('Alışverişe Devam Et');

  final String value;
  const BasketStrings(this.value);
}
