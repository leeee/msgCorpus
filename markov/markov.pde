import de.bezier.data.sql.*;
import rita.*;

SQLite db;
ArrayList messages;
RiMarkov rm;
final int N_FACTOR = 3;

void setup() {
    size(100, 100);

    messages = new ArrayList();
    db = new SQLite(this, "messages.db");  
    
    if (db.connect()) {      
        db.query( "SELECT message.is_from_me,message.text,handle.id FROM " 
        + "handle INNER JOIN message ON message.handle_id = handle.ROWID "
        + "ORDER BY handle.id");
        
        while (db.next()) {
            Message msg = new Message();
            db.setFromRow(msg);
            println(msg);
            messages.add(msg);
        }
    }
    
    // Set up markov.
    rm = new RiMarkov(N_FACTOR);
    for (Message msg : messages) {
      
    }
     
}
