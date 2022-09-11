import 'package:comindors/Api/ApiPayAdmin.dart';
import 'package:comindors/Listing/ListTrxAdmin.dart';
import 'package:flutter/material.dart';

import '../Listing/AccountItem.dart';
import '../Model/ModelPayment.dart';
import '../Ui/StyleText.dart';
import '../Ui/Warna.dart';

class RiwayatAdmin extends StatefulWidget {
  const RiwayatAdmin({Key? key}) : super(key: key);

  @override
  State<RiwayatAdmin> createState() => _RiwayatAdminState();
}

class _RiwayatAdminState extends State<RiwayatAdmin> {
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
    if (clickAktif.isEmpty) {
      setState(() {
        clickAktif.add("KOSONG");
      });
    }
    setState(() {
      _isFirstLoadRunning = true;
    });
    var res = await ApiPayAdmin()
        .riwayatList(outlet_id: "", status: clickAktif, page: _page);
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
        final res = await ApiPayAdmin().riwayatList(
          outlet_id: "",
          status: clickAktif,
          page: _page,
        );

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
                      itemBuilder: (_, index) => ListTrxAdmin(
                          context: context,
                          oddColour: index.floor().isEven
                              ? Colors.white
                              : Colors.grey.withOpacity(0.1),
                          modelPayment: _riwayaList[index])),
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
