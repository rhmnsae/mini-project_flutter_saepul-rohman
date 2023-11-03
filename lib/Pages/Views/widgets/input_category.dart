import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_list/Providers/add_todo_provider.dart';

class CategoryInput extends StatelessWidget {
  const CategoryInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Row(
            children: [
              // Prioritas tinggi (High)
              GestureDetector(
                onTap: () {
                  value.setPriority(1); // Set prioritas 1 (High) 
                },
                child: Stack(
                  children: [
                    // Lingkaran luar sebagai penanda prioritas
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: value.priority == 1
                          ? const Color(0xFFFAF0E6)
                          : const Color(0xFFC70D3A),
                      child: value.priority == 1
                          ? const Stack(
                              children: [
                                // Lingkaran kecil di dalam untuk penanda prioritas yang dipilih
                                CircleAvatar(
                                  radius: 11,
                                  backgroundColor: Color(0xFFC70D3A),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Prioritas sedang (Medium)
              GestureDetector(
                onTap: () {
                  value.setPriority(2); // Set prioritas menjadi 2 (Medium)
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: value.priority == 2
                          ? const Color(0xFFFAF0E6)
                          : const Color(0xFFED5107),
                      child: value.priority == 2
                          ? const Stack(
                              children: [
                                CircleAvatar(
                                  radius: 11,
                                  backgroundColor: Color(0xFFED5107),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Prioritas rendah (Low)
              GestureDetector(
                onTap: () {
                  value.setPriority(3); // Set prioritas menjadi 3 (Low)
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: value.priority == 3
                          ? const Color(0xFFFAF0E6)
                          : const Color(0xFF1E5128),
                      child: value.priority == 3
                          ? const Stack(
                              children: [
                                CircleAvatar(
                                  radius: 11,
                                  backgroundColor: Color(0xFF1E5128),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
