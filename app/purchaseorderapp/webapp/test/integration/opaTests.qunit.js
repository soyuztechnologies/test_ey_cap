sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ey/anubhav/purchaseorderapp/test/integration/FirstJourney',
		'ey/anubhav/purchaseorderapp/test/integration/pages/POsList',
		'ey/anubhav/purchaseorderapp/test/integration/pages/POsObjectPage',
		'ey/anubhav/purchaseorderapp/test/integration/pages/POItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, POItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ey/anubhav/purchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePOItemsObjectPage: POItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);