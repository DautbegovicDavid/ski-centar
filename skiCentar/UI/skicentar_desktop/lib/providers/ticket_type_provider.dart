import 'package:skicentar_desktop/models/ticket_type.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';

class TicketTypeProvider extends BaseProvider<TicketType> {
  TicketTypeProvider(): super("TicketType");

  @override
  TicketType fromJson(data) {
    return TicketType.fromJson(data);
  }
}