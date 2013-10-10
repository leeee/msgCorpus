import de.bezier.data.sql.*;
import rita.*;

SQLite db;
ArrayList<Message> messages;
RiMarkov rm;
final int N_FACTOR = 2;
PFont font;

void setup() {
  size(800, 600);
  font = createFont("Arial", 16, true);

  messages = new ArrayList();
  db = new SQLite(this, "messages.db");  

  if (db.connect()) {      
    db.query( "SELECT message.is_from_me,message.text,handle.id FROM " 
      + "handle INNER JOIN message ON message.handle_id = handle.ROWID "
      + "ORDER BY handle.id");

    while (db.next ()) {
      Message msg = new Message();
      db.setFromRow(msg);
      messages.add(msg);
    }
  }

  // Set up markov.
  rm = new RiMarkov(N_FACTOR);
  
    for (Message msg : messages) {
        if (msg.isFromMe == 1) {
//    if (msg.id.equals("") && msg.isFromMe == 0) {
      //      println(msg.text);
//      fill(0);
//      textFont(font);
//      text(msg.text, 10, 20*x);
//      x++;
//println(msg.text);
            rm.loadText(msg.text);
    }
  }

}

void draw() {
  //  String[] chain = rm.generateTokens((int)random(10));
  //  for (String word : chain) {
  //    print(word + " ");
  //  }
  //  println(" ");
  background(255);
  int x = 0;
//  for (Message msg : messages) {
//    //    if (msg.isFromMe == 1) {
//    if (msg.id.equals("") && msg.isFromMe == 0) {
//      //      println(msg.text);
//      fill(0);
//      textFont(font);
//      text(msg.text, 10, 20*x);
//      x++;
////            rm.loadText(msg.text);
//    }
//  }

  //  textFont(font);
  //  text(rm.generate(),10, 50);
    println(rm.generate());
}
