import 'package:equatable/equatable.dart';

class GeocodingLocalNamesEntity extends Equatable {
  final String? ar;
  final String? ascii;
  final String? bg;
  final String? ca;
  final String? de;
  final String? el;
  final String? en;
  final String? fa;
  final String? featureName;
  final String? fi;
  final String? fr;
  final String? gl;
  final String? he;
  final String? hi;
  final String? id;
  final String? it;
  final String? ja;
  final String? la;
  final String? lt;
  final String? pt;
  final String? ru;
  final String? sr;
  final String? th;
  final String? tr;
  final String? vi;
  final String? zu;

  const GeocodingLocalNamesEntity({
    required this.ar,
    required this.ascii,
    required this.bg,
    required this.ca,
    required this.de,
    required this.el,
    required this.en,
    required this.fa,
    required this.featureName,
    required this.fi,
    required this.fr,
    required this.gl,
    required this.he,
    required this.hi,
    required this.id,
    required this.it,
    required this.ja,
    required this.la,
    required this.lt,
    required this.pt,
    required this.ru,
    required this.sr,
    required this.th,
    required this.tr,
    required this.vi,
    required this.zu,
  });

  @override
  List<Object?> get props => [
        ar,
        ascii,
        bg,
        ca,
        de,
        el,
        en,
        fa,
        featureName,
        fi,
        fr,
        gl,
        he,
        hi,
        id,
        it,
        ja,
        la,
        lt,
        pt,
        ru,
        sr,
        th,
        tr,
        vi,
        zu
      ];
}
