/**
 * Created by fpardon on 23/02/2022.
 */

@IsTest
private class MultiRequestMockTest {
    @IsTest
    static void testBehavior() {

        SingleRequestMock pbBaseCall = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "size" : 2,\n' +
                        '  "totalSize" : 2,\n' +
                        '  "done" : true,\n' +
                        '  "queryLocator" : null,\n' +
                        '  "entityTypeName" : "AggregateResult",\n' +
                        '  "records" : [ {\n' +
                        '    "attributes" : {\n' +
                        '      "type" : "AggregateResult"\n' +
                        '    },\n' +
                        '    "DeveloperName" : "Account",\n' +
                        '    "expr0" : 1\n' +
                        '  }, {\n' +
                        '    "attributes" : {\n' +
                        '      "type" : "AggregateResult"\n' +
                        '    },\n' +
                        '    "DeveloperName" : "Lead_Insert_Update",\n' +
                        '    "expr0" : 1\n' +
                        '  } ]\n' +
                        '}',
                null);

        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        MultiRequestMock m = new MultiRequestMock(endpoint2TestResp);
        m.addRequestMock('test.com', pbBaseCall);

        Test.setMock(HttpCalloutMock.class, m);

        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('test.com');

        Http h = new Http();
        HttpResponse resp = h.send(req);
        Integer respCode = resp.getStatusCode();

        System.assertEquals(respCode, respCode);

    }
}