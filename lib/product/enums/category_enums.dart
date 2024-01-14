enum CategoryEnums {
  noMainCategoryTitleText('Ana Ürün Kategorileri Oluşturulmadı!'),
  noMainCategorySubTitleText(
      'Henüz ana ürün kategorileri oluşturulmadı, daha sonra tekrar deneyiniz.'),
  noSubCategoryTitleText('Alt Ürün Kategorileri Oluşturulmadı!'),
  noSubCategorySubTitleText(
      'Henüz Alt ürün kategorileri oluşturulmadı, daha sonra tekrar deneyiniz.'),

  errorMainCategoryTitleText('Ana Kategoriler Yüklenmedi!'),
  errorMainCategorySubTitleText(
      'Ana Kategoriler yüklenirken bir hata oluştu daha sonra tekrar deneyiniz.'),
  errorSubCategoryTitleText('Alt Kategoriler Yüklenmedi!'),
  errorSubCategorySubTitleText(
      'Alt Kategoriler yüklenirken bir hata oluştu daha sonra tekrar deneyiniz.'),

  loadingCategoryTitleText('Yükleniyor'),
  loadingCategorySubTitleText('Lütfen Bekleyiniz...');

  final String value;
  const CategoryEnums(this.value);
}
