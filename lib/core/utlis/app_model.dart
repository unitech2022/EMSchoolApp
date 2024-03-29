

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../features/common/models/nav_model.dart';
import '../../features/common/models/user_response.dart';


Map<int, int> favFound = {};
UserResponse? currentUser ;
String token = "";


class AppModel {

  static String studentRole = "student";
  static String teacherRole = "teacher";
  static String token = "";
  static String lang = "";

  static String langAr = "ar";
  static String langEng = "en";
  static String privacy = "";
  static String deviceToken = "";
  static String apiKey = "AIzaSyBrAmfsbAiQ8MIPDAu4fmmdoa4acj9vGdg";
 static double currentLat = 0.0;
static double currentLng = 0.0;
}

List<NavModel> screensItemsTeacher=[
  NavModel(
      name: "الدروس".tr(),
      image:
      "assets/icons/subjects.svg",
      index: 0

  ),
  NavModel(
      name:"الطلاب".tr(),
      image:
      "assets/icons/students.svg",
      index: 1

  ),
  NavModel(
      name: "الرئيسية".tr(),
      image:
      "assets/icons/home.svg",
      index: 2

  ),
  NavModel(
      name: "الاشعارات".tr(),
      image:
      "assets/icons/notification.svg",
      index: 3

  ),
  NavModel(
      name:  "عن التطبيق".tr(),
      image:
      "assets/icons/about.svg",
      index: 4

  )
];

List<NavModel> screensItemsStudent=[
  NavModel(
      name: "المواد".tr(),
      image:
      "assets/icons/subjects.svg",
      index: 0

  ),
  NavModel(
      name:"الجداول".tr(),
      image:
      "assets/icons/calender.svg",
      index: 1

  ),
  NavModel(
      name: "الرئيسية".tr(),
      image:
      "assets/icons/home.svg",
      index: 2

  ),
  NavModel(
      name: "الاشعارات".tr(),
      image:
      "assets/icons/notification.svg",
      index: 3

  ),
  NavModel(
      name:  "عن التطبيق".tr(),
      image:
      "assets/icons/about.svg",
      index: 4

  )
];

String aboutUs = """
يعتبر هاتلي منصة فريدة بفكرتها في السوق السعودي بحيث توفر فرص البيع والشراء بالنطاق الجغرافي من حول العميل بدون دفع مبالغ اضافيه لشركات الطرف الثالث مما يزيد التكلفة على المستهلك  ( هاتلي ) تتيح للتجار والمحلات التجارية والأسر المنتجة النشر الإلكتروني لمنتجاتهم مع توصيلها للعملاء مجانا

""";
//(هاتلي ) مؤسسة رسمية مسجلة وفق الأنظمة في المملكه العربية السعودية ومقرها الرياض ومسجلة باسم مؤسسة هاتلي للتوصيل الطرود سجل تجاري رقم /  ١٠١٠٨٧٧٣٣٠

String servicesText = """هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، 
لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن 
تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى 
زيادة عدد الحروف التى يولدها """;

List<Color> listColors=[
  Colors.orangeAccent,
  Colors.blue,
   Colors.red,
   Colors.pinkAccent,
 Colors.lightGreen,
   Colors.deepOrange,
   Colors.cyanAccent,
  Colors.pink,
  Colors.grey,
  Colors.brown,
  Colors.deepOrangeAccent,
  Colors.deepPurple,
  Colors.green,
  Colors.lightBlueAccent,
  Colors.indigo

];








// يشار إلى منصة هاتلي على أنها الطرف الأول وهي منصة تتيح للطرف الثاني النشر الإلكتروني التجاري عليها وفق الأنظمة في المملكه العربية السعودية ومقرها الرياض ومسجلة باسم مؤسسة هاتلي للتوصيل الطرود  سجل تجاري رقم /  ١٠١٠٨٧٧٣٣٠
// ويشار لطرف الثاني على انه الناشر وهو التاجر .
// كما أن جميع النزاعات القانونية تقام داخل اروقة المحاكم السعودية فقط
// تجدر الإشارة أن استعمالك لمنصة هاتلي يعني الموافقة القانونية على جميع الشروط والأحكام الخاصة بالمنصة .
String privacy = """
<div>
 <h1> شروط الاستخدام </h1>
 <p>مقدمه : </p>
 <p> 
 
 </p>


 <h3>المادة الأولى :</h3>
<ol>شروط استعمال منصة ( هاتلي)


  <li>اختيار القسم الصحيح بمنتاجاتك ومراجعته جيداً</li>
  <li>رفع صور جيدة تعكس جودة منتجاتك</li>
  <li> عدم التلاعب بالاسعار مما يضر بالمستهلك والسوق</li>
  <li> عدم نشر المنتجات الممنوعة بنظام المملكه العربية السعودية
( راجع السلع الممنوعه بالأسفل )
</li>
  <li>عدم استعمال منصة هاتلي إذا كنت غير مؤهل شرعاً كالحجر آو الجنون إلى آخره</li>
  <li>٦-عدم تقمص دور منشأة أو جهة بدون علمها والترويج لمنتجاتها على هاتلي</li>
  <li>عدم انتهاك أنظمة حماية البيئة والحياة الفطرية</li>
  <li>عدم استعمال المنصة للعبث أو محاولات السبام أو الطلبات العشوائية أو محاولة الاغراق أو الاختراق إلى آخره.</li>
  <li> غير مسموح قطعاً التواصل مع التجار أو الأشخاص بإسم منصة هاتلي مهما كان السبب و المبرر</li>
  <li> عدم التحايل على العملاء سواء بالأسعار أو المنتجات أو أي طريقة كانت</li>
</ol>



 <h3> البند الثاني</h3>
<ol>السلع الممنوعة في منصة هاتلي


  <li>يمنع الترويج للممنوعات والكحول نهائيا</li>
  <li>منع الترويج لجميع الأجهزة الممنوعة مثل . أجهزة التنصت والتشويش و الليزر وغيرها</li>
<li>يمنع بيع الماركات المقلدة بجميع أنواعها وأشكالها</li>
<li>يمنع بيع وترويج أي مواد مقرصنة وتنتهك الحقوق الفكرية والأدبية وحقوق النسخ</li>
<li>منع الترويج للحيوانات المهددة بالانقراض أو مخالفة نظام الحياة الفطرية
</li>
<li>يمنع الترويج للأسلحة والذخائر وما يدخل في تركيبتها وتصنيعها</li>
<li>يمنع الترويج للأجهزة أو السلع المسروقة</li>
<li>يمنع منعاً باتاً الترويج للأجهزة الحكومية أو الأوسمة والأنواط  أو أي ممتلكات حكومية</li>
<li>منع أي سلعة ممنوعة حسب النظام  في المملكة العربية السعودية</li>

</ol>

 <h3> البند الثالث :</h3>
<ol>
أخلاقيات البيع ( خاصة بالبائع )

  <li>عدم التطفيف في الكيل بالنقص من الوزن مهما كان قليلا</li>
  <li>التعاون مع العميل والصبر عليه والأخذ بالمثل القائل( العميل على حق وأن كان مخطئاً )</li>
<li>أجعل لك سياسية مرنة بالإرجاع والتعاون وأكسب العملاء بحسن تعاونك</li>
<li>لا تتذمر من طلبات العملاء فهذا باب رزق يجب عليك الحمد عليه</li>
<li>اختيار الاسعار المناسبة للبيع وجذب العملاء بها وتذكر أن الكسب السريع لايدوم</li>
<li>إذا كنت تبيع الأكل يجب عليك الاهتمام بالأكل وجودة المواد وتذكر أنه يأكل منه الأطفال والمرضى وكبار السن</li>
<li>إذا كنت تعرض السلع المستعملة يجب عليك شرعا وقانوناً أن تبين مدة أستعمالها ومدى نظافتها وأي ملاحظة على السلعة أن وجدت</li>
<li>عدم زيادة بالسعر لأجل التعويض قيمة التوصيل لأن التوصيل من مهامك ومجاناً مقابل بيع وترويج منتجاتك على نطاق واسع من حولك </li>

</ol>

<hr>
<ol>
أخلاقيات الشراء ( خاصة بالمشتري )


  <li>الشراء والتسوق متعة فلا تعكر مزاجك بأشياء صغيرة مثل تأخير الطلب البسيط أو التغليف إذا كان منتجك بخير</li>
<li>استشعر أن التاجر إنسان ويقع منه الخطأ والنسيان مهما كان حريص يجب تفهم ذلك</li>
<li>تأكد من توفر المال معك قبل اتمام الطلب سواء كاش أو بحسابك البنكي</li>
<li>تقييمك مهم للتاجر يجب مراعاة هذا الأمر بجدية وتذكر أنك محاسب على تقييمك أمام الله</li>
<li>-البيع والشراء من الأمور الجدية بالحياة يجب الابتعاد عن الطلبات الغير جادة التي تضيع وقت وجهد التاجر في تجهيز طلبات وهمية</li>
<li>تذكر أن التاجر يعمل لكسب رزقه وهو موجود على المنصة لخدمتك حاول قدر المستطاع أن تكون له عونا وسندا لتطوير نفسه والكسب الحلال من خلال تكرار الطلب منه وقت حاجتك</li>
</ol>

</div>
 """;

String quiz = """
<div>
 <h1> الأسئلة الشائعة : </h1>
 <h3>
 من الذي يحق له التسجيل بمنصة هاتلي ؟
 </h3>
 <p>
 التسجيل متاح للجميع بكل الفئات سواءً أفراد أو مؤسسات وكذلك مقيم أو مواطن
 </p>

  <h3>
  من الذي يحق له البيع على هاتلي ؟
 </h3>
 <p>
 الجميع مرحب به سواء أفراد أو مؤسسات لبيع منتجاته على منصة هاتلي
 </p>





  <h3>
  كيف يتم تفعيل الحساب ؟
 </h3>
 <p>
 حساب المشترين يتم تفعيلها تلقائيا برقم الجوال الصحيح والدخول للحساب والشراء بكل سهولة
حساب المؤسسات يتم مراجعة الأوراق من قبل الموظف بشكل روتيني ويتم التفعيل بالعادة بغضون ساعة إلى ٢٤ ساعة بخلاف يوم الجمعة
 </p>


 <h3>
 حسابي لم يتم تفعيله ماذا أفعل ؟
 </h3>
 <p>
 إذا كان حسابك مشتري يتم بالعادة التفعيل بدون تدخل للمنصة عليك التأكد من رقم الجوال المدخل حتى تتمكن من ادخال الرمز المرسل لك في حال لم يصل الرمز تواصل مع خدمة العملاء ( وآتساب ) على الرقم التالي : 0557755462
أما إذا كان الحساب للبائع تأكد من أدخال جميع الأوراق كاملة وواضحة القراءة مع إدراج رقم جوال صحيح في حال لم يتم التفعيل  بعد مضي ٢٤ ساعة يمكنك التواصل مع خدمة العملاء ( وآتساب ) على الرقم التالي: 0557755462
 </p>


  <h3>
  كيف يتم الشراء والدفع ؟
 </h3>
 <p>
 يستطيع كل شخص شراء أي منتج يحتاجه ويقوم التاجر بتوصيل الطلب لباب المنزل
برسوم ثابتة ٢ ريال فقط مهما كان حجم الطلب أو سعره
كما انه متاح الدفع الإلكتروني والدفع الكاش عند الاستلام بدون رسوم إضافية
 </p>


  <h3>
  لماذا قيمة التوصيل منخفضة مقارنة بالتطبيقات الأخرى؟
 </h3>
 <p>
 لاننا اتفقنا مع صاحب المنتج نفسه ان يقوم بالتوصيل وليس شركات طرف ثالث تأخذ مبالغ كبيرة على خدمة التوصيل وتأخذ نسب من قيمة المنتجات أيضاً وهذا مايميز منصة هاتلي عن باقي المنصات  الأخرى
 </p>

   <h3>
   كم نسبة منصة هاتلي من قيمة المبيعات ؟
 </h3>
 <p>
 لايوجد نسبة ( مجاناً )
 </p>


   <h3>
   كم سعر التوصيل ؟
 </h3>
 <p>
 هناك رسم رمزي ثابت لكل شحنة توصيل ٢ ريال فقط مهما كانت قيمة الشحنة ووزنها وعددها
 </p>


</div>

""";
