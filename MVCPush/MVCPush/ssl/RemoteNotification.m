#include "RemoteNotification.h"



#define CA_CERT_PATH        "Certs/apns.cer"

/* Development Certificates */ 
#define RSA_CLIENT_CERT     "Certs/apn-dev-cert.pem"
#define RSA_CLIENT_KEY      "Certs/apn-dev-key.pem"

/* Development Connection Infos */
#define APPLE_HOST          "gateway.push.apple.com"
#define APPLE_PORT          2195

#define APPLE_FEEDBACK_HOST "feedback.push.apple.com"
#define APPLE_FEEDBACK_PORT 2196


#define DEVICE_BINARY_SIZE  32
#define MAXPAYLOAD_SIZE     256

/* Used internally to send the payload */
int send_payload(const char *deviceTokenHex, const char *payloadBuff, size_t payloadLength);

/* Initialize the Payload with zero values */
void init_payload(Payload *payload)
{
	//bzero(payload, sizeof(Payload));
    memset(payload, 0, sizeof(Payload));
}

/* Function for sending the Payload */
int send_remote_notification(const char *deviceTokenHex, Payload *payload)
{
        char messageBuff[MAXPAYLOAD_SIZE];
        char tmpBuff[MAXPAYLOAD_SIZE];
        char badgenumBuff[3];

        strcpy(messageBuff, "{\"aps\":{");

        if(payload->message != NULL)
        {
            strcat(messageBuff, "\"alert\":");
            if(payload->actionKeyCaption != NULL)
            {
                sprintf(tmpBuff, "{\"body\":\"%s\",\"action-loc-key\":\"%s\"},", payload->message, payload->actionKeyCaption);
                strcat(messageBuff, tmpBuff);
            }
            else
            {
                sprintf(tmpBuff, "{\"%s\"},", payload->message);
                strcat(messageBuff, tmpBuff);
            }
        }

        if(payload->badgeNumber > 99 || payload->badgeNumber < 0)
            payload->badgeNumber = 1;

        sprintf(badgenumBuff, "%d", payload->badgeNumber);
        strcat(messageBuff, "\"badge\":");
        strcat(messageBuff, badgenumBuff);

        strcat(messageBuff, ",\"sound\":\"");
        strcat(messageBuff, payload->soundName == NULL ? "default" : payload->soundName);
        strcat(messageBuff, "\"}");

        int i = 0;
        while(payload->dictKey[i] != NULL && i < 5)
        {
            sprintf(tmpBuff, "\"%s\":\"%s\"", payload->dictKey[i], payload->dictValue[i]);
            strcat(messageBuff, tmpBuff);
            if(i < 4 && payload->dictKey[i + 1] != NULL)
            {
                strcat(messageBuff, ",");
            }
            i++;
        }

        strcat(messageBuff, "}");
        printf("Sending %s\n", messageBuff);
       //messageBuff = ;
    char testms[300];
    //strcat(testms,"{\"aps\":{\"alert\":\"lvyile has responded to your subscribed topic.\"},\"forum_id\":\"88\",\"topic_id\":\"999\"}");
    send_payload(deviceTokenHex, "{\"aps\":{\"alert\":\"Send Push Message From iPhone!\"},\"forum_id\":\"88\",\"topic_id\":\"999\"}"/*messageBuff*/, strlen("{\"aps\":{\"alert\":\"Send Push Message From iPhone!\"},\"forum_id\":\"88\",\"topic_id\":\"999\"}"));
    return 0;
}

int send_payload(const char *deviceTokenHex, const char *payloadBuff, size_t payloadLength)
{
    int rtn = 0;
    NSString* rsacert = [[NSBundle mainBundle] pathForResource:@"apns-dev-cert" ofType:@"pem"];
    NSString* rsakey= [[NSBundle mainBundle] pathForResource:@"apns-dev-key" ofType:@"pem"];
    NSString* cerStr = [[NSBundle mainBundle] pathForResource:@"aps_developer_identity" ofType:@"cer"];
    printf("%s\n",[rsacert UTF8String]);
    printf("%s\n",[rsakey UTF8String]);
    printf("%s\n",[cerStr UTF8String]);
    const char* chRSA = [rsacert UTF8String];
    const char* chKEY = [rsakey UTF8String];
    const char* chCER = [cerStr UTF8String];
    SSL_Connection *sslcon = ssl_connect("gateway.push.apple.com", 2195, chRSA, chKEY, chCER);
    if(sslcon == NULL)
    {
        printf("Could not allocate memory for SSL Connection");
        exit(1);
    }

    if (sslcon && deviceTokenHex && payloadBuff && payloadLength)
    {
        uint8_t command = 0; /* command number */
        char binaryMessageBuff[sizeof(uint8_t) + sizeof(uint16_t) + DEVICE_BINARY_SIZE + sizeof(uint16_t) + MAXPAYLOAD_SIZE];

        /* message format is, |COMMAND|TOKENLEN|TOKEN|PAYLOADLEN|PAYLOAD| */
        char *binaryMessagePt = binaryMessageBuff;
        uint16_t networkOrderTokenLength = htons(DEVICE_BINARY_SIZE);
        uint16_t networkOrderPayloadLength = htons(payloadLength);
 
        /* command */
        *binaryMessagePt++ = command;
 
        /* token length network order */
        memcpy(binaryMessagePt, &networkOrderTokenLength, sizeof(uint16_t));
        binaryMessagePt += sizeof(uint16_t);

        /* Convert the Device Token */
        int i = 0;
        int j = 0;
        int tmpi;
        char tmp[3];
        char deviceTokenBinary[DEVICE_BINARY_SIZE];
        while(i < strlen(deviceTokenHex))
        {
            if(deviceTokenHex[i] == ' ')
            {
                i++;
            }
            else
            {
                tmp[0] = deviceTokenHex[i];
                tmp[1] = deviceTokenHex[i + 1];
                tmp[2] = '\0';

                sscanf(tmp, "%x", &tmpi);
                deviceTokenBinary[j] = tmpi;

                i += 2;
                j++;
            }
        }

        /* device token */
        memcpy(binaryMessagePt, deviceTokenBinary, DEVICE_BINARY_SIZE);
        binaryMessagePt += DEVICE_BINARY_SIZE;

        /* payload length network order */
        memcpy(binaryMessagePt, &networkOrderPayloadLength, sizeof(uint16_t));
        binaryMessagePt += sizeof(uint16_t);
 
        /* payload */
        memcpy(binaryMessagePt, payloadBuff, payloadLength);
        binaryMessagePt += payloadLength;
        if (SSL_write(sslcon->ssl, binaryMessageBuff, (binaryMessagePt - binaryMessageBuff)) > 0)
        {
            rtn = 1;
            printf("%s\n", "-------------------SSL_Write Success!------------------");
        }
            
            
    }

    ssl_disconnect(sslcon);

    return rtn;
}
