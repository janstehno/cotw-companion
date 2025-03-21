import 'package:cotwcompanion/generated/assets.gen.dart';
import 'package:cotwcompanion/helpers/json.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/interface/style.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/miscellaneous/values.dart';
import 'package:cotwcompanion/model/connect/animal_fur_image.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:cotwcompanion/widgets/app/padding.dart';
import 'package:cotwcompanion/widgets/button/switch_icon.dart';
import 'package:cotwcompanion/widgets/handling/drop_down.dart';
import 'package:cotwcompanion/widgets/handling/drop_down_item.dart';
import 'package:cotwcompanion/widgets/indicator/page_indicator.dart';
import 'package:cotwcompanion/widgets/text/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WidgetAnimalFurImages extends StatefulWidget {
  final Animal _animal;

  const WidgetAnimalFurImages(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  Animal get animal => _animal;

  @override
  WidgetAnimalFurImagesState createState() => WidgetAnimalFurImagesState();
}

class WidgetAnimalFurImagesState extends State<WidgetAnimalFurImages> {
  late final PageController _pageController;
  late final List<AnimalFurImage> _furImages;

  late AnimalFurImage _selectedFur;
  late List<String> _selectedFurImages;

  int _selectedImageIndex = 0;
  CategoryType _selectedCategory = CategoryType.male;

  @override
  void initState() {
    super.initState();
    _furImages = HelperJSON.getAnimalsFursImages(widget.animal.id);
    if (_furImages.isNotEmpty) {
      _selectedFur = _furImages.first;
      _selectedFurImages = _selectedFur.imagesFor(_selectedCategory);
    }
    _initializeController();
  }

  void _initializeController() {
    _pageController = PageController(viewportFraction: 1, initialPage: 0);
  }

  void _updateSelectedFur(AnimalFurImage furImage) {
    setState(() {
      _selectedFur = furImage;
      _selectedImageIndex = 0;
      _selectedCategory = furImage.hasBoth
          ? CategoryType.male
          : furImage.hasMale
              ? CategoryType.male
              : CategoryType.female;
    });
  }

  void _updateSelectedFurImages() {
    setState(() {
      _selectedFurImages = _selectedFur.imagesFor(_selectedCategory);
    });
  }

  void _onFurSelected(AnimalFurImage fur) {
    setState(() {
      _updateSelectedFur(fur);
      _updateSelectedFurImages();
    });
  }

  void _toggleGender() {
    setState(() {
      _selectedCategory = _selectedCategory == CategoryType.male ? CategoryType.female : CategoryType.male;
      _updateSelectedFurImages();
    });
  }

  void _selectVersion(int index) {
    setState(() {
      _selectedImageIndex = index;
    });
  }

  String _getIcon(AnimalFurImage furImage) {
    if (furImage.isGO) {
      return Assets.graphics.icons.trophyGreatOne;
    } else if (furImage.shared || furImage.hasBoth) {
      return Assets.graphics.icons.gender;
    } else if (furImage.hasMale) {
      return Assets.graphics.icons.genderMale;
    } else {
      return Assets.graphics.icons.genderFemale;
    }
  }

  Color _getIconColor(AnimalFurImage furImage) {
    if (furImage.isGO) {
      return Interface.disabled;
    } else if (furImage.shared || furImage.hasBoth) {
      return Interface.dark;
    } else if (furImage.hasMale) {
      return Interface.genderMale;
    } else {
      return Interface.genderFemale;
    }
  }

  double _getIconSize(AnimalFurImage furImage) {
    if (furImage.isGO || furImage.shared || furImage.hasBoth) {
      return Values.iconSize;
    } else if (furImage.hasMale) {
      return Values.iconSize - 2;
    } else {
      return Values.iconSize - 2;
    }
  }

  Widget _buildDropdown() {
    return WidgetDropDown<AnimalFurImage>(
      value: _selectedFur,
      items: _furImages.map((furImage) {
        return DropdownMenuItem(
          value: furImage,
          child: WidgetDropDownItem(
            text: furImage.furName,
            icon: _getIcon(furImage),
            color: _getIconColor(furImage),
            size: _getIconSize(furImage),
          ),
        );
      }).toList(),
      background: Interface.odd,
      onChange: (fur) => _onFurSelected(fur!),
    );
  }

  Widget _buildGenderButton() {
    return WidgetPadding.all(
      20,
      alignment: Alignment.bottomRight,
      child: WidgetSwitchIcon(
        Assets.graphics.icons.genderMale,
        activeIcon: Assets.graphics.icons.genderFemale,
        color: Interface.alwaysDark,
        background: Interface.blue,
        activeColor: Interface.alwaysDark,
        activeBackground: Interface.red,
        onTap: _toggleGender,
        isActive: _selectedCategory == CategoryType.female,
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      _selectedFurImages[_selectedImageIndex],
      height: 320,
      alignment: Alignment.center,
      fit: BoxFit.contain,
    );
  }

  Widget _buildImageView() {
    return Container(
      height: 320,
      alignment: Alignment.center,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _selectedFurImages.length,
        onPageChanged: (index) => _selectVersion(index),
        itemBuilder: (context, index) => _buildImage(),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      alignment: Alignment.center,
      child: WidgetPageIndicator(
        _selectedFurImages.length,
        height: Values.dotSize,
        iColor: Interface.disabled,
        aColor: Interface.primary,
        pageController: _pageController,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Interface.body,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              _buildImageView(),
              if (_selectedFurImages.isNotEmpty && _selectedFur.hasBoth) _buildGenderButton(),
            ],
          ),
          if (_selectedFurImages.length > 1) _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildDisclaimer() {
    return WidgetPadding.h30v20(
      child: WidgetText(
        tr("DISCLAIMER_MODEL"),
        autoSize: false,
        textAlign: TextAlign.center,
        color: Interface.disabled,
        style: Style.normal.s8.w300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDropdown(),
        _buildBody(),
        _buildDisclaimer(),
      ],
    );
  }
}
