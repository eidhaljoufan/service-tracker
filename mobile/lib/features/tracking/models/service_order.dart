class ServiceOrder {
  const ServiceOrder({
    required this.plate,
    required this.model,
    required this.issue,
    required this.status,
    this.estimate,
    this.handoverDate,
    this.customerNotes,
    this.customerName,
  });

  final String plate;
  final String model;
  final String issue;
  final String status;
  final String? estimate;
  final String? handoverDate;
  final String? customerNotes;
  final String? customerName;

  factory ServiceOrder.fromJson(Map<String, dynamic> json) {
    String read(String key) => (json[key] ?? '').toString().trim();
    String? optional(String key) {
      final val = read(key);
      return val.isEmpty ? null : val;
    }

    return ServiceOrder(
      plate: read('plate'),
      model: read('model'),
      issue: read('issue'),
      status: read('status'),
      estimate: optional('estimate'),
      handoverDate: optional('handoverDate'),
      customerNotes: optional('customerNotes'),
      customerName:
          optional('customerName') ?? optional('customer') ?? optional('name'),
    );
  }
}
