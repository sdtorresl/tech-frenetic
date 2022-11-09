import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/dtos/paginator_dto.dart';

class PaginatorWidget extends StatelessWidget {
  const PaginatorWidget(
      {super.key, required this.paginator, required this.onPageChange});

  final PaginatorDto paginator;
  final Function(int index) onPageChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${paginator.currentPage + 1} / ${paginator.totalPages}"),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: paginator.hasPrevious() ? _previousPage : null,
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: paginator.hasNext() ? _nextPage : null,
          icon: const Icon(
            Icons.arrow_forward,
          ),
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  _previousPage() {
    paginator.currentPage--;
    onPageChange(paginator.currentPage);
  }

  _nextPage() {
    paginator.currentPage++;
    onPageChange(paginator.currentPage);
  }
}
