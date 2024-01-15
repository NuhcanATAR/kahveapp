enum FavoriteStrings {
  errorTitleText('Favori Ürünler Yüklenemedi'),
  errorSubTitleText(
      'Favori Ürünleriniz yüklenirken bir sorun oluştu, daha sonra tekrar deneyiniz.'),

  loadingTitleText('Favori Ürünler Yükleniyor'),
  loadingSubTitleText('Lütfen Bekleyiniz...'),

  noTitleText('Favori Ürününüz Bulunmamaktadır'),
  noSubTitleText(
      'Henüz favori ürün eklemediniz isterseniz favori ürünlerinizi eklemeye başlayabilirsiniz.');

  final String value;
  const FavoriteStrings(this.value);
}
