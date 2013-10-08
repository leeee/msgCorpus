import de.bezier.data.sql.*;

SQLite db;

void setup()
{
    size(100, 100);

    db = new SQLite(this, "messages.db");  
    
    if (db.connect()) {      
        db.query( "SELECT message.is_from_me,message.text,handle.id FROM " 
        + "handle INNER JOIN message ON message.handle_id = handle.ROWID "
        + "ORDER BY handle.id LIMIT 10");
        
        while (db.next()) {
            TableOne t = new TableOne();
            db.setFromRow( t );
            println( t );
        }
    }
}

class TableOne
{
    public String text;
    public int isFromMe;
    public String id;
    
    public String toString ()
    {
      if (isFromMe == 0) {
        return String.format("<- text: %s from: %s", text, id);
      } else {
        return String.format("-> text: %s to: %s", text, id);
      }
    }
}
