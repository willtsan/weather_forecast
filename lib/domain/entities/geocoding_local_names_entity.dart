class GeocodingLocalNamesEntity {
  String? ar;
  String? ascii;
  String? bg;
  String? ca;
  String? de;
  String? el;
  String? en;
  String? fa;
  String? featureName;
  String? fi;
  String? fr;
  String? gl;
  String? he;
  String? hi;
  String? id;
  String? it;
  String? ja;
  String? la;
  String? lt;
  String? pt;
  String? ru;
  String? sr;
  String? th;
  String? tr;
  String? vi;
  String? zu;

  GeocodingLocalNamesEntity(
      {ar,
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
      zu});

  GeocodingLocalNamesEntity.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    ascii = json['ascii'];
    bg = json['bg'];
    ca = json['ca'];
    de = json['de'];
    el = json['el'];
    en = json['en'];
    fa = json['fa'];
    featureName = json['feature_name'];
    fi = json['fi'];
    fr = json['fr'];
    gl = json['gl'];
    he = json['he'];
    hi = json['hi'];
    id = json['id'];
    it = json['it'];
    ja = json['ja'];
    la = json['la'];
    lt = json['lt'];
    pt = json['pt'];
    ru = json['ru'];
    sr = json['sr'];
    th = json['th'];
    tr = json['tr'];
    vi = json['vi'];
    zu = json['zu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ar'] = ar;
    data['ascii'] = ascii;
    data['bg'] = bg;
    data['ca'] = ca;
    data['de'] = de;
    data['el'] = el;
    data['en'] = en;
    data['fa'] = fa;
    data['feature_name'] = featureName;
    data['fi'] = fi;
    data['fr'] = fr;
    data['gl'] = gl;
    data['he'] = he;
    data['hi'] = hi;
    data['id'] = id;
    data['it'] = it;
    data['ja'] = ja;
    data['la'] = la;
    data['lt'] = lt;
    data['pt'] = pt;
    data['ru'] = ru;
    data['sr'] = sr;
    data['th'] = th;
    data['tr'] = tr;
    data['vi'] = vi;
    data['zu'] = zu;
    return data;
  }
}
