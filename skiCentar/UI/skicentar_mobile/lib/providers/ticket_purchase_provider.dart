import 'package:skicentar_mobile/models/ticket_purchase.dart';
import 'package:skicentar_mobile/providers/base_provider.dart';

class TicketPurchaseProvider extends BaseProvider<TicketPurchase> {
  TicketPurchaseProvider() : super("TicketPurchase");

  @override
  TicketPurchase fromJson(data) {
    return TicketPurchase.fromJson(data);
  }
}