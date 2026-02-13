import 'package:flutter/material.dart';
import 'package:moona/utils/helper/formatters/date_formatter.dart';
import 'package:moona/utils/helper/navigation/push_to.dart';

import '../../managers/server/order/order_api.dart';
import '../../models/order/order.dart';
import 'order_details.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final ScrollController _controller = ScrollController();

  List<OrderModel> orders = [];
  bool loading = true;
  bool loadingMore = false;
  bool hasMore = true;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadOrders();

    _controller.addListener(() {
      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 200 &&
          !loadingMore &&
          hasMore) {
        _loadMore();
      }
    });
  }

  Future<void> _loadOrders() async {
    loading = true;
    setState(() {});

    final res = await OrdersApi.getOrders(currentPage);

    orders = res['orders'];
    hasMore = res['hasMore'];

    loading = false;
    setState(() {});
  }

  Future<void> _loadMore() async {
    if (!hasMore) return;

    loadingMore = true;
    currentPage++;

    setState(() {});

    final res = await OrdersApi.getOrders(currentPage);

    orders.addAll(res['orders']);
    hasMore = res['hasMore'];

    loadingMore = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F9),
        appBar: AppBar(
          title: const Text(
            'طلباتي',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                controller: _controller,
                padding: const EdgeInsets.all(16),
                itemCount: orders.length + (loadingMore ? 1 : 0),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (index == orders.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return OrderCard(order: orders[index]);
                },
              ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final statusData = _statusConfig(mapOrderStatus(order.status));

    return GestureDetector(
      onTap: () {
        pushTo(context, OrderDetailsScreen(orderId: order.id));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // LEFT ICON
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: statusData.bg,
                shape: BoxShape.circle,
              ),
              child: Icon(statusData.icon, color: statusData.color, size: 22),
            ),

            const SizedBox(width: 12),

            // INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'طلب ${order.id}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatDate(DateTime.parse(order.date.toString())),
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // STATUS + TOTAL
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusData.bg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusData.text,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusData.color,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${order.total}﷼",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= STATUS CONFIG =================
enum OrderStatus { pending, onTheWay, delivered, canceled }

OrderStatus mapOrderStatus(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
    case 'preparing':
      return OrderStatus.pending;

    case 'on_the_way':
    case 'shipping':
      return OrderStatus.onTheWay;

    case 'completed':
    case 'delivered':
      return OrderStatus.delivered;

    case 'canceled':
      return OrderStatus.canceled;

    default:
      return OrderStatus.pending;
  }
}

_StatusUI _statusConfig(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return _StatusUI(
        text: 'قيد التحضير',
        icon: Icons.hourglass_bottom,
        color: Colors.orange,
        bg: Colors.orange.withOpacity(0.15),
      );
    case OrderStatus.onTheWay:
      return _StatusUI(
        text: 'في الطريق',
        icon: Icons.local_shipping_outlined,
        color: Colors.blue,
        bg: Colors.blue.withOpacity(0.15),
      );
    case OrderStatus.delivered:
      return _StatusUI(
        text: 'تم التوصيل',
        icon: Icons.check_circle_outline,
        color: Colors.green,
        bg: Colors.green.withOpacity(0.15),
      );
    case OrderStatus.canceled:
      return _StatusUI(
        text: 'ملغي',
        icon: Icons.cancel_outlined,
        color: Colors.red,
        bg: Colors.red.withOpacity(0.15),
      );
  }
}

class _StatusUI {
  final String text;
  final IconData icon;
  final Color color;
  final Color bg;

  _StatusUI({
    required this.text,
    required this.icon,
    required this.color,
    required this.bg,
  });
}
