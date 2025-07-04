import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

void goToImageViewer<T>(
  int index,
  List<String> imgUrls,
) {
  Get.to(
    GalleryPhotoViewWrapper(
      galleryItems: imgUrls,
      backgroundDecoration: const BoxDecoration(
        color: Colors.black,
      ),
      initialIndex: index,
    ),
    transition: Transition.noTransition,
  );
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    required this.galleryItems,
    super.key,
    // this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  // final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<String> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          decoration: widget.backgroundDecoration,
          constraints: BoxConstraints.expand(
            height: ScreenUtil().screenHeight,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildItem,
                itemCount: widget.galleryItems.length,
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : (event.cumulativeBytesLoaded /
                              (event.expectedTotalBytes ?? 0)),
                    ),
                  ),
                ),
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
                scrollDirection: widget.scrollDirection,
              ),
              Positioned(
                right: 20,
                top: 100,
                child: InkWell(
                  onTap: Get.back,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String obj = widget.galleryItems[index];
    final bool isWebPhoto =
        obj.startsWith('https://') || obj.startsWith('http://');
    final bool isFilePhoto = obj.startsWith('file://');
    assert(isWebPhoto || isFilePhoto, '目前只支持网络和本地');

    return PhotoViewGalleryPageOptions.customChild(
      child: SizedBox(
        child: isWebPhoto
            ? CachedNetworkImage(
                imageUrl: obj,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
              )
            : Image.file(File(obj)),
      ),
      childSize: Size(ScreenUtil().screenWidth, ScreenUtil().screenHeight),
      initialScale: PhotoViewComputedScale.contained, //完全包在视图内（看到全图）
      minScale: 0.5,
      maxScale: 3.0,
      heroAttributes: PhotoViewHeroAttributes(tag: obj),
    );
  }
}
