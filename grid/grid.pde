import de.bezier.data.sql.*;

SQLite db;
ArrayList<Message> messages;
HashMap<String, Person> peopleMap;
final int POINT_SIZE = 5;
PFont font;
String hoverPerson = "";
int dimension;

void setup() {
  // TODO: add mouseover interaction to see who each dot is
  
  font = createFont("Arial", 16, true);

  messages = new ArrayList();
  peopleMap = new HashMap();
  db = new SQLite(this, "messages.db");  
  int limit = 0;
  if (db.connect()) {      
    db.query( "SELECT message.is_from_me,message.text,handle.id FROM " 
      + "handle INNER JOIN message ON message.handle_id = handle.ROWID "
      + "ORDER BY message.date");

    while (db.next () && limit < 1000) {
      limit++;
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
  
  dimension = ((int) Math.sqrt(messages.size()));
  size(dimension * POINT_SIZE, dimension * POINT_SIZE);
//  noStroke();
}

void draw() {
  background(255);
  int x = 0;
  int column = mouseX / POINT_SIZE;
  int row = mouseY / POINT_SIZE;
  int hoverPersonIndex = row * dimension + column;
  hoverPerson = messages.get(hoverPersonIndex).id;
  println(dimension + " " + mouseY + " " + row + " " + mouseX + " " + column + " " + hoverPerson);
  for (int i = 0; i < height; i+=POINT_SIZE) {
    for (int j = 0; j < width; j+=POINT_SIZE) {
      if (x >= messages.size()) {
        return;
      }
      Message message = messages.get(x);
      Person person = peopleMap.get(message.id);
      float a = 100;
      if (hoverPerson.equals(message.id)) {
        a = 255;
      }
      if (message.isFromMe == 1) {
        a = a - 75;
      }
      fill(person.r,person.g,person.b,a);
      stroke(person.r,person.g,person.b,a);
      float radius = POINT_SIZE*0.5;
      ellipse(j+radius,i+radius,radius, radius);
      x++;
//      if (dist(mouseX, mouseY, j+radius, i+radius) <= radius) {
//        hoverPerson = message.id;
//      }
    }
  }
  
  if (!hoverPerson.equals("")) {
    fill (0, 200);
    rect(mouseX, mouseY, 150, 20);
    fill (255);
    text(hoverPerson, mouseX + 5, mouseY + 15);
  }
  
  
  
}
