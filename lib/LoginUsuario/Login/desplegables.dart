class TipoDocumento{
  final String? titulo, valor;

  TipoDocumento(this.titulo, this.valor);
}

final List options = [
  TipoDocumento("Cedula de Ciudadanía", "CC"),
  TipoDocumento("Cedula de Extranjería", "CE"),
  TipoDocumento("Pasaporte", "PAS"),
  TipoDocumento("Número de identificación tributaria", "NIT"),
];

class TipoBanco{
  final String? titulo, valor;

  TipoBanco(this.titulo, this.valor);
}

final List items = [
  TipoBanco("BANCOLOMBIA", "BANCOLOMBIA"),
  TipoBanco("Banco de Bogotá", "Banco de Bogotá"),
  TipoBanco("Banco caja social", "Banco caja social"),
  TipoBanco("Av Villas", "Av Villas"),
  TipoBanco("Banco de occidente", "Banco de occidente"),
  TipoBanco("Banco Popular", "Banco Popular"),
  TipoBanco("Banco Agrario", "Banco Agrario"),
  TipoBanco("Davivienda", "Davivienda"),
  TipoBanco("Colpatria", "Colpatria"),
];