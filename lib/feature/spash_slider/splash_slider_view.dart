import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:kahve/feature/log_reg_pass/login/login_view.dart';
import 'package:kahve/product/constants/color_constants.dart';
import 'package:kahve/product/constants/img_constants.dart';
import 'package:kahve/product/constants/string_constants.dart';
import 'package:kartal/kartal.dart';

class SplashSliderView extends StatefulWidget {
  const SplashSliderView({super.key});

  @override
  State<SplashSliderView> createState() => _SplashSliderViewState();
}

class _SplashSliderViewState extends State<SplashSliderView> {
  List<Slide> slides = [];

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      colorActiveDot: ColorTextConstants.textprimary,
      renderNextBtn: Text(
        'Sonraki',
        style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(
          color: ColorTextConstants.textprimary,
        )),
      ),
      renderPrevBtn: Text(
        'Önceki',
        style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(
          color: ColorTextConstants.textprimary,
        )),
      ),
      renderSkipBtn: Text(
        'Bitir',
        style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(
          color: ColorTextConstants.textprimary,
        )),
      ),
      renderDoneBtn: TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
            (Route<dynamic> route) => false,
          );
        },
        child: Text(
          'Başla!',
          style: GoogleFonts.nunito(
              textStyle: context.general.textTheme.bodyMedium?.copyWith(
            color: ColorTextConstants.textprimary,
          )),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    slides.add(
      Slide(
        textAlignTitle: TextAlign.center,
        textAlignDescription: TextAlign.center,
        styleTitle: GoogleFonts.nunito(
          textStyle: context.general.textTheme.bodyMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        styleDescription: GoogleFonts.nunito(
          textStyle: context.general.textTheme.labelMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
        marginTitle:
            const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 75),
        marginDescription: const EdgeInsets.all(20),
        title: SplashSliderTextConstants.sliderTitleText1,
        description: SplashSliderTextConstants.sliderSubTitleText1,
        pathImage: AppSplashSliderImgConstant.appSliderImg1.toPng,
        heightImage: 350,
        widthImage: 350,
        backgroundColor: const Color.fromARGB(255, 251, 251, 251),
      ),
    );
    slides.add(
      Slide(
        textAlignTitle: TextAlign.center,
        textAlignDescription: TextAlign.center,
        styleTitle: GoogleFonts.nunito(
          textStyle: context.general.textTheme.bodyMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        styleDescription: GoogleFonts.nunito(
          textStyle: context.general.textTheme.labelMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
        marginTitle:
            const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 75),
        marginDescription: const EdgeInsets.all(20),
        title: SplashSliderTextConstants.sliderTitleText2,
        description: SplashSliderTextConstants.sliderSubTitleText2,
        pathImage: AppSplashSliderImgConstant.appSliderImg2.toPng,
        heightImage: 350,
        widthImage: 350,
        backgroundColor: const Color.fromARGB(255, 251, 251, 251),
      ),
    );
    slides.add(
      Slide(
        textAlignTitle: TextAlign.center,
        textAlignDescription: TextAlign.center,
        styleTitle: GoogleFonts.nunito(
          textStyle: context.general.textTheme.bodyMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        styleDescription: GoogleFonts.nunito(
          textStyle: context.general.textTheme.labelMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
        marginTitle:
            const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 75),
        marginDescription: const EdgeInsets.all(20),
        title: SplashSliderTextConstants.sliderTitleText3,
        description: SplashSliderTextConstants.sliderSubTitleText3,
        pathImage: AppSplashSliderImgConstant.appSliderImg3.toPng,
        heightImage: 350,
        widthImage: 350,
        backgroundColor: const Color.fromARGB(255, 251, 251, 251),
      ),
    );
    slides.add(
      Slide(
        textAlignTitle: TextAlign.center,
        textAlignDescription: TextAlign.center,
        styleTitle: GoogleFonts.nunito(
          textStyle: context.general.textTheme.bodyMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        styleDescription: GoogleFonts.nunito(
          textStyle: context.general.textTheme.labelMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
        marginTitle:
            const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 75),
        marginDescription: const EdgeInsets.all(20),
        title: SplashSliderTextConstants.sliderTitleText4,
        description: SplashSliderTextConstants.sliderSubTitleText4,
        pathImage: AppSplashSliderImgConstant.appSliderImg5.toPng,
        heightImage: 350,
        widthImage: 350,
        backgroundColor: const Color.fromARGB(255, 251, 251, 251),
      ),
    );
    slides.add(
      Slide(
        textAlignTitle: TextAlign.center,
        textAlignDescription: TextAlign.center,
        styleTitle: GoogleFonts.nunito(
          textStyle: context.general.textTheme.bodyMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        styleDescription: GoogleFonts.nunito(
          textStyle: context.general.textTheme.labelMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
        marginTitle:
            const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 75),
        marginDescription: const EdgeInsets.all(20),
        title: SplashSliderTextConstants.sliderTitleText5,
        description: SplashSliderTextConstants.sliderSubTitleText5,
        pathImage: AppSplashSliderImgConstant.appSliderImg4.toPng,
        heightImage: 350,
        widthImage: 350,
        backgroundColor: const Color.fromARGB(255, 251, 251, 251),
      ),
    );
  }
}
