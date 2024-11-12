import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_mobile/models/search_result.dart';
import 'package:skicentar_mobile/models/ticket_purchase.dart';
import 'package:skicentar_mobile/providers/ticket_purchase_provider.dart';
import 'package:skicentar_mobile/providers/user_provider.dart';
import 'package:skicentar_mobile/utils/utils.dart';

class TicketHistoryScreen extends StatefulWidget {
  const TicketHistoryScreen({super.key});

  @override
  State<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen> {
  late TicketPurchaseProvider ticketPurchaseProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    ticketPurchaseProvider =
        Provider.of<TicketPurchaseProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket History'),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: FutureBuilder<SearchResult<TicketPurchase>>(
        future: ticketPurchaseProvider.get(filter: {'userId': currentUser!.id}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null || snapshot.data!.result.isEmpty) {
            return const Center(
              child: Text('No ticket history available.'),
            );
          }

          final ticketList = snapshot.data!.result;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: ticketList.length,
            itemBuilder: (context, index) {
              final ticket = ticketList[index];
              final isFullDay = ticket.ticket?.ticketType?.fullDay ?? false;

              final validFromDate = ticket.ticket?.validFrom;
              final validFromTime = DateTime(
                validFromDate?.year ?? 0,
                validFromDate?.month ?? 0,
                validFromDate?.day ?? 0,
                9,
              );
              final validToTime = isFullDay
                  ? validFromTime.add(const Duration(hours: 7)) // 9 AM to 4 PM
                  : validFromTime.add(const Duration(hours: 4)); // 9 AM to 1 PM

              final currentTime = DateTime.now();
              final today = DateTime(
                  currentTime.year, currentTime.month, currentTime.day);
              String status;
              if (validFromDate != null && validFromDate.isAfter(today)) {
                status = 'Not Yet Valid';
              } else if (validFromDate != null &&
                  currentTime.isAfter(validFromTime) &&
                  currentTime.isBefore(validToTime)) {
                status = 'Valid';
              } else {
                status = 'Expired';
              }

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currentUser?.userDetails?.name != null) ...[
                        Text(
                          'User: ${currentUser!.userDetails!.name} ${currentUser!.userDetails!.lastName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.confirmation_num,
                                  size: 24.0, color: Colors.blue),
                              const SizedBox(width: 12.0),
                              Text(
                                ticket.ticket?.description ?? 'No description',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: status == 'Valid'
                                  ? Colors.green.withOpacity(0.2)
                                  : status == 'Not Yet Valid'
                                      ? Colors.orange.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  status == 'Valid'
                                      ? Icons.check_circle
                                      : status == 'Not Yet Valid'
                                          ? Icons.access_time
                                          : Icons.cancel,
                                  size: 16.0,
                                  color: status == 'Valid'
                                      ? Colors.green
                                      : status == 'Not Yet Valid'
                                          ? Colors.orange
                                          : Colors.red,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  status,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: status == 'Valid'
                                        ? Colors.green
                                        : status == 'Not Yet Valid'
                                            ? Colors.orange
                                            : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const Row(
                        children: [
                          Icon(Icons.shopping_cart,
                              size: 16.0, color: Colors.blueGrey),
                          SizedBox(width: 8.0),
                          Text(
                            'Purchase Details',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                          'Purchase Date: ${formatDate(ticket.purchaseDate!)}'),
                      const SizedBox(height: 12.0),
                      const Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 16.0, color: Colors.blueGrey),
                          SizedBox(width: 8.0),
                          Text(
                            'Validity Info',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                          '${formatDate(validFromTime)} | ${formatTime(validFromTime)} - ${formatTime(validToTime)}'),
                      const SizedBox(height: 12.0),
                      const Row(
                        children: [
                          Icon(Icons.info, size: 16.0, color: Colors.blueGrey),
                          SizedBox(width: 8.0),
                          Text(
                            'Ticket Info',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Type:',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            isFullDay ? 'Full Day' : 'Half Day',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Seniority:',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            ticket.ticket?.ticketType?.ticketTypeSeniority
                                    ?.seniority ??
                                'No data',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price:',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            '${ticket.totalPrice} KM',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
