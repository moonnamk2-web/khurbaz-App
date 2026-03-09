import 'package:flutter/material.dart';

import '../../utils/resources/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kScaffoldBackground,
        appBar: AppBar(
          title: const Text(
            "سياسة الخصوصية",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _SectionTitle("1. المعلومات التي نجمعها"),
                _SectionText(
                  "نقوم بجمع المعلومات التي تقدمها عند إنشاء الحساب أو إتمام الطلب، "
                  "مثل الاسم، رقم الهاتف، عنوان التوصيل، والبريد الإلكتروني.",
                ),

                _SectionTitle("2. كيفية استخدام المعلومات"),
                _SectionText(
                  "نستخدم معلوماتك لتقديم خدماتنا، معالجة الطلبات، "
                  "تحسين تجربة المستخدم، والتواصل معك بخصوص الطلبات أو العروض.",
                ),

                _SectionTitle("3. حماية البيانات"),
                _SectionText(
                  "نلتزم بحماية بياناتك باستخدام تقنيات أمان حديثة، "
                  "ولا نقوم بمشاركة معلوماتك مع أي طرف ثالث إلا عند الضرورة "
                  "لتنفيذ الخدمة أو وفقًا للأنظمة المعمول بها.",
                ),

                _SectionTitle("4. المدفوعات"),
                _SectionText(
                  "تتم عمليات الدفع عبر مزود خدمة دفع آمن ومعتمد، "
                  "ولا نقوم بتخزين بيانات بطاقتك البنكية على خوادمنا.",
                ),

                _SectionTitle("5. ملفات تعريف الارتباط (Cookies)"),
                _SectionText(
                  "قد نستخدم تقنيات مشابهة لملفات تعريف الارتباط "
                  "لتحسين أداء التطبيق وتجربة المستخدم.",
                ),

                _SectionTitle("6. حقوق المستخدم"),
                _SectionText(
                  "يمكنك طلب تعديل أو حذف بياناتك من خلال إعدادات الحساب "
                  "أو التواصل مع فريق الدعم.",
                ),

                _SectionTitle("7. التعديلات على السياسة"),
                _SectionText(
                  "قد نقوم بتحديث سياسة الخصوصية من وقت لآخر، "
                  "وسيتم نشر أي تغييرات داخل التطبيق.",
                ),

                SizedBox(height: 30),

                Center(
                  child: Text(
                    "آخر تحديث: 2026",
                    style: TextStyle(color: kTitleGreyColor, fontSize: 13),
                  ),
                ),

                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ===================== WIDGETS =====================

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'DINNextLT',

          fontSize: 17,
          fontWeight: FontWeight.w800,
          color: kMainColor,
        ),
      ),
    );
  }
}

class _SectionText extends StatelessWidget {
  final String text;

  const _SectionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'DINNextLT',
        fontSize: 14,
        height: 1.8,
        color: kTitleBodyColor,
      ),
    );
  }
}
