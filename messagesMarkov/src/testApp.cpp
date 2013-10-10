#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){
  sqlite.setup("messages.db");

//  select message.is_from_me,message.text,handle.id, (message.date_read - message.date_delivered) as date_diff from message inner join handle on message.handle_id = handle.ROWID order by handle.ROWID,date_diff;

//  ofxSQLiteSelect select = sqlite.select("is_from_me,text,handle_id").from("message").join("handle", "ROWID = handle_id", "ROWID");
  
  ofxSQLiteSelect sel = sqlite.select("is_from_me,text,handle_id").from("message");
  sel.execute().begin();
  while (sel.hasNext()) {
    int is_from_me = sel.getInt(0);
    int handle_id = sel.getInt(1);
    std::string text = sel.getString();
    cout << is_from_me << ", " << handle_id << ", " << text << endl;
    sel.next();
  }
  
//  ofxSQLiteSelect sel = sqlite->select("id, time").from("scores");
//	sel.execute().begin();
//  
//	while(sel.hasNext()) {
//		int id = sel.getInt();
//		std::string name = sel.getString();
//		cout << id << ", " << name << endl;
//		sel.next();
//	}
//  
//	// select
//	sel = sqlite->select("id, start_time")
//  .from("game_runs")
//  .join("game_run_data", "runid = id", "runid, gdata")
//  .where("runid", 3)
//  .orWhere("runid",13)
//  .orWhere("runid", last_run_id)
//  //.limit(5)
//  .order("runid", " DESC ")
//  .execute().begin();
//  
//	while(sel.hasNext()) {
//		int runid = sel.getInt();
//		string gdata = sel.getString();
//		cout << "runid: " << runid << ", gdata: " << gdata << endl;
//		sel.next();
//	}

}

//--------------------------------------------------------------
void testApp::update(){

}

//--------------------------------------------------------------
void testApp::draw(){

}

//--------------------------------------------------------------
void testApp::keyPressed(int key){

}

//--------------------------------------------------------------
void testApp::keyReleased(int key){

}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void testApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void testApp::dragEvent(ofDragInfo dragInfo){ 

}
