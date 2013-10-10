class Message {
    public String text;
    public int isFromMe;
    public String id;
    public Person person;
    
    public String toString ()
    {
      if (isFromMe == 0) {
        return String.format("<- text: %s from: %s", text, id);
      } else {
        return String.format("-> text: %s to: %s", text, id);
      }
    }
}
