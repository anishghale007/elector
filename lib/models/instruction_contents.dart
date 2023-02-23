class InstructionContent {
  String? image;
  String? text;

  InstructionContent({this.image, this.text});
}

List<InstructionContent> contents = [
  InstructionContent(
      image: 'assets/images/instruction1.png',
      text: 'Please check your surroundings and'
          ' make sure that no one is watching your screen while you are voting. DO NOT ACCEPT BRIBE IN FAVOUR OF YOUR VOTE.'),
  InstructionContent(
      image: 'assets/images/instruction2.png',
      text: 'You will need to verify your vote with your'
          ' fingerprint and PIN. Impersonation is an offence.'),
  InstructionContent(
      image: 'assets/images/instruction3.png',
      text: 'Your voting intentions and decisions '
          'should be kept secret both before and after the election. '),
];
