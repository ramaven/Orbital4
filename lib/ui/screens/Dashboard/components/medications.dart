import 'package:flutter/material.dart';
import 'package:login_register_auth/globals.dart' as globals;
import 'dart:collection';

class MedicineDashboard extends StatefulWidget {
  const MedicineDashboard({Key key}) : super(key: key);

  @override
  _MedicineDashboardState createState() => _MedicineDashboardState();
}

class _MedicineDashboardState extends State<MedicineDashboard> {
  String medications;
  List<Map<String, dynamic>> painLogs;

  @override
  void initState() {
    setState(() {
      painLogs = globals.Userprofile.painLogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //refresh pain log data from firestore
    globals.Userprofile.get().then((response) {
      setState(() {
        painLogs = globals.Userprofile.painLogs;
      });
    });

    return Column(children: [
      // Text("Medications",
      //     textAlign: TextAlign.left,
      //     style: TextStyle(fontWeight: FontWeight.bold)),
      // SizedBox(height: 3),
      Container(
        height: size.height * 0.254,
        width: size.width * 0.39,
        padding: const EdgeInsets.all(10),
        // color: Colors.black,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          //color: Colors.black,
          //color:
          color: Colors.white,
          //Color(0xFFA8E4EC),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),

        child:
            Column(children: stringListToTextList(getTopMedications(painLogs))),
      ),
    ]);
  }

  List<Widget> stringListToTextList(List<String> ls) {
    List<Widget> texts = [
      // Text("Most Frequent",
      //     style: TextStyle(
      //         color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
      Text("Frequent Medications",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(
        height: 20,
      ),
    ];

    for (String word in ls) {
      texts.add(Text(word,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold
              //Colors.blue[100],
              )));
      texts.add(SizedBox(
        height: 4,
      ));
    }

    return texts;
  }

  List<String> getTopMedications(List<Map<String, dynamic>> painLogsFirebase) {
    // Create HashMap Key:symptom, Value:counter
    HashMap map = new HashMap<String, int>();
    // Initialise all counters to 0
    for (int i = 0; i < medicineList.length; i++) {
      // String curPart = symptomsList[i];
      map[medicineList[i]] = 0;
      //map[curPart] = 0;
    }

    // Update counter for all pain logs using occurrences of symptoms
    for (int i = 0; i < painLogsFirebase.length; i++) {
      Map<String, dynamic> curLog = painLogsFirebase[i];

      // Retrieve body part from firestore
      String currMedicine = curLog['medications'];
      print(currMedicine);

      int newCounter = 0;
      newCounter = map[currMedicine] + 1;
      // Update
      map[currMedicine] = newCounter;

      // print(currMedicine);

    }

    // Count total number of occurences (add all values)
    var counters = map.values;
    int counterSum = 0;
    //var counterSum = counters.reduce((sum, element) => sum + element);
    for (int k = 0; k < counters.length; k++) {
      counterSum += counters.elementAt(k);
    }

    int calculatePercentage(int currBodyPart, int totalBodyPart) {
      return ((currBodyPart) * 100 / (totalBodyPart)).round();
    }

    // Replaces int values (num of occurences) with percentages
    for (int i = 0; i < medicineList.length; i++) {
      // Num of occurences of curr body part
      int currCounter = map[medicineList[i]];
      // Update with percentage
      map[medicineList[i]] = calculatePercentage(currCounter, counterSum);
    }

    // Method to Sort map based on values/percentages
    LinkedHashMap sortListMap(HashMap map) {
      List mapKeys = map.keys.toList(growable: false);
      mapKeys.sort((k1, k2) => map[k2] - map[k1]);
      LinkedHashMap resMap = new LinkedHashMap();
      mapKeys.forEach((k1) {
        resMap[k1] = map[k1];
      });
      return resMap;
    }

    LinkedHashMap sortedMap = sortListMap(map);

    List<String> topMedicines = [];

    //while (topSymptoms.length <= 5 ) {
    sortedMap.forEach((sym, frequency) => {
          if (topMedicines.length < 5 &&
              frequency != 0 &&
              sym.compareTo("NIL") != 0)
            {topMedicines.add(sym)}
        });

    return topMedicines;
  }
}

List<String> medicineList = [
  "NIL",
  "Others",
  "Analgesics",
  "Paracetamol",
  "Ibuprofen",
  "Co-codamol (paracetamol and codeine mix)",
  "Codeine",
  "Tramadol",
  "Morphine",
  "Diclofenac",
  "Aspirin",
  "Naproxen",
  "Dihydrocodeine",
  "Oxycodone",
  "Nefopam",
  "Gabapentin",
  "Fentanyl",
  "Ketamine",
  "Antiarrhythmics",
  "Bisoprolol",
  "Atenolol",
  "Digoxin",
  "Amiodarone",
  "Adenosine",
  "Diltiazem",
  "Antibiotics",
  "Amoxicillin",
  "Flucloxacillin",
  "Meropenem",
  "Vancomycin",
  "Gentamycin",
  "Clarithromycin",
  "Co-amoxiclav",
  "Doxycycline",
  "Ceftazidime",
  "Piperacillin / Tazobactam (tazocin)",
  "Ciprofloxacin",
  "Levofloxacin",
  "Cephalexin",
  "Cefuroxime",
  "Clindamycin",
  "Trimethoprim",
  "Nitrofurantoin",
  "Anticoagulants",
  "Warfarin",
  "Rivaroxaban",
  "Apixaban",
  "Enoxaparin",
  "Funderparinex",
  "Heparin",
  "Anticonvulsants",
  "Sodium valproate (Epilim)",
  "Phenytoin",
  "Levetiracetam (Keppra)",
  "Gabapentin",
  "Clonazepam",
  "Diazapam",
  "Lorazepam",
  "Carbamazepine",
  "Antidepressants",
  "Citalopram",
  "Fluoxetine",
  "Amitriptyline",
  "Sertraline",
  "Venlafaxine",
  "Mirtazapine",
  "Trazodone",
  "Antiemetics",
  "Cyclizine",
  "Ondansetron",
  "Metoclopramide",
  "Prochlorperazine",
  "Levomepromazine",
  "Antihypertensives",
  "Ramipril",
  "Doxazosin",
  "Candesartan",
  "Losartan",
  "Lisinopril",
  "Atenolol",
  "Bisoprolol",
  "Amlodipine",
  "Diltiazem",
  "Nifedipine",
  "Antihyperglycemics",
  "Metformin",
  "Insulin",
  "Gliclazide",
  "Bronchodilators",
  "Salbutamol",
  "Ipratropium",
  "Tiotropium",
  "Theophylline",
  "Diuretics",
  "Furosemide",
  "Bumetanide",
  "Spironolactone",
  "Bendroflumethiazide",
  "Indapamide",
  "Amiloride",
  "Intravenous Fluids",
  "Normal Saline",
  "Plasmalyte",
  "Hartmann’s solution",
  "Geloplasma / Plasmalyte",
  "Glucose",
  "Sedatives",
  "Zopiclone",
  "Haloperidol",
  "Lorazepam",
  "Midazolam",
  "Diazepam",
  "Chlordiazepoxide",
  "Temazepam",
  "Phenobarbitol",
  "Statins",
  "Simvastatin",
  "Atorvastatin",
  "Pravastatin",
  "Supplements",
  "Levothyroxine",
  "Adcal / Calcichew",
  "Ferrous Fumarate",
  "Ferrous Sulphate",
  "Multivitamins",
  "Thiamine",
  "Cholecalciferol",
  "Quinine",
  "Folic Acid",
  "Sandoz-K",
  "Sandoz-Phosphate",
  "Slow sodium",
  "Alendronic Acid",
  "Laxatives",
  "Lactulose",
  "Senna",
  "Movicol",
  "Sodium Docusate",
  "Bisacodyl",
  "Phosphate Enema",
  "Microlax Enema",
  "Glycerine Suppositories",
  "Proton Pump Inhibitors",
  "Omeprazole",
  "Lansoprazole",
  "Esomeprazole",
  "Ranitidine (H2-receptor-blocker)",
  "Peptac",
];
