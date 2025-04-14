import 'dart:ui';

import 'package:flutter/material.dart';

extension GoogleFontsFix on TextStyle {
  // https://github.com/material-foundation/flutter-packages/issues/141
  // https://github.com/material-foundation/flutter-packages/issues/35
  TextStyle mimicWith({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) {
    return copyWith(
      // We should set the default font family to 'Raleway' to fix
      // the fontWeight issue
      fontFamily:
          PlatformDispatcher.instance.locale.languageCode == 'en'
              ? 'Raleway'
              : 'IBMPlexSansArabic',
      inherit: inherit ?? this.inherit,
      color:
          this.foreground == null && foreground == null
              ? color ?? this.color
              : null,
      backgroundColor:
          this.background == null && background == null
              ? backgroundColor ?? this.backgroundColor
              : null,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      leadingDistribution: leadingDistribution ?? this.leadingDistribution,
      locale: locale ?? this.locale,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      shadows: shadows ?? this.shadows,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      fontVariations: fontVariations ?? this.fontVariations,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
      // fontFamilyFallback: fontFamilyFallback ?? _fontFamilyFallback,
      // package: package ?? _package,
      overflow: overflow ?? this.overflow,
    );
  }
}
