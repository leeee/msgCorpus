import de.bezier.data.sql.*;

SQLite db;
ArrayList<Message> messages;
HashMap<String, Person> peopleMap;
final int N_FACTOR = 2;
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
  
  int dimension = ((int) Math.sqrt(messages.size())) * 3;
  size(dimension, dimension);
  noStroke();
}

void draw() {
  int x = 0;
  for (int i = 0; i < height; i+=3) {
    for (int j = 0; j < width; j+=3) {
      if (x >= messages.size()) {
        return;
      }
      Person person = peopleMap.get(messages.get(x).id);
      fill(person.r,person.g,person.b);
      rect(j, i, 3, 3);
      x++;
    }
  }
  
}
