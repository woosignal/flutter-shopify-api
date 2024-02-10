// Copyright (c) 2024, WooSignal Ltd.
// All rights reserved.
//
// Redistribution and use in source and binary forms are permitted
// provided that the above copyright notice and this paragraph are
// duplicated in all such forms and that any documentation,
// advertising materials, and other materials related to such
// distribution and use acknowledge that the software was developed
// by the WooSignal. The name of the
// WooSignal may not be used to endorse or promote products derived
// from this software without specific prior written permission.
// THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

/// TaxName enum
enum TaxName { grt, gst, hst, pst, qst, rst, sst, stateTax, tax, the_00, vat }

/// The following EnumValues class is used to convert the enum to and from a string
final taxNameValues = EnumValues({
  "GRT": TaxName.grt,
  "GST": TaxName.gst,
  "HST": TaxName.hst,
  "PST": TaxName.pst,
  "QST": TaxName.qst,
  "RST": TaxName.rst,
  "SST": TaxName.sst,
  "State Tax": TaxName.stateTax,
  "Tax": TaxName.tax,
  "0.0": TaxName.the_00,
  "VAT": TaxName.vat
});

/// EnumValues class
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
