// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order3000_flutter/models/language.dart';
import 'package:order3000_flutter/widgets/search_bar.dart';
import 'package:order3000_flutter/widgets/stocks/icon_detail_row.dart';
import 'package:order3000_flutter/widgets/stocks/stock_empty_widget.dart';
import 'package:order3000_flutter/widgets/stocks/stock_error_widget.dart';
import '../bloc/stock/stock_bloc.dart';
import '../bloc/stock/stock_event.dart';
import '../bloc/stock/stock_state.dart';
import '../repo/stock_repository.dart';
import '../bloc/localization_bloc.dart';
import '../generate/app_localizations.dart';
import '../constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StockBloc stockBloc;
  final _symbolController = TextEditingController();

  @override
  void initState() {
    super.initState();
    stockBloc = StockBloc(repository: StockRepository());
  }

  @override
  void dispose() {
    stockBloc.close();
    _symbolController.dispose();
    super.dispose();
  }

  void _fetchStock() {
    final symbol = _symbolController.text.trim();
    if (symbol.isNotEmpty) {
      stockBloc.add(FetchStock(symbol));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a stock symbol'),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }

  void _showStockDetailsModal(BuildContext context, StockLoaded state) {
    final stock = state.stock;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grayColor.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, -8),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.grayColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  if (stock.logoPath != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Image.network(
                        stock.logoPath!,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  Text(
                    stock.name ?? stock.symbol,
                    style: TextStyle(
                      color: AppColors.darkerblue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${stock.symbol} - ${stock.lastPrice} LKR',
                    style: const TextStyle(
                      color: AppColors.amberColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Divider(color: AppColors.lightBlue),
                  const SizedBox(height: 12),
                  _buildDetailRow('High Price Today', stock.wtdHiPrice),
                  _buildDetailRow('Low Price Today', stock.wtdLowPrice),
                  _buildDetailRow('Month High', stock.mtdHiPrice),
                  _buildDetailRow('Month Low', stock.mtdLowPrice),
                  _buildDetailRow('YTD High', stock.ytdHiPrice),
                  _buildDetailRow('YTD Low', stock.ytdLowPrice),
                  const SizedBox(height: 12),
                  _buildDetailRow('Today Volume', stock.tdyShareVolume),
                  _buildDetailRow('MTD Volume', stock.mtdShareVolume),
                  _buildDetailRow('YTD Volume', stock.ytdShareVolume),
                  const SizedBox(height: 12),
                  _buildDetailRow('Today Turnover', stock.tdyTurnover),
                  _buildDetailRow('MTD Turnover', stock.mtdTurnover),
                  _buildDetailRow('YTD Turnover', stock.ytdTurnover),
                  const SizedBox(height: 12),
                  _buildDetailRow('Beta Value', stock.triASIBetaValue),
                  _buildDetailRow('Issue Date', stock.issueDate),
                  _buildDetailRow('Quantity Issued', stock.quantityIssued),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkerblue,
                      foregroundColor: AppColors.whiteColor,
                      minimumSize: const Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    label: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: AppColors.grayColor)),
          Text(
            value != null ? value.toString() : '-',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizationBloc = context.read<LocalizationBloc>();
    final localizations = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: stockBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.home),
          centerTitle: true,
          backgroundColor: AppColors.darkerblue,
          foregroundColor: AppColors.whiteColor,
          elevation: 2,
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.translate),
              onSelected: (lang) {
                localizationBloc
                    .add(ChangeLanguage(lang, selectedLanguage: lang));
              },
              itemBuilder: (context) {
                return Language.values.map((lang) {
                  return PopupMenuItem(value: lang, child: Text(lang.text));
                }).toList();
              },
            ),
          ],
        ),
        body: Container(
          color: AppColors.lightBlue,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: StockSearchWidget(
                            controller: _symbolController,
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: _fetchStock, // keep your fetch function
                          icon: const Icon(Icons.search),
                          label: const Text('Fetch'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.amberColor,
                            foregroundColor: AppColors.blackColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<StockBloc, StockState>(
                    builder: (context, state) {
                      if (state is StockLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is StockLoaded) {
                        final stock = state.stock;
                        return SingleChildScrollView(
                          child: Card(
                            elevation: 8,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            color: AppColors.whiteColor,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header Section
                                  Row(
                                    children: [
                                      Icon(Icons.business,
                                          color: AppColors.darkerblue,
                                          size: 32),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          stock.name ?? stock.symbol,
                                          style: TextStyle(
                                            color: AppColors.darkerblue,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.confirmation_number,
                                          color: AppColors.amberColor,
                                          size: 20),
                                      const SizedBox(width: 6),
                                      Text(
                                        stock.symbol,
                                        style: TextStyle(
                                          color: AppColors.amberColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(Icons.attach_money,
                                          color: AppColors.greenColor,
                                          size: 20),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${stock.lastPrice} LKR',
                                        style: TextStyle(
                                          color: AppColors.greenColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Divider(color: AppColors.lightBlue),
                                  const SizedBox(height: 12),

                                  // Price Section
                                  Text('Price',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.darkerblue)),
                                  const SizedBox(height: 8),
                                  IconDetailRow(Icons.trending_up, 'High Today',
                                      stock.wtdHiPrice, AppColors.greenColor),
                                  IconDetailRow(
                                      Icons.trending_down,
                                      'Low Today',
                                      stock.wtdLowPrice,
                                      AppColors.redColor),
                                  IconDetailRow(
                                      Icons.calendar_today,
                                      'Month High',
                                      stock.mtdHiPrice,
                                      AppColors.greenColor),
                                  IconDetailRow(
                                      Icons.calendar_today,
                                      'Month Low',
                                      stock.mtdLowPrice,
                                      AppColors.redColor),
                                  IconDetailRow(Icons.timeline, 'YTD High',
                                      stock.ytdHiPrice, AppColors.greenColor),
                                  IconDetailRow(Icons.timeline, 'YTD Low',
                                      stock.ytdLowPrice, AppColors.redColor),

                                  const SizedBox(height: 16),
                                  Divider(color: AppColors.lightBlue),
                                  const SizedBox(height: 12),

                                  // Volume Section
                                  Text('Volume',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.darkerblue)),
                                  const SizedBox(height: 8),
                                  IconDetailRow(
                                      Icons.bar_chart,
                                      'Today',
                                      stock.tdyShareVolume,
                                      AppColors.darkerblue),
                                  IconDetailRow(
                                      Icons.bar_chart,
                                      'MTD',
                                      stock.mtdShareVolume,
                                      AppColors.darkerblue),
                                  IconDetailRow(
                                      Icons.bar_chart,
                                      'YTD',
                                      stock.ytdShareVolume,
                                      AppColors.darkerblue),

                                  const SizedBox(height: 16),
                                  Divider(color: AppColors.lightBlue),
                                  const SizedBox(height: 12),

                                  // Turnover Section
                                  Text('Turnover',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.darkerblue)),
                                  const SizedBox(height: 8),
                                  IconDetailRow(Icons.swap_horiz, 'Today',
                                      stock.tdyTurnover, AppColors.amberColor),
                                  IconDetailRow(Icons.swap_horiz, 'MTD',
                                      stock.mtdTurnover, AppColors.amberColor),
                                  IconDetailRow(Icons.swap_horiz, 'YTD',
                                      stock.ytdTurnover, AppColors.amberColor),

                                  const SizedBox(height: 16),
                                  Divider(color: AppColors.lightBlue),
                                  const SizedBox(height: 12),

                                  // Other Info Section
                                  Text('Other Info',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.darkerblue)),
                                  const SizedBox(height: 8),
                                  IconDetailRow(
                                      Icons.show_chart,
                                      'Beta Value',
                                      stock.triASIBetaValue,
                                      AppColors.grayColor),
                                  IconDetailRow(Icons.date_range, 'Issue Date',
                                      stock.issueDate, AppColors.grayColor),
                                  IconDetailRow(
                                      Icons.confirmation_number,
                                      'Quantity Issued',
                                      stock.quantityIssued,
                                      AppColors.grayColor),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (state is StockError) {
                        return StockErrorWidget(message: state.message);
                      }
                      return const StockEmptyWidget();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
