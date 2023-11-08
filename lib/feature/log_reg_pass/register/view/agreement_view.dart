import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/utility/base/log_reg_pass_base/register_base/register_base.dart';

class AgreementView extends StatefulWidget {
  const AgreementView({super.key});

  @override
  State<AgreementView> createState() => _AgreementViewState();
}

class _AgreementViewState extends MainRegisterBase<AgreementView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: ColorTextConstants.textgreenDarker,
                size: 18,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Kullanıcı Sözleşmesi",
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: ColorTextConstants.textgreenDarker,
                    ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                // title content
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Kahve Kullanıcı Gizlilik ve Satış Sözleşmesi",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      textStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.black,
                              ),
                    ),
                  ),
                ),
                SizedBox(
                  height: dynamicHeight(0.05),
                ),
                // agrement detail contet
                // min title
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "- İŞLENEN KİŞİSEL VERİLER",
                    style: GoogleFonts.nunito(
                      textStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // text
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Kahve ile olan ilişkiniz kapsamında kimlik ve iletişim bilgileriniz (ad soyadı, doğum tarihi ve yeri, TC kimlik no, e-posta adresi, iletişim adresi, telefon numarası vb.), lokasyon bilgileriniz (iş adresi, mobil konum vb.), özlük bilgileriniz (bordro ve özgeçmiş bilgileri vb.), müşteri işlem ve işlem güvenliği bilgileriniz (sipariş bilgisi, şikayet ve talep bilgisi, fatura, senet, çek bilgileri, şifre ve parola bilgileri vb.), ceza mahkumiyeti ve güvenlik tedbirleri bilgileriniz, finans bilgileriniz (finansal performans, tarım arazisi ve ürünlere ilişkin bilgiler vb.), mesleki deneyim bilgileriniz (diploma, gidilen kurslar vb.), hukuki işlem bilgileriniz (adli makamlarla olan yazışmalardaki ve dava dosyalarındaki bilgiler), risk yönetimi bilgileriniz (ticari, teknik ve idari risklerin yönetilmesi için işlenen bilgiler), pazarlama bilgileriniz (alışveriş geçmişi vb.), görsel işitsel kayıtlarınız (fotoğraflar) ve fiziksel mekan güvenliğine ilişkin veriler (CCTV kayıtları) otomatik olan ve olmayan yollarla işlenmektedir",
                    style: GoogleFonts.nunito(
                      textStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Colors.black54,
                              ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // min title
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "KİŞİSEL VERİLERİN İŞLENME AMAÇLARI",
                    style: GoogleFonts.nunito(
                      textStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // text
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Yukarıda bahsi geçen kişisel verileriniz, Tarfin tarafından veri sorumlusu sıfatıyla aşağıda yer alan amaçlar kapsamında işlenmektedir:Mal / hizmet satış süreçlerinin yürütülmesiTedarik zinciri yönetimi süreçlerinin yürütülmesiMal / hizmet satın alım süreçlerinin yürütülmesiSözleşme süreçlerinin yürütülmesiRisk yönetimi süreçlerinin yürütülmesiErişim yetkilerinin yürütülmesi / denetimiFinans ve muhasebe işlerinin yürütülmesiSaklama ve arşiv faaliyetlerinin yürütülmesiİş süreçlerinin iyileştirilmesine yönelik önerilerin alınması ve değerlendirilmesiMal / hizmet satış sonrası destek hizmetlerinin yürütülmesiTalep veya şikayetlerin takibiFuar, organizasyon ve diğer etkinliklerin yönetimiÜrün / hizmetlerin pazarlama süreçlerinin yürütülmesiMüşteri ilişkileri yönetimi süreçlerinin yürütülmesi",
                    style: GoogleFonts.nunito(
                      textStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Colors.black54,
                              ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
