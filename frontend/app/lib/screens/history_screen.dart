import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/auth_service.dart';

class HistoryScreen
    extends StatefulWidget {

  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() =>
      _HistoryScreenState();
}

class _HistoryScreenState
    extends State<HistoryScreen> {

  List<dynamic> history = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();

    fetchHistory();
  }

  Future<void> fetchHistory() async {

    try {

      final user =
          AuthService.currentUser();

      if (user == null) return;

      final result =
          await ApiService.fetchMealHistory(
        user.id,
      );

      setState(() {
        history = result;
      });

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    } finally {

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meal History",
        ),
      ),
      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : history.isEmpty
              ? const Center(
                  child: Text(
                    "No meal history found",
                  ),
                )
              : ListView.builder(
                  itemCount:
                      history.length,
                  itemBuilder:
                      (context, index) {

                    final item =
                        history[index];

                    return Card(
                      margin:
                          const EdgeInsets
                              .all(12),
                      child: Padding(
                        padding:
                            const EdgeInsets
                                .all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [

                            Text(
                              item[
                                  "created_at"],
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Text(
                              item[
                                      "meal_plan"]
                                  .toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}