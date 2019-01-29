public class NodeNotificationController {
   
  @AuraEnabled
public static String getSessionId() {
  return UserInfo.getSessionId();
}

}