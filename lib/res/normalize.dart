String normalizeNikText(String text) {
  String result = text.toUpperCase();

  result = result.replaceAll('NIK', '').replaceAll(':', '').trim();

  return result;
}

String normalizeNamaText(String text) {
  String result = text.toUpperCase();

  result = result
      .replaceAll('AMA', '')
      .replaceAll('-', '')
      .replaceAll('NA', '')
      .replaceAll('NEMA', '')
      .replaceAll('NAME', '')
      .replaceAll(':', '')
      .trim();
  return result;
}

String normalizeJenisKelaminText(String text) {
  String result = text.toUpperCase();

  result = result
      .replaceAll("GOL. DARAHO", "")
      .replaceAll("GOL. DARAH", "")
      .replaceAll("GOL DARAH", "")
      .replaceAll("ÐARAH", "")
      .replaceAll("LAKFEARI", "")
      .replaceAll("KELAR", "")
      .replaceAll("KELARMIN", "")
      .replaceAll("LAKFLAK", "")
      .replaceAll("KELAMIN", "")
      .replaceAll("KEIAMIN", "")
      .replaceAll("JENIS", "")
      .replaceAll("DENIS", "")
      .replaceAll("DARAH ", "")
      .replaceAll("ENIS", "")
      .replaceAll("DARA", "")
      .replaceAll("GO", "")
      .replaceAll("L. ", "")
      .replaceAll(" H0", "")
      .replaceAll(" HO", "")
      .replaceAll(":", "")
      .replaceAll(" 0", "")
      .replaceAll(" O", "")
      .replaceAll(" A", "")
      .trim();

  if (result == "LAK-LAK" ||
      result == "LAKI-LAK" ||
      result == "LAKEEAK HE" ||
      result == "AK-LAK" ||
      result == "LAKFLAKI" ||
      result == "KEAMIN TAKHAKI" ||
      result == "LAKHLAK" ||
      result == "LAKIHAKI" ||
      result == "LAKFEAKI" ||
      result == "LAKELAKI" ||
      result == "LAKELAK" ||
      result == "LAKHLAKI" ||
      result == "LAKHEAK" ||
      result == "LAK-LAKI" ||
      result == "LAKHEAKI" ||
      result == "LAKIFEAK" ||
      result == "LAKFEAKE" ||
      result == "LAKIFEAKI" ||
      result == "LAKIAKI" ||
      result == "LAKFEAR" ||
      result == "LAKFLAK" ||
      result == "LAK-LAKE" ||
      result == "LAK-EAK" ||
      result == "LAKI-AKI" ||
      result == "LAKFEAK" ||
      result == "LAK-EAKI" ||
      result == "LAKIHAKI -" ||
      result == "JENS TAKELAKI" ||
      result == "LAKEAKE" ||
      result == "LAKI-LAKI" ||
      result == "LAKELAKE") {
    return result = "LAKI-LAKI";
  }

  return result;
}

String normalizeAlamatText(String text) {
  String result = text.toUpperCase();

  result = result
      .replaceAll("RI/KEILDESAA", "")
      .replaceAll("RTKELIIDESAA", "")
      .replaceAll("TIKEL/LDESA", "")
      .replaceAll("RTKEL/DESAA", "")
      .replaceAll("RTKELVDESA", "")
      .replaceAll("RIKELBESAA", "")
      .replaceAll("KECAMATAN", "")
      .replaceAll("KEL/DESSA", "")
      .replaceAll("KELIDESAA", "")
      .replaceAll("KELI/DESA", "")
      .replaceAll("KELILDESA", "")
      .replaceAll("KELIIDESA", "")
      .replaceAll("KELILDESA", "")
      .replaceAll("KEL/ DESA", "")
      .replaceAll("KELLIDESA", "")
      .replaceAll("KECAMATDN", "")
      .replaceAll("HECAMATAN", "")
      .replaceAll("KEILIBESA", "")
      .replaceAll("KELILBESA", "")
      .replaceAll("NECAMATAN", "")
      .replaceAll("KELL/DESA", "")
      .replaceAll("KEL/DESAA", "")
      .replaceAll("KELLDESAA", "")
      .replaceAll("KEL/DESA", "")
      .replaceAll("KELLIBES", "")
      .replaceAll("KEI/DESA", "")
      .replaceAll("HELLDESA", "")
      .replaceAll("KELIBESA", "")
      .replaceAll("KELLBESA", "")
      .replaceAll("KEL/DESA", "")
      .replaceAll("KELLDESA", "")
      .replaceAll("KEILDESA", "")
      .replaceAll("KEILBESA", "")
      .replaceAll("KELIDESA", "")
      .replaceAll("KEVDESA", "")
      .replaceAll("KEVBESA", "")
      .replaceAll("KELBESA", "")
      .replaceAll("KE/DESA", "")
      .replaceAll("ELLDESA", "")
      .replaceAll("KELDESA", "")
      .replaceAll("ALAMAT", "")
      .replaceAll("LAMAT", "")
      .replaceAll("RTIRW", "")
      .replaceAll("RT/RW", "")
      .replaceAll("ELDESA", "")
      .replaceAll("KEVDES", "")
      .replaceAll("RTIRWN", "")
      .replaceAll(" TIA ", " ")
      .replaceAll("RT ", "")
      .replaceAll("RT", "")
      .replaceAll("GOL.DARAH 0", "")
      .replaceAll("RT/ ", "")
      .replaceAll("RW ", "")
      .replaceAll(":", "")
      .replaceAll("=", "")
      .replaceAll("  ", " ")
      .trim();

  return result;
}

String normalizeKawinText(String text) {
  String result = text.toUpperCase();

  result = result
      .replaceAll("PERKAWINAN", "")
      .replaceAll("PERKAWINA", "")
      .replaceAll("STATUS", "")
      .replaceAll("TATUS", "")
      .replaceAll("STAFUS", "")
      .replaceAll("R ", "")
      .replaceAll("T ", "")
      .replaceAll(":", "")
      .trim();

  return result;
}

String normalizePekerjaanText(String text) {
  String result = text.toUpperCase();

  result = result.replaceAll("PEKERJAAN", "").replaceAll(":", "").trim();

  if (result == "PELAJARIMAHASISSWA" ||
      result == "PELAJARIMAHASISWA" ||
      result == "PELAJARIMAHASISVWA" ||
      result == "PELAJAFRIMAHASISVWA" ||
      result == "PELAJARMAHASISWA" ||
      result == "PELAJAAMAHASISWA") {
    return "PELAJAR/MAHASISWA";
  }
  return result;
}

String normalizeKewarganegaraanText(String text) {
  String result = text.toUpperCase();

  result = result
      .replaceAll("KEWARGANEGARAAN", "")
      .replaceAll("EUMUR", "")
      .replaceAll("HDUP", "")
      .replaceAll("H ", "")
      .replaceAll("N ", "")
      .replaceAll(":", "")
      .trim();

  return result;
}

String normalizeAgamaText(String text) {
  String result = text.toUpperCase();

  result = result
      .replaceAll("AGAMA", "")
      .replaceAll(":", "")
      .replaceAll("GAMA", "")
      .trim();

  if (result == "SLAM" ||
      result == "AM" ||
      result == "ISTAM" ||
      result == "SLA AM" ||
      result == "ISLU AM" ||
      result == "SL LAM" ||
      result == "ISLAME" ||
      result == "SLA M" ||
      result == "ISL AM" ||
      result == "ISLA AM" ||
      result == "S AM" ||
      result == "SLL AM" ||
      result == "SL AM" ||
      result == "SE AM" ||
      result == "1SLAM" ||
      result == "ISLAMM" ||
      result == "SLA" ||
      result == "ISUAM" ||
      result == "1SUAM" ||
      result == "SUAM" ||
      result == ";ISUAM" ||
      result == ":ISUAM" ||
      result == "LAM") {
    result = "ISLAM";
  }
  print(result);
  if (result.trim().isEmpty) {
    return "";
  } else {
    return result;
  }
}
