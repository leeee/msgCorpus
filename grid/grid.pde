import de.bezier.data.sql.*;

SQLite db;
ArrayList<Message> messages;
HashMap<String, Person> peopleMap;
final int POINT_SIZE = 40;
PFont font;
int dimension;
final float GOLDEN_RATIO = 0.618033988749895;
String[] firstLetters = {"A", "B", "C", "D", "E", "F", "G", "H", "I", 
                    "J", "K", "L", "M", "N", "O", "P", "Q", "R",
                    "S", "T", "U", "V", "W", "X", "Y", "Z"};

String[] lastLetters = {"A", "B", "C", "D", "E", "F", "G", "H", "I", 
                    "J", "K", "L", "M", "N", "O", "P", "Q", "R",
                    "S", "T", "U", "V", "W", "X", "Y", "Z"};

void setup() {
  float h = random(1);
  Table initialsTable = loadTable("handlesinitials.csv", "header");
  font = createFont("Arial", 11, true); // how to make smaller?
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
        Person newPerson = new Person(h,.7,.5);
//        newPerson.initials = firstLetters[floor(random(firstLetters.length - 1))] 
//                             + lastLetters[floor(random(lastLetters.length - 1))];
        // find initials
        TableRow result = initialsTable.findRow(msg.id,"number");
        if (result != null) {
          String initials = result.getString("initials");
          if (initials.equals("robot")) {
            newPerson.initials = "RB";
            // grayscale or robot face
          } else if (initials.equals("unknown")) {
            newPerson.initials = "??";
          } else {
            newPerson.initials = result.getString("initials");
          }
        } else {
          newPerson.initials = "XX";
        }
        peopleMap.put(msg.id, newPerson);
        println(newPerson.initials);
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
  for (int i = POINT_SIZE/2; i < height; i+=POINT_SIZE) {
    for (int j = POINT_SIZE/2; j < width; j+=POINT_SIZE) {
      if (x >= messages.size()) {
        return;
      }
      Message message = messages.get(x);
      Person person = peopleMap.get(message.id);
      colorMode(HSB,1,1,1);
      fill(person.h,person.s,person.b,255);
      colorMode(RGB,255,255,255);

      float radius = (float)POINT_SIZE - 3;
      ellipse(j,i,radius, radius);
      if (message.isFromMe == 1) {
        fill(255);
        ellipse(j,i, POINT_SIZE - 10, POINT_SIZE - 10);
        colorMode(HSB,1,1,1);
        fill(person.h,person.s,person.b,255);
        colorMode(RGB,255,255,255);
        text(person.initials, j - 9, i + 5);
      } else {
        fill(255);
        text(person.initials, j - 9, i + 5);
      }

      x++;
    }
  }
}

void keyPressed() {
  if (key == 's') {
    save("grid.tif");  
  }
}
