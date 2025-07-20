import 'package:flutter/material.dart';

class PartidoContainer extends StatelessWidget {
  String imageUrl;
  String partido;
  String name;
  int votaciones;
  VoidCallback addVotacion;
  VoidCallback lessVotacion;

  PartidoContainer({
    required this.imageUrl,
    required this.name,
    required this.partido,
    required this.votaciones,
    required this.addVotacion,
    required this.lessVotacion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Color(0xffB52D2F), Colors.white],
          // stops: [0.1, 0.8],
        ),
        boxShadow: [
          BoxShadow(blurRadius: 15, offset: Offset(3, 5), spreadRadius: 1),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: Image.network(imageUrl, height: 80),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Partido",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  partido,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "Representante: $name",
                  maxLines: 3,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: addVotacion,
                icon: Icon(Icons.arrow_upward),
              ),
              Text(
                votaciones.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              IconButton(
                onPressed: lessVotacion,
                icon: Icon(Icons.arrow_downward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
