enum ProductListEnums {
  errorTitleText('Ürünler Yüklenmedi!'),
  errorSubTitleText(
      'Ürünlerin Yüklenmesi esnasında hata oluştu, daha sonra tekrar deneyiniz!'),

  noTitleText('Henüz Ürün Oluşturulmadı!'),
  noSubTitleText(
      'İlgili Kategoriye Ait ürün bulunamadı, diğer kategorileri göz gezdirebilirsiniz.'),

  loadingTitleText('Ürünler Yükleniyor'),
  loadingSubTitleText('Lütfen Bekleyiniz...');

  final String value;
  const ProductListEnums(this.value);
}
