import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:votacionesappg12/widgets/partido_container.dart';

class HomePage extends StatelessWidget {
  CollectionReference candidateReference = FirebaseFirestore.instance
      .collection("candidates");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: candidateReference.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text("Errror: ${snapshot.error}");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final List<QueryDocumentSnapshot> docs =
                        snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PartidoContainer(
                          imageUrl: docs[index]["imageUrl"],
                          name: docs[index]["name"],
                          partido: docs[index]["partido"],
                          votaciones: docs[index]["votaciones"],
                          addVotacion: () {
                            int nVotaciones = docs[index]["votaciones"];
                            candidateReference.doc(docs[index].id).update({
                              "votaciones": nVotaciones + 1,
                            });
                            // docs[index].update({
                            //   "votaciones": docs[index]["votaciones"]++,
                            // });
                          },
                          lessVotacion: () {
                            int nVotaciones = docs[index]["votaciones"];
                            candidateReference.doc(docs[index].id).update({
                              "votaciones": nVotaciones - 1,
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
