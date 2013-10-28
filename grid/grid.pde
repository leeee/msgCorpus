import de.bezier.data.sql.*;

SQLite db;
ArrayList<Message> messages;
HashMap<String, Person> peopleMap;
final int POINT_SIZE = 3;
PFont font;
int dimension;
final float GOLDEN_RATIO = 0.618033988749895;

void setup() {
  float h = random(1);
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
        h += GOLDEN_RATIO*.75;
        h %= 1;
        peopleMap.put(msg.id,new Person(h,.5,.90));
      }
    }
  }
  
  dimension = ((int) Math.sqrt(messages.size()));
  size(dimension * POINT_SIZE, dimension * POINT_SIZE);
  noStroke();
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
        a = a - 75;
      }
      colorMode(HSB,1,1,1);
      fill(person.h,person.s,person.b,a);
      colorMode(RGB,255,255,255);
//      stroke(person.r,person.g,person.b,a);
      float radius = (float)POINT_SIZE;
      rect(j+radius,i+radius,radius, radius);
      x++;
    }
  }
  save("grid.png");  
}
