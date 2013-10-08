import de.bezier.data.sql.*;

SQLite db;

void setup()
{
    size(100, 100);

    db = new SQLite(this, "messages.db");  
    
    if (db.connect()) {      
        db.query( "SELECT message.is_from_me,message.text,handle.id FROM " 
        + "handle INNER JOIN message ON message.handle_id = handle.ROWID "
        + "ORDER BY handle.id");
        
        while (db.next()) {
            Message t = new Message();
            db.setFromRow( t );
            println( t );
        }
    }
}
