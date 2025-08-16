class Trabajo {
    String? statusTrab;
    String? idot;
    String? ot;
    String? actividad;
    String? vh;
    String? modelo;
    String? responsable;
    String? idprogot;
    String? item;
    String? idaccion;
    String? trabajo;
    DateTime? fini;
    String? hini;
    DateTime? ffin;
    String? hfin;
    String? idtecnico1;
    int? activo;
    dynamic origenprog;
    int? idzona;
    dynamic itemd;
    dynamic finid;
    dynamic hinid;
    dynamic ffind;
    dynamic hfind;
    String? idtecnico1D;
    dynamic activod;

    Trabajo({
        this.statusTrab,
        this.idot,
        this.ot,
        this.actividad,
        this.vh,
        this.modelo,
        this.responsable,
        this.idprogot,
        this.item,
        this.idaccion,
        this.trabajo,
        this.fini,
        this.hini,
        this.ffin,
        this.hfin,
        this.idtecnico1,
        this.activo,
        this.origenprog,
        this.idzona,
        this.itemd,
        this.finid,
        this.hinid,
        this.ffind,
        this.hfind,
        this.idtecnico1D,
        this.activod,
    });

    factory Trabajo.fromJson(Map<String, dynamic> json) => Trabajo(
        statusTrab: json["STATUS_TRAB"],
        idot: json["IDOT"],
        ot: json["OT"],
        actividad: json["ACTIVIDAD"],
        vh: json["VH"],
        modelo: json["MODELO"],
        responsable: json["RESPONSABLE"],
        idprogot: json["IDPROGOT"],
        item: json["ITEM"],
        idaccion: json["IDACCION"],
        trabajo: json["TRABAJO"],
        fini: json["FINI"] == null ? null : DateTime.parse(json["FINI"]),
        hini: json["HINI"],
        ffin: json["FFIN"] == null ? null : DateTime.parse(json["FFIN"]),
        hfin: json["HFIN"],
        idtecnico1: json["IDTECNICO1"],
        activo: json["ACTIVO"],
        origenprog: json["ORIGENPROG"],
        idzona: json["IDZONA"],
        itemd: json["ITEMD"],
        finid: json["FINID"],
        hinid: json["HINID"],
        ffind: json["FFIND"],
        hfind: json["HFIND"],
        idtecnico1D: json["IDTECNICO1D"],
        activod: json["ACTIVOD"],
    );

    Map<String, dynamic> toJson() => {
        "STATUS_TRAB": statusTrab,
        "IDOT": idot,
        "OT": ot,
        "ACTIVIDAD": actividad,
        "VH": vh,
        "MODELO": modelo,
        "RESPONSABLE": responsable,
        "IDPROGOT": idprogot,
        "ITEM": item,
        "IDACCION": idaccion,
        "TRABAJO": trabajo,
        "FINI": "${fini!.year.toString().padLeft(4, '0')}-${fini!.month.toString().padLeft(2, '0')}-${fini!.day.toString().padLeft(2, '0')}",
        "HINI": hini,
        "FFIN": "${ffin!.year.toString().padLeft(4, '0')}-${ffin!.month.toString().padLeft(2, '0')}-${ffin!.day.toString().padLeft(2, '0')}",
        "HFIN": hfin,
        "IDTECNICO1": idtecnico1,
        "ACTIVO": activo,
        "ORIGENPROG": origenprog,
        "IDZONA": idzona,
        "ITEMD": itemd,
        "FINID": finid,
        "HINID": hinid,
        "FFIND": ffind,
        "HFIND": hfind,
        "IDTECNICO1D": idtecnico1D,
        "ACTIVOD": activod,
    };
}