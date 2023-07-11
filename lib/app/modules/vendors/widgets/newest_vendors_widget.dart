import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/vendor_model.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/single_vendor_widget.dart';
import 'package:techfrenetic/app/widgets/highlighted_title_widget.dart';

class NewestVendorsWidget extends StatelessWidget {
  final String title;
  const NewestVendorsWidget({Key? key, this.title = "NewestVendorsWidget"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<VendorModel> vendors = List<VendorModel>.generate(
      5,
      (index) => VendorModel(
          id: index,
          picture:
              "https://dev-techfrenetic.us.seedcloud.co/api/sites/default/files/2022-08/Apple_sanlitun-beijing-opening-exterior-07162020.jpg",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit amet luctus venenatis, lectus magna fringilla urna, porttitor rhoncus doliem. ",
          longDescription:
              "Enim parturient id diam integer nisl vivamus. Arcu ut bibendum dolor euismod lectus a molestie eu. Lacus eu neque, egestas ornare nisl, lacus. At nunc ut et risus volutpat volutpat ullamcorper at pharetra. Diam ac vitae mollis nullam curabitur congue parturient venenatis, in. At sed massa ultricies et vivamus nulla mattis eu vulputate. Amet, purus, ridiculus scelerisque sapien, dictum viverra. A id orci, eleifend porttitor tristique feugiat feugiat pellentesque eu. Consequat donec amet fermentum mattis velit. Est proin lacus, sed eget in fringilla id vestibulum. A duis auctor blandit ultricies ultrices augue. Sagittis, fringilla dictum luctus malesuada massa hendrerit morbi. Nulla eleifend massa mauris turpis. Sem enim posuere nunc elementum lacus. Est imperdiet in viverra augue. Lacinia aliquam vel pharetra, orci urna ultrices tristique at sed. Egestas semper elementum lacus, nisl. Vestibulum, lectus vel venenatis faucibus. Mauris, nibh id dolor lacus, faucibus posuere. Aliquet id porta dui eget purus sollicitudin. Praesent cursus mauris tellus proin volutpat. Malesuada massa consectetur lorem sit nulla nam. Duis et, enim, amet at nec. Bibendum sit faucibus aliquam ut vitae platea elit feugiat. ",
          category: "Category 1",
          title: "Empresa prueba $index",
          socialNetworks: ["facebook"],
          location: 'Canadá',
          webpage: 'http://google.com',
          email: "test@mail.com",
          phone: "+57 (301) 2301119",
          author: "Jhon Doe, Pepito Perez"),
    );

    return Container(
      color: context.theme.scaffoldBackgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      child: Column(
        children: [
          HighlightedTitleWidget(
              text: context.appLocalizations?.vendors_newest ?? ''),
          Column(
            children:
                vendors.map((e) => SingleVendorWidget(vendor: e)).toList(),
          )
        ],
      ),
    );
  }
}
