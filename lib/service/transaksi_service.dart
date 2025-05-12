// ignore_for_file: unused_local_variable, avoid_print

import 'package:app_simple/core/models/cart_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransaksiService {
  Future savetransaksi(
      total, kembalian, bayar, List<CartItems> listcart) async {
    // total, kembalian, bayar, tanggal transaksi
    // transaksi detail: id_transaksi, id_menu, jumlah_menu

    try {
      CollectionReference transaksiCollection =
          FirebaseFirestore.instance.collection('transaksi');
      DocumentReference transaksiRef = await transaksiCollection.add({
        'total': total,
        'kembalian': kembalian,
        'bayar': bayar,
        'tanggal_transaksi': DateTime.now(),
      });

      print("transaksi berhasil di simpan");
      CollectionReference transaksiDetailCollection =
          FirebaseFirestore.instance.collection('transaksiDetail');

      for (var item in listcart) {
        await transaksiDetailCollection.add({
          'id_transaksi': transaksiRef.id,
          'id_menu': item.menuItems.id,
          'jumlah_menu': item.quantity,
        });
      }
      print("transaksi detail berhasil di simpan");
    } catch (e) {
      print("transaksi gagal di simpan $e");
    }
  }
}
