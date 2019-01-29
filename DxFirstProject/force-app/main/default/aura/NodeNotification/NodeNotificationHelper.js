({
    connectCometd : function(component){
        var helper = this;
        
        // Configure Cometd url
        var cometdurl = window.location.protocol+'//'+window.location.hostname+'/cometd/40.0/';
  	
        // Confrigure Cometd -attribute type 'object'
        var cometd = component.get('v.cometd');
        cometd.configure({
            url: cometdUrl,
            requestHeaders: { Authorization: 'OAuth'+component.get('v.sessionId')},
            appendMessageTypeToURL : false
        });
        cometd.websocketEnabled = false;
        
        // Establish CometD Connection
        console.log('Connecting to CometD: '+cometdurl);
        cometd.handshake(function(handshakeReply){
            if(handshakeReply.successful){
                console.log('connected to cometd');
                
                var newSubscription = cometd.subscribe('/event/NodeDemo__e',
                    function(platformEvent) {
            			console.log('Platform event received: '+ JSON.stringify(platformEvent));
            			helper.onReceiveNotification(component, platformEvent);
          				}                                                                
                );
                
                 var subscriptions = component.get('v.cometdSubscriptions');
        			subscriptions.push(newSubscription);
        			component.set('v.cometdSubscriptions', subscriptions);
      				}
            else
				console.error('Failed to connected to CometD.');
        });
    },
    
    
  disconnectCometd : function(component) {
    var cometd = component.get('v.cometd');

    // Unsuscribe all CometD subscriptions
    cometd.batch(function() {
      var subscriptions = component.get('v.cometdSubscriptions');
      subscriptions.forEach(function (subscription) {
        cometd.unsubscribe(subscription);
      });
    });
    component.set('v.cometdSubscriptions', []);

    // Disconnect CometD
    cometd.disconnect();
    console.log('CometD disconnected.');
  },
    
    onReceiveNotification : function(component, platformEvent) {
    var helper = this;
    // Extract notification from platform event
    var newNotification = {
      time : $A.localizationService.formatDateTime(
        platformEvent.data.payload.CreatedDate, 'HH:mm'),
      message : platformEvent.data.payload.Message__c
    };
    // Save notification in history
    var notifications = component.get('v.notifications');
    notifications.push(newNotification);
    component.set('v.notifications', notifications);
    // Display notification in a toast if not muted
    if (!component.get('v.isMuted'))
      helper.displayToast(component, 'info', newNotification.message);
  },

    
    
	displayToast : function(component, type, message) {
        var toastEvent = $A.get('e.force:showToast');
        toastEvent.setParams({
            type: type,
            message: message
        });
        
        toastEvent.fire();
	}
})