import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:drinks/core/enums.dart';
import 'package:drinks/core/navigation_service.dart';
import 'package:drinks/shared/palette.dart';
import 'package:drinks/shared/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Functions {
  static Future<void> showMessageResponseStatus(
    ResponseStatus responseStatus,
    String operation,
    String? vowel,
    String module,
  ) async {
    String messageException = responseStatus == ResponseStatus.success
        ? '${capitalFirstLetter(module)} $operation com sucesso.'
        : responseStatus == ResponseStatus.error
            ? 'Não foi possível $operation $vowel $module, tente novamente.'
            : responseStatus == ResponseStatus.timeout
                ? 'Tempo da consulta excedido, tente novamente.'
                : 'Você não está conectado a internet.';

    await Functions.showGeneralAlertDialog(
      messageException,
      responseStatus == ResponseStatus.success ? TypeMessageDialog.info : TypeMessageDialog.error,
    );
  }

  static Future<void> showGeneralAlertDialog(
    String textBody,
    TypeMessageDialog typeOfMessage,
  ) async {
    BuildContext context = NavigationService.navigatorKey.currentContext!;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => CustomAlertDialogView(
        title: getTitleMessageDialog(typeOfMessage),
        subTitle: textBody,
        icon: Icon(
          getIconMessageDialog(typeOfMessage),
          size: 30,
          color: getColorMessageDialog(typeOfMessage),
        ),
      ),
    );
  }

  static void showNetworkImage(
    BuildContext context,
    String imageUrl,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Palette.black,
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Palette.black26,
            surfaceTintColor: Palette.black26,
            leading: IconButton(
              color: Palette.white,
              icon: const Icon(
                Icons.close_rounded,
                color: Palette.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(imageUrl),
              backgroundDecoration: const BoxDecoration(color: Palette.black),
              maxScale: PhotoViewComputedScale.covered * 2.0,
              minScale: PhotoViewComputedScale.contained,
            ),
          ),
        ),
      ),
    );
  }

  static String getTitleMessageDialog(TypeMessageDialog typeOfMessage) {
    return typeOfMessage == TypeMessageDialog.info
        ? 'Olá'
        : typeOfMessage == TypeMessageDialog.warning
            ? 'Atenção'
            : 'Erro';
  }

  static IconData getIconMessageDialog(TypeMessageDialog typeOfMessage) {
    return typeOfMessage == TypeMessageDialog.info
        ? Icons.info_outline_rounded
        : typeOfMessage == TypeMessageDialog.warning
            ? Icons.warning_amber_rounded
            : Icons.error_outline_rounded;
  }

  static Color getColorMessageDialog(TypeMessageDialog typeOfMessage) {
    return typeOfMessage == TypeMessageDialog.info
        ? Palette.blue
        : typeOfMessage == TypeMessageDialog.warning
            ? Palette.warning
            : Palette.error;
  }

  static String capitalFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text.substring(0, 1).toUpperCase() + text.substring(1, text.length).toLowerCase();
  }

  static Future<bool> checkConn() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult != ConnectivityResult.mobile) && (connectivityResult != ConnectivityResult.wifi)) {
      return false;
    }
    return true;
  }
}
