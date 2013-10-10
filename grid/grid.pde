import de.bezier.data.sql.*;

SQLite db;
ArrayList<Message> messages;
HashMap<String, Person> peopleMap;
final int N_FACTOR = 2;
final int POINT_SIZE = 4;
PFont font;

void setup() {
  font = createFont("Arial", 16, true);

  messages = new ArrayList();
  peopleMap = new HashMap();
  db = new SQLite(this, "messages.db");  

  if (db.connect()) {      
    db.query( "SELECT message.is_from_me,message.text,handle.id FROM " 
      + "handle INNER JOIN message ON message.handle_id = handle.ROWID "
      + "ORDER BY message.date");

    while (db.next ()) {
      Message msg = new Message();
      db.setFromRow(msg);
      messages.add(msg);
      
      if (peopleMap.containsKey(msg.id)) {
        msg.person = peopleMap.get(msg.id);
      } else {
        peopleMap.put(msg.id,new Person());
      }
    }
  }
  
  int dimension = ((int) Math.sqrt(messages.size())) * POINT_SIZE;
  size(dimension, dimension);
//  noStroke();
}

void draw() {
  background(255);
  int x = 0;
  for (int i = 0; i < height; i+=POINT_SIZE) {
    for (int j = 0; j < width; j+=POINT_SIZE) {
      if (x >= messages.size()) {
        return;
      }
      Message message = messages.get(x);
      Person person = peopleMap.get(message.id);
      float a = 255;
      if (message.isFromMe == 1) {
        a = 175;
      }
      fill(person.r,person.g,person.b,a);
      stroke(person.r,person.g,person.b,a);
      ellipse(j,i,POINT_SIZE*0.5, POINT_SIZE*0.5);
      x++;
    }
  }
  
}
