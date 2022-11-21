import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/modules/premium/checkout_page.dart';
import 'package:techfrenetic/app/providers/stripe_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/widgets/progress_buttom.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key, this.onPremium}) : super(key: key);

  final void Function()? onPremium;

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Column(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.white,
              ),
            ),
            Flexible(
              flex: 7,
              child: Container(color: theme.backgroundColor),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              _header(theme),
              const SizedBox(
                height: 30,
              ),
              _card(theme)
            ],
          ),
        )
      ],
    );
  }

  Widget _card(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.primaryColorDark),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: theme.primaryColorDark.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(3, 3), // changes position of shadow
            )
          ]),
      child: Column(
        children: [
          Text(AppLocalizations.of(context)?.premium_banner_text ?? '',
              style: theme.textTheme.headline1),
          HighlightContainer(
            child: Text(
              AppLocalizations.of(context)?.premium_banner_tech ?? '',
              style: theme.textTheme.headline1!
                  .copyWith(color: theme.primaryColorDark),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(
              text: '\$10 ',
              style: theme.textTheme.headline3,
              children: [
                TextSpan(
                  text: "USD " +
                      (AppLocalizations.of(context)?.premium_monthly ?? ''),
                  style: theme.textTheme.bodyLarge,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ProgressButton(
            onPressed: _becamePremium,
            text: AppLocalizations.of(context)?.premium_start ?? '',
          ),
          const SizedBox(
            height: 25,
          ),
          _listItem(AppLocalizations.of(context)?.premium_list_1 ?? ''),
          const SizedBox(
            height: 15,
          ),
          _listItem(AppLocalizations.of(context)?.premium_list_2 ?? ''),
          const SizedBox(
            height: 15,
          ),
          _listItem(AppLocalizations.of(context)?.premium_list_3 ?? ''),
        ],
      ),
    );
  }

  Future<dynamic> _becamePremium() async {
    StripeProvider _stripeProvider = StripeProvider();
    String? sessionId = await _stripeProvider.createCheckout();
    if (sessionId != null) {
      final result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => CheckoutPage(sessionId: sessionId)));
      if (result) {
        if (widget.onPremium != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                AppLocalizations.of(context)?.premium_premium_success ?? ''),
          ));
          widget.onPremium!();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(AppLocalizations.of(context)?.premium_premium_failed ?? ''),
        ));
      }
    }
  }

  Widget _header(ThemeData theme) {
    return Column(
      children: [
        Row(
          children: [
            HighlightContainer(
              child: Text(
                AppLocalizations.of(context)?.premium_title_premium_span ?? '',
                style: theme.textTheme.headline1!
                    .copyWith(color: theme.colorScheme.primary),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              AppLocalizations.of(context)?.premium_title_premium ?? '',
              style: theme.textTheme.headline1!,
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            SizedBox(
              child: SvgPicture.asset(
                'assets/img/icons/ico_brand.svg',
                height: 65,
                width: 65,
                semanticsLabel: 'TF Logo',
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.tech_frenetic ?? '',
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.colorScheme.primary, fontSize: 30),
                ),
                Text(
                  AppLocalizations.of(context)?.premium_premium ?? '',
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.primaryColorDark, fontSize: 28),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _listItem(String text) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Theme.of(context).indicatorColor,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
