import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order3000_flutter/bloc/trade_summary/trade_summary_bloc.dart';
import 'package:order3000_flutter/bloc/trade_summary/trade_summary_event.dart';
import 'package:order3000_flutter/bloc/trade_summary/trade_summary_state.dart';
import 'package:order3000_flutter/repo/trade_summary_repository.dart';

class TradeSummaryWidget extends StatelessWidget {
  final TradeSummaryRepository repository;

  const TradeSummaryWidget({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TradeSummaryBloc(repository: repository)..add(LoadTradeSummary()),
      child: BlocBuilder<TradeSummaryBloc, TradeSummaryState>(
        builder: (context, state) {
          if (state is TradeSummaryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TradeSummaryLoaded) {
            final summaries = state.summaries;
            return ListView.builder(
              itemCount: summaries.length,
              itemBuilder: (context, index) {
                final item = summaries[index];
                return ListTile(
                  title: Text(item.symbol),
                  subtitle: Text(
                      'Price: ${item.price} | Volume: ${item.volume} | Change: ${item.change}'),
                );
              },
            );
          } else if (state is TradeSummaryError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
