import 'package:flutter/material.dart';

class AdItem extends StatelessWidget {
  final String adImageUrl;
  final String adPrice;
  final String adTitle;
  final String adCity;

  const AdItem(
      {Key? key,
      required this.adImageUrl,
      required this.adCity,
      required this.adPrice,
      required this.adTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1)),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            height: double.infinity,
            width: MediaQuery.of(context).size.width * 0.3,
            child: adImageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      adImageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.image),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.57,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Rs $adPrice',
                      // 'Rs ${'15,000'?? "~~.~~"}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    adTitle,
                    // 'Macbook Air 2019' ?? "",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(child: Container()),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          // 'Islamabad' ?? "City Name"),
                          adCity),
                      // if (ad?.dateTime != null)
                      //   Text(
                      //     DateFormat('dd MMMM').format(
                      //       (ad?.dateTime as DateTime),
                      //     ),
                      //   ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

// void _navigateToAdDetialsScreen(BuildContext context, String adId) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (_) => AdDetailsScreen(ad: ad),
//     ),
//   );
// }
}
