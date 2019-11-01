import 'package:flutter/material.dart';
import 'package:my_share_pal/styleguide/colors.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/utils.dart';

import 'home_screen.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProfileScreenState();
  }
}

class ProfileScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: null,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        moveBack(context);
                      },
                      child: Image(
                        image: AssetImage("images/arrow.png"),
                        height: 16.0,
                      )),
                  Text(
                    "Policy",
                    style: title,
                  ),
                  InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return HomeScreen();
                        }));
                      },
                      child: Image(
                    image: AssetImage("images/cross.png"),
                    height: 24.0,
                  ))
                ],
              )),
          Expanded(
              child: Stack(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 32, left: 16, right: 16),
                  padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 16.0),
                  decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Text("Policy",
                            style: privacyTitle, textAlign: TextAlign.center),
                        margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
                      ),
                      Text(
                          "Introduction\n\nWe respect your privacy and are committed to protecting it through our compliance with this policy. This policy describes:\n\nThe types of information We may collect or that you may provide when you download, install, register with, access, or use the MySharePal Mobile App (the “App”).\nOur practices for collecting, using, maintaining, protecting, and disclosing that information.\nThis policy applies only to information We collect in the App and in email, text, and other electronic communications sent through or in connection with the App. This policy DOES NOT apply to information that We collect offline or on any other Company apps or websites, including websites you may access through the App. Our websites and apps may have their own privacy policies, which We encourage you to read before providing information on or through them.\n\nPlease read this policy carefully to understand our policies and practices regarding your information and how We will treat it. If you do not agree with our policies and practices, do not download, register with, or use the App. By downloading, registering with, or using the App, you agree to this privacy policy. This policy may change from time to time. Your continued use of the App after We revise this policy means you accept those changes, so please check the policy periodically for updates.\n\nChildren Under the Age of 13\n\nThe App is not intended for children under 13 years of age, and We do not knowingly collect personal information from children under 13. If We learn We have collected or received personal information from a child under 13 without verification of parental consent, We will delete that information. If you believe We might have any information from or about a child under 13, please contact us at the email address listed in the “Contact Information” section below.\n\nInformation We Collect and How We Collect It\n\nWe collect information from and about users of our App:\n\nDirectly from you when you provide it to us.\nAutomatically when you use the App.\nInformation You Provide to Us \n\nWhen you download, register with, access, or use the App, We may ask you to provide information by which you may be personally identified, such as name and telephone number (“personal information”).\n\nOther types of information you provide to us includes:\n\nInformation that you provide by filling in forms in the App. This includes information provided at the time of registering to use the App and requesting further services. We may also ask you for information when you report a problem with the App.\nRecords and copies of your correspondence (including email addresses and phone numbers), if you contact us.\nYour responses to surveys that We might ask you to complete for research purposes.\nAutomatic Information Collection and Automatic Information Collection Technologies\n\nWhen you access and use the App, We may automatically collect certain details of your access to and use of the App, including traffic data, logs, and other communication data and the resources that you access and use on or through the App. The technologies We use for automatic information collection may include cookies (or mobile cookies), which are small files placed on your smartphone. If you do not want us to collect this information do not download the App or delete it from your device.\n\nHow We Use Your Information\n\nWe use information that We collect about you or that you provide to us, including any personal information, to:\n\nProvide you with the App and its contents, and any other information, products or services that you request from us.\nFulfill any other purpose for which you provide it.\nCarry out our obligations and enforce our rights arising from any contracts entered into between you and us.\nNotify you when App updates are available, and of changes to any products or services We offer or provide though the App.\nThe usage information We collect helps us to improve our App and to deliver a better and more personalized experience by enabling us to:\n\nEstimate our audience size and usage patterns.\nStore information about your preferences, allowing us to customize our App according to your individual interests.\nSpeed up your searches.\nRecognize you when you use the App.\nDisclosure of Your Information\n\nWe may disclose aggregated information about our users, and information that does not identify any individual or device, without restriction.\n\nIn addition, We may disclose personal information that We collect or you provide:\n\nTo our subsidiaries and affiliates.\nTo contractors, service providers, and other third parties We use to support our business.\nTo a buyer or other successor in the event of a merger, divestiture, restructuring, reorganization, dissolution, or other sale, disposition or transfer of some or all of Company’s assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which personal information held by Company about our App users is among the assets transferred.\nTo fulfill the purpose for which you provide it.\nFor any other purpose disclosed by us when you provide the information.\nWith your consent.\nTo comply with any court order, law, or legal process, including to respond to any government or regulatory request.\nTo enforce our rights arising from any contracts entered into between you and us, including without limitation the App EULA.\nIf We believe disclosure is necessary or appropriate to protect the rights, property, or safety of Company, our customers or others.\nYour Choices About Our Collection, Use, and Disclosure of Your Information\n\nYou can set your browser to refuse all or some browser cookies, or to alert you when cookies are being sent. It may be possible to refuse to accept mobile cookies by activating the appropriate setting on your smartphone. If you disable or refuse cookies or block the use of other tracking technologies, some parts of the App may then be inaccessible or not function properly.\n\nData Security\n\nWe have implemented certain commercially reasonable measures intended to secure your personal information from accidental loss and from unauthorized access, use, alteration, and disclosure. The safety and security of your information also depends on you. Where We have given you (or where you have chosen) a password for access to certain parts of our App, you are responsible for keeping this password confidential. We ask you not to share your password with anyone. Unfortunately, the transmission of information via the internet and mobile platforms is not completely secure. Although We try to protect your personal information, We cannot and do not guarantee the security of your personal information transmitted through the App. Any transmission of personal information is at your own risk. We are not responsible for circumvention of any privacy settings or security measures We provide.\n\nChanges to Our Privacy Policy\n\nWe may update our privacy policy from time to time. If We make material changes to how We treat our users’ personal information, We will post the new privacy policy on this page.\n\nThe date the privacy policy was last revised is identified at the top of the page. You are responsible for periodically visiting this privacy policy to check for any changes.\n\nContact Information\n\nTo ask questions, comment about, or otherwise contact us about this privacy policy and our privacy practices, contact us at: hello@MySharePal.com.\n",
                          style: privacyText),
                      Container(
                        child: null,
                      )
                    ],
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(gradient: linearGradient),
                  ))
            ],
          ))
        ],
      )),
    );
  }
}
