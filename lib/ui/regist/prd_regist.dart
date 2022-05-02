import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:used_market/ui/constraints.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'prd_category.dart';

class RegistProduct extends StatefulWidget {
  const RegistProduct({Key? key}) : super(key: key);

  @override
  State<RegistProduct> createState() => _RegistProductState();
}

class _RegistProductState extends State<RegistProduct> {
  bool _freeOrNot = false;
  String productNm = '';
  String categoryCode = '';
  int price = 0;
  String prdStatusCode = '';
  List tag = [];
  String productDesc = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return KeyboardDismisser(
      gestures: const [GestureType.onTap],
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: BodyTextBold(
            string: '상품 등록',
            size: 20,
          ),
          actions: [
            TextButton(
                onPressed: null,
                child: BodyTextBold(
                  string: '등록',
                  size: 16,
                  color: Colors.black.withOpacity(0.4),
                ))
          ],
        ),
        body: Container(
          color: Colors.white,
          width: size.width,
          margin: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.06,
              ),
              // 이미지 업로드 등록 영역
              ImgUpload(),
              SizedBox(
                height: size.width * 0.06,
              ),
              // 상품명 영역
              TextField(
                onChanged: (val) {
                  setState(() {
                    productNm = val;
                  });
                },
                decoration: const InputDecoration(
                  hintText: '상품명',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: size.width * 0.04, bottom: size.width * 0.06),
                height: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(ProductCategoryList());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BodyTextBold(
                      string: '카테고리',
                      size: 16,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.black.withOpacity(0.3),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: size.width * 0.06, bottom: size.width * 0.04),
                height: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width / 2,
                    child: _freeOrNot
                        ? BodyTextBold(
                            string: '무료나눔',
                            size: 16,
                            color: Colors.black.withOpacity(0.7),
                          )
                        : TextField(
                            onChanged: (val) {
                              setState(() {
                                price = int.parse(val);
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              hintText: '판매가격',
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                  ),
                  Row(
                    children: [
                      BodyTextRegular(
                        string: '무료나눔',
                        size: 12,
                        color: _freeOrNot
                            ? Colors.black.withOpacity(0.7)
                            : Colors.black.withOpacity(0.4),
                      ),
                      Switch(
                          value: _freeOrNot,
                          onChanged: (val) {
                            setState(() {
                              _freeOrNot = val;
                              if (val) {
                                setState(() {
                                  _freeOrNot = val;
                                });
                              }
                            });
                          }),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: size.width * 0.04, bottom: size.width * 0.04),
                height: 1,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImgUpload extends StatefulWidget {
  const ImgUpload({Key? key}) : super(key: key);

  @override
  State<ImgUpload> createState() => _ImgUploadState();
}

class _ImgUploadState extends State<ImgUpload> {
  List imgList = [];
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //color: Colors.amber,
      height: size.width * 0.25,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                if (imgList.length == 10) {
                  alertDialog(context);
                  return;
                }
                _uploadImageToStorage(ImageSource.gallery);
              },
              child: Container(
                width: size.width * 0.25,
                height: size.width * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.05),
                    border: Border.all(
                        width: 1, color: Colors.black.withOpacity(0.1))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    BodyTextBold(
                      string: '${imgList.length} / 10',
                      size: 14,
                      color: Colors.black.withOpacity(0.6),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, idx) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.04),
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Colors.black.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: imgList[idx].runtimeType == String
                              ? Image.network(imgList[idx]).image
                              : Image.file(imgList[idx]).image,
                          fit: BoxFit.cover),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // img 삭제
                      setState(() {
                        imgList.removeAt(idx);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.05,
                      height: size.width * 0.05,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              );
            }, childCount: imgList.length),
          )
        ],
      ),
    );
  }

  void _uploadImageToStorage(ImageSource source) async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: source);

    if (image == null) return;

    var imageFile = File(image.path);
    setState(() {
      imgList.add(imageFile);
    });
    // late Reference reference;

    // if (source == ImageSource.gallery) {
    //   reference = _firebaseStorage
    //       .ref()
    //       .child('Product/${DateTime.now().millisecondsSinceEpoch}');
    // } else if (source == ImageSource.camera) {
    //   reference = _firebaseStorage
    //       .ref()
    //       .child('Product/${DateTime.now().millisecondsSinceEpoch}_direct_');
    // }

    // final uploadTask = reference.putFile(imageFile);

    // await uploadTask.whenComplete(() => null);

    // final downloadUrl = await reference.getDownloadURL();
    // setState(() {
    //   imgList.add(downloadUrl);
    // });
    // print('url : $downloadUrl');
  }

  void alertDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: BodyTextBold(
              string: '사진은 최대 10장 까지 등록 가능합니다',
              size: 16,
            ),
          );
        });
  }
}
