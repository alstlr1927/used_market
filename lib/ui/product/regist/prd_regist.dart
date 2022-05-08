import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:used_market/ui/constraints.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:used_market/ui/home/main_screen.dart';
import 'prd_category.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegistProduct extends StatefulWidget {
  const RegistProduct({Key? key}) : super(key: key);

  @override
  State<RegistProduct> createState() => _RegistProductState();
}

class _RegistProductState extends State<RegistProduct> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool loadingFlag = false;
  bool registReadyFlag = false;
  bool _freeOrNot = false;

  List imgList = [];
  List<String> imgUrlList = [];

  String productNm = '';
  String categoryName = '';
  int price = 0;
  String prdStatusCode = '';
  List tag = [];
  String productDesc = '';

  bool _registValidation() {
    if (imgList.isEmpty) {
      return false;
    }
    if (productNm.isEmpty) {
      return false;
    }
    if (categoryName.isEmpty) {
      return false;
    }
    if (_freeOrNot == false && price == 0) {
      return false;
    }
    // 연관태그
    if (productDesc.isEmpty) {
      return false;
    }
    return true;
  }

  void _modifyImgList(images) {
    setState(() {
      imgList = [...images];
    });
    _registValidation();
  }

  _uploadStorage() async {
    for (var item in imgList) {
      late Reference reference;
      reference = _firebaseStorage.ref().child(
          'product/ZgoVsDFUYVcv2IdZQcRWKvnr9122/${DateTime.now().millisecondsSinceEpoch}');
      var uploadTask = reference.putFile(item);
      await uploadTask.whenComplete(() => null);
      var downloadUrl = await reference.getDownloadURL();
      imgUrlList.add(downloadUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return KeyboardDismisser(
      gestures: const [GestureType.onTap],
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          elevation: 1,
          centerTitle: true,
          title: BodyTextBold(
            string: '상품 올리기',
            size: 20,
          ),
          leading: GestureDetector(
            onTap: () {
              Get.off(UsedMarketHome());
            },
            child: const Icon(Icons.close),
          ),
          actions: [
            TextButton(
                onPressed: registReadyFlag
                    ? () async {
                        setState(() {
                          loadingFlag = true;
                        });
                        await _uploadStorage();
                        print('list : ${imgUrlList}');
                        Map<String, dynamic> data = {
                          'images': imgUrlList,
                          'name': productNm,
                          'category': categoryName,
                          'price': price,
                          'tag': [],
                          'desc': productDesc,
                          'regdate': Timestamp.now(),
                          'revisiondate': Timestamp.now(),
                          'selleruid': 'ZgoVsDFUYVcv2IdZQcRWKvnr9122'
                        };
                        _firebaseFirestore
                            .collection('products')
                            .doc()
                            .set(data)
                            .then((val) {
                          setState(() {
                            loadingFlag = false;
                          });
                          Get.back();
                        });
                      }
                    : null,
                child: BodyTextBold(
                  string: '등록',
                  size: 16,
                  color: registReadyFlag
                      ? Colors.black
                      : Colors.black.withOpacity(0.4),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: size.width,
            margin: const EdgeInsets.only(right: 16, left: 16),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.06,
                    ),
                    // 이미지 업로드 등록 영역
                    ImgUpload(modifyImgList: _modifyImgList),
                    SizedBox(
                      height: size.width * 0.06,
                    ),
                    // 상품명 영역
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          productNm = val;
                          registReadyFlag = _registValidation();
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
                      onTap: () async {
                        String? result = await Get.to(ProductCategoryList());
                        if (result != null) {
                          setState(() {
                            categoryName = result;
                            registReadyFlag = _registValidation();
                          });
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BodyTextBold(
                              string:
                                  categoryName.isEmpty ? '카테고리' : categoryName,
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
                        SizedBox(
                          width: size.width / 2,
                          child: _freeOrNot
                              ? BodyTextBold(
                                  string: '무료나눔',
                                  size: 16,
                                  color: Colors.black.withOpacity(0.7),
                                )
                              : TextField(
                                  onChanged: (val) {
                                    String value = '';
                                    if (val == '') {
                                      value = '0';
                                    } else {
                                      value = val;
                                    }
                                    setState(() {
                                      price = int.parse(value);
                                      registReadyFlag = _registValidation();
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
                                    price = 0;
                                    registReadyFlag = _registValidation();
                                  });
                                }),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: size.width * 0.04, bottom: size.width * 0.06),
                      height: 1,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    // 연관태그
                    GestureDetector(
                      onTap: () {
                        // 모달로 할지 페이지로 할지 정하고 ㄱ
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BodyTextBold(
                              string: '연관태그',
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
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: size.width * 0.06, bottom: size.width * 0.04),
                      height: 1,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    // 상품설명
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          productDesc = val;
                          registReadyFlag = _registValidation();
                        });
                      },
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: '상품 설명을 상세히 작성해주세요 :)',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: loadingFlag
                      ? Container(
                          color: Colors.transparent,
                          width: size.width,
                          height: size.height,
                          child: Center(
                            child: SpinKitFadingCube(color: Colors.pink[200]),
                          ),
                        )
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImgUpload extends StatefulWidget {
  ImgUpload({Key? key, required this.modifyImgList}) : super(key: key);
  var modifyImgList;
  @override
  State<ImgUpload> createState() => _ImgUploadState();
}

class _ImgUploadState extends State<ImgUpload> {
  List imgList = [];
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
                      widget.modifyImgList(imgList);
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
    widget.modifyImgList(imgList);
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
