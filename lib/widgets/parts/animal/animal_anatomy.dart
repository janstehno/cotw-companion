import 'package:cotwcompanion/interface/graphics.dart';
import 'package:cotwcompanion/interface/interface.dart';
import 'package:cotwcompanion/miscellaneous/enums.dart';
import 'package:cotwcompanion/model/translatable/animal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetAnimalAnatomy extends StatelessWidget {
  final Animal _animal;

  const WidgetAnimalAnatomy(
    Animal animal, {
    super.key,
  }) : _animal = animal;

  Widget _buildBody() {
    return SvgPicture.asset(
      Graphics.getAnatomyAsset(_animal, AnatomyPart.body),
      fit: BoxFit.fitHeight,
      colorFilter: ColorFilter.mode(
        Interface.anatomyBody,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildOrgans() {
    return SvgPicture.asset(
      Graphics.getAnatomyAsset(_animal, AnatomyPart.organs),
      fit: BoxFit.fitHeight,
    );
  }

  Widget _buildWidgets() {
    return SizedBox(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          _buildBody(),
          _buildOrgans(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildWidgets();
}
