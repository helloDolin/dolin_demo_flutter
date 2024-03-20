import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(35 + 8 * 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
          Expanded(
            child: Container(
              height: 35,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: const TextField(
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF3F6F9),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(35 / 2)),
                  ),
                  hintText: '搜索文章',
                  hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          const Wrap(
            spacing: 3,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(Icons.assignment_turned_in_outlined),
              Text(
                '已签',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
