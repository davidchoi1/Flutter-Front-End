import 'package:flutter/material.dart';
import '../components/button.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  //slidermaxdivisions
  final double MAX_AMOUNT = 5;
  final int MAX_DIVISIONS = 5;
  //emptyFunction() does nothing for now
  void Function() get emptyFunction => () {};
  // slider values of all 20 questions
  List<double> currentSliderValues = List<double>.filled(20, 0);
  // strings for slider sliderLabels
  List<String> sliderLabels = [
    'Choose One',
    'Never',
    'Rarely',
    'Sometimes',
    'Often',
    'All the time'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Survey Page"),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                  "Please answer the following questions with how much they've applied to you within the last 4 week.",
                  style: TextStyle(
                    color: Color.fromARGB(255, 79, 77, 77),
                    fontSize: 16,
                  )),
            ),
            const SizedBox(height: 10),

            // Question 1
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have difficulty deriving pleasure or meaning from activities which you've historically considered pleasurable or productive.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[0],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[0].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[0] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 2
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have had moments where you feel unaccomplished and ashamed.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[1],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[1].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[1] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 3
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("You have been unable to get quality sleep.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[2],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[2].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[2] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 4
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have been isolated from your friends and family.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[3],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[3].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[3] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 5
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have been struggling with getting started on responsibilities and/or fail to complete them.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[4],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[4].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[4] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 6 (1 Irritability Q)
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have been short-tempered or quick to experience spite.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[5],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[5].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[5] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 7
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have been having trouble keeping up with self-hygiene.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[6],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[6].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[6] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 8 (2 Social Question)
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You dissociated or felt disconnected from the world around you.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[7],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[7].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[7] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 9 (1 Irritability Question)
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have been easily irritated and/or have had sudden outbursts of negative emotions.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[8],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[8].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[8] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 10
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have had difficulty in getting enough sleep, or the reverse - sleeping too much.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[9],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[9].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[9] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 11 (2 Interest Deviation Question)
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have felt unmotivated to move forward in life.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[10],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[10].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[10] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 12
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have been getting instrusive or obsessive thoughts that something will go wrong.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[11],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[11].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[11] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 13 (3 Social question)
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have had more difficulty maintaining and concentrating on your daily obligations.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[12],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[12].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[12] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 14 (1 Addiction Question)
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have been abusing drugs and/or alcohol to seek comfort or distraction.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[13],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[13].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[13] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 15 (2 Suicide Question)
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have had thoughts that you or others would be better off if you were dead.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[14],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[14].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[14] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 16 (3 Focus Questions)
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have had an abnormally difficult time getting out of bed.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[15],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[15].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[15] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 17 (2 Suicide Questions)
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("You have had thoughts of self harm.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[16],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[16].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[16] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 18
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have thought negatively of yourself and/or others around you.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[17],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[17].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[17] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 19
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("You have been feeling depressed or hopeless.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[18],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[18].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[18] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),

            // Question 20 (1 Movement Q)
            Row(
              children: const [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "You have experienced being fidgety or restless, or the opposite - slow and sluggish.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentSliderValues[19],
              max: MAX_AMOUNT,
              divisions: MAX_DIVISIONS,
              label: sliderLabels[currentSliderValues[19].toInt()],
              inactiveColor: Colors.grey[200],
              activeColor: Colors.blueGrey,
              onChanged: (double value) {
                setState(() {
                  currentSliderValues[19] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.blueGrey,
            ),
            const SizedBox(height: 20),

            // continue button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyButton(onTap: emptyFunction, message: "Continue Next"),
            ),
          ],
        ))));
  }
}
