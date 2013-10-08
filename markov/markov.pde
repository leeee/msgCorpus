import de.bezier.data.sql.*;

SQLite db;

void setup()
{
    size(100, 100);

    db = new SQLite(this, "messages.db");  
    
    if (db.connect()) {      
//        String[] tableNames = db.getTableNames();
//        db.query( "SELECT message.is_from_me,message.text,handle.id FROM " 
//        + "message INNER JOIN handle ON message.handle_id = handle.ROWID "
//        + "order by handle.ROWID");
        db.query( "SELECT message.is_from_me,message.text,message.handle_id FROM " 
        + "message ORDER BY message.handle_id");
        
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
    public int handleId;
    
    public String toString ()
    {
      if (isFromMe == 0) {
        return String.format("<- text: %s from: %d", text, handleId);
      } else {
        return String.format("-> text: %s to: %d", text, handleId);
      }
    }
}
