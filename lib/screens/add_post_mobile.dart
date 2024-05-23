import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPostMobile extends StatefulWidget {
  const AddPostMobile({super.key});

  @override
  State<AddPostMobile> createState() => _AddPostMobileState();
}

class _AddPostMobileState extends State<AddPostMobile> {
  final List<Widget> mediaData = [];
  final List<File> paths = [];
  File? _file;
  int currentPage = 0;
  int? lastPage;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    final PermissionState permissionState =
        await PhotoManager.requestPermissionExtend();
    if (permissionState.isAuth) {
      _fetchMedia();
    } else {
      await PhotoManager.requestPermissionExtend();
      if (mounted) {
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('This app needs photo access to upload images.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await PhotoManager.openSetting();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchMedia() async {
    lastPage = currentPage;
    final List<AssetPathEntity> albums =
        await PhotoManager.getAssetPathList(type: RequestType.image);
    if (albums.isNotEmpty) {
      final List<AssetEntity> media =
          await albums[0].getAssetListPaged(page: currentPage, size: 60);
      for (var asset in media) {
        if (asset.type == AssetType.image) {
          final file = await asset.file;
          if (file != null) {
            paths.add(file);
          }
        }
      }

      final List<Widget> temp = [];
      for (var asset in media) {
        temp.add(
          FutureBuilder<Uint8List?>(
            future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(snapshot.data!),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return Container(
                  color: Colors.grey,
                );
              }
            },
          ),
        );
      }

      setState(() {
        mediaData.addAll(temp);
        if (paths.isNotEmpty) {
          _file = paths[0];
        }
        currentPage++;
      });
    }
  }

  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        title: const Text(
          'New Post',
          style: TextStyle(color: primaryColor),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  // Handle next action
                  print("Next pressed with file: $_file");
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 380,
              child: GridView.builder(
                itemCount: mediaData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  return mediaData[index];
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              color: mobileBackgroundColor,
              child: const Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Recent',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: mediaData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        value = index;
                        _file = paths[index];
                      });
                    },
                    child: mediaData[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
