abstract class PaymentRepository {
  Future<bool> processPayment(double amount, String method);
}

class MockPaymentRepository implements PaymentRepository {
  @override
  Future<bool> processPayment(double amount, String method) async {
    // Simulate payment processing delay
    await Future.delayed(const Duration(seconds: 2));
    return true; // Always success for now
  }
}
