import 'package:comindors/Api/ApiPay.dart';
import 'package:comindors/Model/ModelPayment.dart';
import 'package:comindors/Ui/StyleText.dart';
import 'package:flutter/material.dart';

import '../Listing/AccountItem.dart';
import '../Ui/Warna.dart';

class RiwayatPage extends StatefulWidget {
  String? outlet;
  RiwayatPage({Key? key, this.outlet}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  int _page = 1;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;
  List<String> filterSts = ["Menunggu", "Diterimah", "Ditolak", "Selesai"];
  List<ModelPayment> _riwayaList = [];
  List<String> clickAktif = ["Menunggu", "Diterimah", "Ditolak", "Selesai"];

  void _firstLoad() async {
    if (_page > 1) {
      _hasNextPage = true;
      _page = 1;
      _riwayaList.clear();
    }
    setState(() {
      _isFirstLoadRunning = true;
    });
    print(clickAktif.toString());
    var res = await ApiPayment().riwayatList(
        outlet_id: widget.outlet.toString(), status: clickAktif, page: _page);
    print("DATA $_page${modelPaymentToJson(res)}");
    setState(() {
      _riwayaList = res;
    });
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      try {
        final res = await ApiPayment().riwayatList(
          outlet_id: widget.outlet.toString(),
          status: clickAktif,
          page: _page,
        );
        print("DATA $_page ${modelPaymentToJson(res)}");

        if (res.isNotEmpty) {
          setState(() {
            _riwayaList.addAll(res);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print(err);
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
      print(_riwayaList.length);
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();

    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Transaksi"),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    decoration: BoxDecoration(
                      color: Warna.BiruPrimary.withOpacity(0.90),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 8.0),
                          child: Text(
                            "Pilih Status :",
                            style: StyleText.textBodyPutih16
                                .copyWith(fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: filterSts.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (clickAktif
                                            .contains(filterSts[int])) {
                                          clickAktif.remove(filterSts[int]);
                                        } else {
                                          clickAktif.add(filterSts[int]);
                                        }
                                      });
                                      _firstLoad();
                                    },
                                    child: Chip(
                                        backgroundColor:
                                            clickAktif.contains(filterSts[int])
                                                ? Colors.red
                                                : Colors.white,
                                        clipBehavior: Clip.antiAlias,
                                        label: Text(
                                          filterSts[int].toUpperCase(),
                                          style: StyleText.textSubBodyHitam14
                                              .apply(
                                            color: clickAktif
                                                    .contains(filterSts[int])
                                                ? Colors.white
                                                : Warna.BiruPrimary,
                                          ),
                                        )),
                                  ));
                            },
                          ),
                        )
                      ],
                    )),
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _riwayaList.length,
                    itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: accountItems(
                            context: context,
                            oddColour: index.floor().isEven
                                ? Colors.white
                                : Colors.white,
                            modelPayment: _riwayaList[index])),
                  ),
                ),
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
    );
  }
}
