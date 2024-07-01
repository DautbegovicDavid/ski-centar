import 'package:skicentar_desktop/models/ticket_type_seniority.dart';
import 'package:skicentar_desktop/providers/base_provider.dart';

class TicketTypeSeniorityProvider extends BaseProvider<TicketTypeSeniority> {
  TicketTypeSeniorityProvider(): super("TicketTypeSeniority");

  @override
  TicketTypeSeniority fromJson(data) {
    return TicketTypeSeniority.fromJson(data);
  }
}