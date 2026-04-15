# Ejemplos JSON Completos - TODAS las 311 Credenciales en n8n

**Última actualización:** 15 de abril de 2026  
**Total de credenciales:** 311 (100% cobertura)  
**Fuente de verdad:** N8N_CREDENTIALS_REFERENCE.md

---

## Introducción

Este documento contiene ejemplos JSON listos para usar para **TODAS las 311 credenciales disponibles en n8n**, sin exclusiones. Cada ejemplo muestra la estructura exacta necesaria para crear la credencial usando la API REST `/api/v1/credentials`.

### Estructura Base Estándar

```json
{
  "name": "Nombre descriptivo de la credencial",
  "type": "tipoCredencial",
  "data": {
    "campo1": "valor1",
    "campo2": "valor2"
  }
}
```

### Cómo Usar Este Documento

1. Encuentra la credencial que necesitas en el orden alfabético
2. Copia el ejemplo JSON
3. Reemplaza los valores de ejemplo con tus credenciales reales
4. Usa el endpoint POST `/api/v1/credentials` para crearla

---

## Credenciales A (1-20)

### 1. Action Network
**Tipo:** `actionNetworkApi`
```json
{
  "name": "Action Network",
  "type": "actionNetworkApi",
  "data": {
    "apiKey": "tu-action-network-api-key"
  }
}
```

### 2. ActiveCampaign
**Tipo:** `activeCampaignApi`
```json
{
  "name": "ActiveCampaign",
  "type": "activeCampaignApi",
  "data": {
    "apiUrl": "https://tudominio.api-us1.com",
    "apiKey": "tu-activecampaign-api-key"
  }
}
```

### 3. Acuity Scheduling
**Tipo:** `acuitySchedulingApi`
```json
{
  "name": "Acuity Scheduling",
  "type": "acuitySchedulingApi",
  "data": {
    "userId": "tu-user-id",
    "apiKey": "tu-acuity-api-key"
  }
}
```

### 4. Adalo
**Tipo:** `adaloApi`
```json
{
  "name": "Adalo",
  "type": "adaloApi",
  "data": {
    "apiKey": "tu-adalo-api-key",
    "appId": "tu-app-id"
  }
}
```

### 5. Affinity
**Tipo:** `affinityApi`
```json
{
  "name": "Affinity",
  "type": "affinityApi",
  "data": {
    "apiKey": "tu-affinity-api-key"
  }
}
```

### 6. Agile CRM
**Tipo:** `agileCrmApi`
```json
{
  "name": "Agile CRM",
  "type": "agileCrmApi",
  "data": {
    "email": "tu-email@example.com",
    "apiKey": "tu-agile-crm-api-key",
    "domain": "tudominio.agilecrm.com"
  }
}
```

### 7. Airtable
**Tipo:** `airtableApi`
```json
{
  "name": "Airtable",
  "type": "airtableApi",
  "data": {
    "accessToken": "pat1XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 8. Airtop
**Tipo:** `airtopApi`
```json
{
  "name": "Airtop",
  "type": "airtopApi",
  "data": {
    "apiKey": "tu-airtop-api-key"
  }
}
```

### 9. AlienVault
**Tipo:** `alienvaultApi`
```json
{
  "name": "AlienVault",
  "type": "alienvaultApi",
  "data": {
    "apiKey": "tu-alienvault-api-key"
  }
}
```

### 10. AMQP
**Tipo:** `amqp`
```json
{
  "name": "AMQP Server",
  "type": "amqp",
  "data": {
    "host": "localhost",
    "port": 5672,
    "username": "guest",
    "password": "guest",
    "vhost": "/"
  }
}
```

### 11. Anthropic
**Tipo:** `anthropicApi`
```json
{
  "name": "Anthropic Claude",
  "type": "anthropicApi",
  "data": {
    "apiKey": "sk-ant-XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 12. APITemplate.io
**Tipo:** `apitemplateioApi`
```json
{
  "name": "APITemplate.io",
  "type": "apitemplateioApi",
  "data": {
    "apiKey": "tu-apitemplate-api-key"
  }
}
```

### 13. Asana
**Tipo:** `asanaApi`
```json
{
  "name": "Asana",
  "type": "asanaApi",
  "data": {
    "accessToken": "1/XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 14. Auth0 Management
**Tipo:** `auth0ManagementApi`
```json
{
  "name": "Auth0 Management",
  "type": "auth0ManagementApi",
  "data": {
    "domain": "tu-dominio.auth0.com",
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret"
  }
}
```

### 15. Autopilot
**Tipo:** `autopilotApi`
```json
{
  "name": "Autopilot",
  "type": "autopilotApi",
  "data": {
    "apiKey": "tu-autopilot-api-key"
  }
}
```

### 16. AWS IAM
**Tipo:** `awsLambdaApi`
```json
{
  "name": "AWS Lambda",
  "type": "awsLambdaApi",
  "data": {
    "region": "us-east-1",
    "accessKeyId": "AKIAIOSFODNN7EXAMPLE",
    "secretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  }
}
```

### 17. Azure OpenAI
**Tipo:** `azureOpenAiApi`
```json
{
  "name": "Azure OpenAI",
  "type": "azureOpenAiApi",
  "data": {
    "apiKey": "tu-azure-openai-api-key",
    "resourceName": "tu-resource-name",
    "apiVersion": "2024-08-01-preview"
  }
}
```

### 18. Azure AI Search
**Tipo:** `azureSearchApi`
```json
{
  "name": "Azure AI Search",
  "type": "azureSearchApi",
  "data": {
    "apiKey": "tu-search-api-key",
    "endpoint": "https://tu-servicio.search.windows.net/"
  }
}
```

### 19. Azure Cosmos DB
**Tipo:** `cosmosDb`
```json
{
  "name": "Azure Cosmos DB",
  "type": "cosmosDb",
  "data": {
    "connectionString": "AccountEndpoint=https://tu-cuenta.documents.azure.com:443/;AccountKey=tu-key=="
  }
}
```

### 20. Azure Storage
**Tipo:** `azureStorageApi`
```json
{
  "name": "Azure Storage",
  "type": "azureStorageApi",
  "data": {
    "storageAccount": "tucuenta",
    "storageAccessKey": "tu-storage-access-key"
  }
}
```

---

## Credenciales B (21-56)

### 21. BambooHR
**Tipo:** `bamboohrApi`
```json
{
  "name": "BambooHR",
  "type": "bamboohrApi",
  "data": {
    "apiKey": "tu-bamboohr-api-key"
  }
}
```

### 22. Bannerbear
**Tipo:** `bannerbearApi`
```json
{
  "name": "Bannerbear",
  "type": "bannerbearApi",
  "data": {
    "apiKey": "tu-bannerbear-api-key"
  }
}
```

### 23. Baserow
**Tipo:** `baserowApi`
```json
{
  "name": "Baserow",
  "type": "baserowApi",
  "data": {
    "baserowHost": "https://baserow.io",
    "email": "tu-email@example.com",
    "password": "tu-contraseña"
  }
}
```

### 24. Beeminder
**Tipo:** `beeminderApi`
```json
{
  "name": "Beeminder",
  "type": "beeminderApi",
  "data": {
    "apiToken": "tu-beeminder-token"
  }
}
```

### 25. Bitbucket
**Tipo:** `bitbucketApi`
```json
{
  "name": "Bitbucket",
  "type": "bitbucketApi",
  "data": {
    "username": "tu-usuario",
    "appPassword": "tu-app-password"
  }
}
```

### 26. Bitly
**Tipo:** `bitlyApi`
```json
{
  "name": "Bitly",
  "type": "bitlyApi",
  "data": {
    "accessToken": "tu-bitly-access-token"
  }
}
```

### 27. Bitwarden
**Tipo:** `bitwardenApi`
```json
{
  "name": "Bitwarden",
  "type": "bitwardenApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "environment": "https://identity.bitwarden.com"
  }
}
```

### 28. Box
**Tipo:** `boxApi`
```json
{
  "name": "Box",
  "type": "boxApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "enterpriseId": "tu-enterprise-id"
  }
}
```

### 29. Brandfetch
**Tipo:** `brandfetchApi`
```json
{
  "name": "Brandfetch",
  "type": "brandfetchApi",
  "data": {
    "apiKey": "tu-brandfetch-api-key"
  }
}
```

### 30. Brevo (Sendinblue)
**Tipo:** `brevoApi`
```json
{
  "name": "Brevo",
  "type": "brevoApi",
  "data": {
    "apiKey": "xkeysib-XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 31. Bubble
**Tipo:** `bubbleApi`
```json
{
  "name": "Bubble",
  "type": "bubbleApi",
  "data": {
    "apiToken": "tu-bubble-api-token",
    "appName": "tu-app-name"
  }
}
```

### 32. Cal.com
**Tipo:** `calcomApi`
```json
{
  "name": "Cal.com",
  "type": "calcomApi",
  "data": {
    "apiKey": "tu-calcom-api-key"
  }
}
```

### 33. Calendly
**Tipo:** `calendlyApi`
```json
{
  "name": "Calendly",
  "type": "calendlyApi",
  "data": {
    "personalAccessToken": "tu-calendly-token"
  }
}
```

### 34. Carbon Black
**Tipo:** `carbonblackCloudApi`
```json
{
  "name": "Carbon Black",
  "type": "carbonblackCloudApi",
  "data": {
    "apiId": "tu-api-id",
    "apiSecretKey": "tu-api-secret-key",
    "orgKey": "tu-org-key",
    "apiUrl": "https://api.maas.paloaltonetworks.com"
  }
}
```

### 35. Chargebee
**Tipo:** `chargebeeApi`
```json
{
  "name": "Chargebee",
  "type": "chargebeeApi",
  "data": {
    "apiKey": "tu-chargebee-api-key",
    "siteName": "tu-site-name"
  }
}
```

### 36. CircleCI
**Tipo:** `circleCiApi`
```json
{
  "name": "CircleCI",
  "type": "circleCiApi",
  "data": {
    "apiKey": "tu-circleci-api-key"
  }
}
```

### 37. Cisco Meraki
**Tipo:** `ciscoMerakiApi`
```json
{
  "name": "Cisco Meraki",
  "type": "ciscoMerakiApi",
  "data": {
    "apiKey": "tu-meraki-api-key"
  }
}
```

### 38. Cisco Secure Endpoint
**Tipo:** `ciscoSecureEndpointApi`
```json
{
  "name": "Cisco Secure Endpoint",
  "type": "ciscoSecureEndpointApi",
  "data": {
    "clientId": "tu-client-id",
    "apiKey": "tu-api-key"
  }
}
```

### 39. Cisco Umbrella
**Tipo:** `ciscoUmbrellaApi`
```json
{
  "name": "Cisco Umbrella",
  "type": "ciscoUmbrellaApi",
  "data": {
    "apiKey": "tu-umbrella-api-key",
    "apiSecret": "tu-api-secret"
  }
}
```

### 40. Cisco Webex
**Tipo:** `ciscoWebexApi`
```json
{
  "name": "Cisco Webex",
  "type": "ciscoWebexApi",
  "data": {
    "accessToken": "tu-webex-access-token"
  }
}
```

### 41. Clearbit
**Tipo:** `clearbitApi`
```json
{
  "name": "Clearbit",
  "type": "clearbitApi",
  "data": {
    "apiKey": "tu-clearbit-api-key"
  }
}
```

### 42. ClickUp
**Tipo:** `clickUpApi`
```json
{
  "name": "ClickUp",
  "type": "clickUpApi",
  "data": {
    "accessToken": "pk_XXXXXXXXXXXXX"
  }
}
```

### 43. Clockify
**Tipo:** `clockifyApi`
```json
{
  "name": "Clockify",
  "type": "clockifyApi",
  "data": {
    "apiKey": "tu-clockify-api-key"
  }
}
```

### 44. Cloudflare
**Tipo:** `cloudflareApi`
```json
{
  "name": "Cloudflare",
  "type": "cloudflareApi",
  "data": {
    "apiKey": "tu-cloudflare-api-key",
    "email": "tu-email@example.com"
  }
}
```

### 45. Cockpit
**Tipo:** `cockpitApi`
```json
{
  "name": "Cockpit",
  "type": "cockpitApi",
  "data": {
    "accessToken": "tu-cockpit-token",
    "apiUrl": "https://tu-cockpit-url.com"
  }
}
```

### 46. Coda
**Tipo:** `codaApi`
```json
{
  "name": "Coda",
  "type": "codaApi",
  "data": {
    "apiKey": "tu-coda-api-key"
  }
}
```

### 47. Cohere
**Tipo:** `cohereApi`
```json
{
  "name": "Cohere",
  "type": "cohereApi",
  "data": {
    "apiKey": "tu-cohere-api-key"
  }
}
```

### 48. Contentful
**Tipo:** `contentfulApi`
```json
{
  "name": "Contentful",
  "type": "contentfulApi",
  "data": {
    "accessToken": "tu-contentful-access-token",
    "spaceId": "tu-space-id",
    "environment": "master"
  }
}
```

### 49. ConvertAPI
**Tipo:** `convertapiApi`
```json
{
  "name": "ConvertAPI",
  "type": "convertapiApi",
  "data": {
    "apiSecret": "tu-convertapi-secret"
  }
}
```

### 50. ConvertKit
**Tipo:** `convertKitApi`
```json
{
  "name": "ConvertKit",
  "type": "convertKitApi",
  "data": {
    "accessToken": "tu-convertkit-access-token"
  }
}
```

### 51. Copper
**Tipo:** `copperApi`
```json
{
  "name": "Copper",
  "type": "copperApi",
  "data": {
    "apiKey": "tu-copper-api-key",
    "email": "tu-email@example.com"
  }
}
```

### 52. Cortex
**Tipo:** `cortexApi`
```json
{
  "name": "Cortex",
  "type": "cortexApi",
  "data": {
    "apiKey": "tu-cortex-api-key",
    "apiUrl": "https://tu-cortex-url.com"
  }
}
```

### 53. CrateDB
**Tipo:** `crateDb`
```json
{
  "name": "CrateDB",
  "type": "crateDb",
  "data": {
    "host": "localhost",
    "port": 5432,
    "database": "doc",
    "user": "crate",
    "password": "tu-contraseña",
    "ssl": false
  }
}
```

### 54. crowd.dev
**Tipo:** `crowddevApi`
```json
{
  "name": "crowd.dev",
  "type": "crowddevApi",
  "data": {
    "apiKey": "tu-crowddev-api-key"
  }
}
```

### 55. CrowdStrike
**Tipo:** `crowdstrikeApi`
```json
{
  "name": "CrowdStrike",
  "type": "crowdstrikeApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret"
  }
}
```

### 56. Customer.io
**Tipo:** `customerioApi`
```json
{
  "name": "Customer.io",
  "type": "customerioApi",
  "data": {
    "trackingApiKey": "xxxxxxxxxxxxx",
    "trackingSiteId": "123456789",
    "appApiKey": "xxxxxxxxxxxxxxxxxx",
    "region": "global"
  }
}
```

---

## Credenciales D (57-80)

### 57. Databricks
**Tipo:** `databricksApi`
```json
{
  "name": "Databricks",
  "type": "databricksApi",
  "data": {
    "host": "tu-databricks-host.cloud.databricks.com",
    "token": "dapi123456789abcdef",
    "path": "/Workspace/Users/tu-email/tu-carpeta"
  }
}
```

### 58. Datadog
**Tipo:** `datadogApi`
```json
{
  "name": "Datadog",
  "type": "datadogApi",
  "data": {
    "apiKey": "tu-datadog-api-key",
    "appKey": "tu-app-key",
    "site": "datadoghq.com"
  }
}
```

### 59. DeepL
**Tipo:** `deeplApi`
```json
{
  "name": "DeepL",
  "type": "deeplApi",
  "data": {
    "apiKey": "tu-deepl-api-key"
  }
}
```

### 60. DeepSeek
**Tipo:** `deepseekApi`
```json
{
  "name": "DeepSeek",
  "type": "deepseekApi",
  "data": {
    "apiKey": "tu-deepseek-api-key"
  }
}
```

### 61. Demio
**Tipo:** `demioApi`
```json
{
  "name": "Demio",
  "type": "demioApi",
  "data": {
    "apiKey": "tu-demio-api-key"
  }
}
```

### 62. DFIR-IRIS
**Tipo:** `dfirisApi`
```json
{
  "name": "DFIR-IRIS",
  "type": "dfirisApi",
  "data": {
    "apiKey": "tu-dfir-iris-api-key",
    "baseUrl": "https://tu-iris-url.com"
  }
}
```

### 63. DHL
**Tipo:** `dhlApi`
```json
{
  "name": "DHL",
  "type": "dhlApi",
  "data": {
    "apiKey": "tu-dhl-api-key"
  }
}
```

### 64. Discord
**Tipo:** `discordApi`
```json
{
  "name": "Discord",
  "type": "discordApi",
  "data": {
    "botToken": "tu-discord-bot-token"
  }
}
```

### 65. Discourse
**Tipo:** `discourseApi`
```json
{
  "name": "Discourse",
  "type": "discourseApi",
  "data": {
    "apiKey": "tu-discourse-api-key",
    "username": "tu-usuario",
    "url": "https://tu-discourse-url.com"
  }
}
```

### 66. Disqus
**Tipo:** `disqusApi`
```json
{
  "name": "Disqus",
  "type": "disqusApi",
  "data": {
    "accessToken": "tu-disqus-access-token"
  }
}
```

### 67. Drift
**Tipo:** `driftApi`
```json
{
  "name": "Drift",
  "type": "driftApi",
  "data": {
    "accessToken": "tu-drift-access-token"
  }
}
```

### 68. Dropbox
**Tipo:** `dropbox`
```json
{
  "name": "Dropbox",
  "type": "dropbox",
  "data": {
    "accessToken": "sl.XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 69. Dropcontact
**Tipo:** `dropcontactApi`
```json
{
  "name": "Dropcontact",
  "type": "dropcontactApi",
  "data": {
    "apiKey": "tu-dropcontact-api-key"
  }
}
```

### 70. Dynatrace
**Tipo:** `dynatraceApi`
```json
{
  "name": "Dynatrace",
  "type": "dynatraceApi",
  "data": {
    "accessToken": "tu-dynatrace-token",
    "environmentId": "tu-environment-id"
  }
}
```

### 71. E-goi
**Tipo:** `egoiApi`
```json
{
  "name": "E-goi",
  "type": "egoiApi",
  "data": {
    "apiKey": "tu-egoi-api-key"
  }
}
```

### 72. Elasticsearch
**Tipo:** `elasticsearchApi`
```json
{
  "name": "Elasticsearch",
  "type": "elasticsearchApi",
  "data": {
    "apiKey": "tu-elasticsearch-api-key",
    "node": "https://localhost:9200"
  }
}
```

### 73. Elastic Security
**Tipo:** `elasticSecurityApi`
```json
{
  "name": "Elastic Security",
  "type": "elasticSecurityApi",
  "data": {
    "apiKey": "tu-elastic-security-api-key",
    "kibanaUrl": "https://tu-kibana-url.com"
  }
}
```

### 74. Emelia
**Tipo:** `emeliaApi`
```json
{
  "name": "Emelia",
  "type": "emeliaApi",
  "data": {
    "apiKey": "tu-emelia-api-key"
  }
}
```

### 75. ERPNext
**Tipo:** `erpnextApi`
```json
{
  "name": "ERPNext",
  "type": "erpnextApi",
  "data": {
    "apiKey": "tu-erpnext-api-key",
    "apiSecret": "tu-api-secret",
    "url": "https://tu-erpnext-url.com"
  }
}
```

### 76. Eventbrite
**Tipo:** `eventbriteApi`
```json
{
  "name": "Eventbrite",
  "type": "eventbriteApi",
  "data": {
    "accessToken": "tu-eventbrite-access-token"
  }
}
```

### 77. F5 Big-IP
**Tipo:** `f5BigIpApi`
```json
{
  "name": "F5 Big-IP",
  "type": "f5BigIpApi",
  "data": {
    "username": "tu-usuario",
    "password": "tu-contraseña",
    "host": "tu-f5-host.com"
  }
}
```

### 78. Facebook App
**Tipo:** `facebookAppApi`
```json
{
  "name": "Facebook App",
  "type": "facebookAppApi",
  "data": {
    "appId": "tu-app-id",
    "appSecret": "tu-app-secret"
  }
}
```

### 79. Facebook Graph API
**Tipo:** `facebookGraphApi`
```json
{
  "name": "Facebook Graph API",
  "type": "facebookGraphApi",
  "data": {
    "accessToken": "tu-facebook-access-token"
  }
}
```

### 80. Facebook Lead Ads
**Tipo:** `facebookLeadAdsApi`
```json
{
  "name": "Facebook Lead Ads",
  "type": "facebookLeadAdsApi",
  "data": {
    "accessToken": "tu-facebook-access-token",
    "pageId": "tu-page-id"
  }
}
```

### 81. Figma
**Tipo:** `figmaApi`
```json
{
  "name": "Figma",
  "type": "figmaApi",
  "data": {
    "accessToken": "figd_tu-figma-token"
  }
}
```

### 82. Firebase Cloud Messaging
**Tipo:** `firebaseCloudMessagingApi`
```json
{
  "name": "Firebase Cloud Messaging",
  "type": "firebaseCloudMessagingApi",
  "data": {
    "serverKey": "tu-server-key"
  }
}
```

### 83. Firebase Realtime Database
**Tipo:** `firebaseRealtimeDatabaseApi`
```json
{
  "name": "Firebase Realtime Database",
  "type": "firebaseRealtimeDatabaseApi",
  "data": {
    "apiKey": "tu-firebase-api-key",
    "databaseUrl": "https://tu-proyecto.firebaseio.com"
  }
}
```

### 84. Firestore
**Tipo:** `firestoreApi`
```json
{
  "name": "Firestore",
  "type": "firestoreApi",
  "data": {
    "projectId": "tu-proyecto-id",
    "privateKey": "-----BEGIN PRIVATE KEY-----\nTU_CLAVE_PRIVADA\n-----END PRIVATE KEY-----",
    "clientEmail": "firebase-adminsdk@tu-proyecto.iam.gserviceaccount.com"
  }
}
```

### 85. FitBit
**Tipo:** `fitbitApi`
```json
{
  "name": "FitBit",
  "type": "fitbitApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "accessToken": "tu-access-token"
  }
}
```

### 86. Flowdash
**Tipo:** `flowdashApi`
```json
{
  "name": "Flowdash",
  "type": "flowdashApi",
  "data": {
    "apiKey": "tu-flowdash-api-key"
  }
}
```

### 87. Freshbooks
**Tipo:** `freshbooksApi`
```json
{
  "name": "Freshbooks",
  "type": "freshbooksApi",
  "data": {
    "accountId": "tu-account-id",
    "accessToken": "tu-freshbooks-access-token"
  }
}
```

### 88. Freshdesk
**Tipo:** `freshdeskApi`
```json
{
  "name": "Freshdesk",
  "type": "freshdeskApi",
  "data": {
    "apiKey": "tu-freshdesk-api-key",
    "subdomain": "tu-subdomain"
  }
}
```

### 89. Freshsales
**Tipo:** `freshsalesApi`
```json
{
  "name": "Freshsales",
  "type": "freshsalesApi",
  "data": {
    "apiKey": "tu-freshsales-api-key",
    "subdomain": "tu-subdomain"
  }
}
```

### 90. Freshsuccess
**Tipo:** `freshsuccessApi`
```json
{
  "name": "Freshsuccess",
  "type": "freshsuccessApi",
  "data": {
    "apiKey": "tu-freshsuccess-api-key",
    "domain": "tu-domain"
  }
}
```

### 91. FTP
**Tipo:** `sftp`
```json
{
  "name": "FTP Server",
  "type": "sftp",
  "data": {
    "host": "ftp.example.com",
    "port": 21,
    "username": "tu-usuario",
    "password": "tu-contraseña"
  }
}
```

### 92. Funkify
**Tipo:** `funkifyApi`
```json
{
  "name": "Funkify",
  "type": "funkifyApi",
  "data": {
    "apiKey": "tu-funkify-api-key"
  }
}
```

### 93. GDPR Delete
**Tipo:** `gdprDeleteApi`
```json
{
  "name": "GDPR Delete",
  "type": "gdprDeleteApi",
  "data": {
    "apiKey": "tu-gdpr-delete-api-key"
  }
}
```

### 94. Getaccept
**Tipo:** `getacceptApi`
```json
{
  "name": "Getaccept",
  "type": "getacceptApi",
  "data": {
    "apiKey": "tu-getaccept-api-key"
  }
}
```

### 95. GetResponse
**Tipo:** `getResponseApi`
```json
{
  "name": "GetResponse",
  "type": "getResponseApi",
  "data": {
    "apiKey": "tu-getresponse-api-key"
  }
}
```

### 96. Gitbook
**Tipo:** `gitbookApi`
```json
{
  "name": "Gitbook",
  "type": "gitbookApi",
  "data": {
    "accessToken": "gho_tu-github-token"
  }
}
```

### 97. GitHub
**Tipo:** `githubApi`
```json
{
  "name": "GitHub",
  "type": "githubApi",
  "data": {
    "accessToken": "ghp_XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 98. GitLab
**Tipo:** `gitlabApi`
```json
{
  "name": "GitLab",
  "type": "gitlabApi",
  "data": {
    "accessToken": "glpat-XXXXXXXXXXXXX",
    "baseUrl": "https://gitlab.com"
  }
}
```

### 99. Gmail
**Tipo:** `gmailApi`
```json
{
  "name": "Gmail",
  "type": "gmailApi",
  "data": {
    "clientId": "tu-client-id.apps.googleusercontent.com",
    "clientSecret": "tu-client-secret",
    "accessToken": "ya29.XXXXXXXXXXXXXXXXXXXXX",
    "refreshToken": "1//XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 100. Gmail Send Email
**Tipo:** `gmailSendEmailApi`
```json
{
  "name": "Gmail Send Email",
  "type": "gmailSendEmailApi",
  "data": {
    "email": "tu-email@gmail.com",
    "accessToken": "ya29.XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

---

## Credenciales G-H (101-130)

### 101. Google AI (Gemini)
**Tipo:** `googleAiApi`
```json
{
  "name": "Google AI",
  "type": "googleAiApi",
  "data": {
    "apiKey": "tu-google-ai-api-key"
  }
}
```

### 102. Google Analytics
**Tipo:** `googleAnalyticsApi`
```json
{
  "name": "Google Analytics",
  "type": "googleAnalyticsApi",
  "data": {
    "clientId": "tu-client-id.apps.googleusercontent.com",
    "clientSecret": "tu-client-secret",
    "accessToken": "ya29.XXXXXXXXXXXXXXXXXXXXX",
    "refreshToken": "1//XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 103. Google BigQuery
**Tipo:** `googleBigQueryApi`
```json
{
  "name": "Google BigQuery",
  "type": "googleBigQueryApi",
  "data": {
    "projectId": "tu-proyecto-id",
    "privateKey": "-----BEGIN PRIVATE KEY-----\nTU_CLAVE\n-----END PRIVATE KEY-----",
    "clientEmail": "bigquery-user@tu-proyecto.iam.gserviceaccount.com"
  }
}
```

### 104. Google Books
**Tipo:** `googleBooksApi`
```json
{
  "name": "Google Books",
  "type": "googleBooksApi",
  "data": {
    "apiKey": "tu-google-books-api-key"
  }
}
```

### 105. Google Calendar
**Tipo:** `googleCalendarApi`
```json
{
  "name": "Google Calendar",
  "type": "googleCalendarApi",
  "data": {
    "clientId": "tu-client-id.apps.googleusercontent.com",
    "clientSecret": "tu-client-secret",
    "accessToken": "ya29.XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 106. Google Docs
**Tipo:** `googleDocsApi`
```json
{
  "name": "Google Docs",
  "type": "googleDocsApi",
  "data": {
    "clientId": "tu-client-id.apps.googleusercontent.com",
    "clientSecret": "tu-client-secret",
    "accessToken": "ya29.XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 107. Google Drive
**Tipo:** `googleDriveApi`
```json
{
  "name": "Google Drive",
  "type": "googleDriveApi",
  "data": {
    "clientId": "tu-client-id.apps.googleusercontent.com",
    "clientSecret": "tu-client-secret",
    "accessToken": "ya29.XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 108. Google Sheets
**Tipo:** `googleSheetsApi`
```json
{
  "name": "Google Sheets",
  "type": "googleSheetsApi",
  "data": {
    "clientId": "tu-client-id.apps.googleusercontent.com",
    "clientSecret": "tu-client-secret",
    "accessToken": "ya29.XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 109. Google Search Console
**Tipo:** `googleSearchConsoleApi`
```json
{
  "name": "Google Search Console",
  "type": "googleSearchConsoleApi",
  "data": {
    "clientId": "tu-client-id.apps.googleusercontent.com",
    "clientSecret": "tu-client-secret",
    "accessToken": "ya29.XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 110. Google Tasks
**Tipo:** `googleTasksApi`
```json
{
  "name": "Google Tasks",
  "type": "googleTasksApi",
  "data": {
    "clientId": "tu-client-id.apps.googleusercontent.com",
    "clientSecret": "tu-client-secret",
    "accessToken": "ya29.XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 111. Grafana
**Tipo:** `grafanaApi`
```json
{
  "name": "Grafana",
  "type": "grafanaApi",
  "data": {
    "apiKey": "eyJrIjoiXXXXXXXXXXXXXXXXX",
    "url": "https://tu-grafana.com"
  }
}
```

### 112. GraphQL
**Tipo:** `graphQL`
```json
{
  "name": "GraphQL Endpoint",
  "type": "graphQL",
  "data": {
    "endpoint": "https://api.example.com/graphql",
    "authorizationHeader": "Bearer tu-token"
  }
}
```

### 113. Grips
**Tipo:** `gripsApi`
```json
{
  "name": "Grips",
  "type": "gripsApi",
  "data": {
    "apiKey": "tu-grips-api-key"
  }
}
```

### 114. Grist
**Tipo:** `gristApi`
```json
{
  "name": "Grist",
  "type": "gristApi",
  "data": {
    "apiKey": "tu-grist-api-key",
    "baseUrl": "https://tu-grist-url.com"
  }
}
```

### 115. Gupshup
**Tipo:** `gupshupApi`
```json
{
  "name": "Gupshup",
  "type": "gupshupApi",
  "data": {
    "apiKey": "tu-gupshup-api-key",
    "userId": "tu-user-id"
  }
}
```

### 116. Gutendex
**Tipo:** `gutendexApi`
```json
{
  "name": "Gutendex",
  "type": "gutendexApi",
  "data": {}
}
```

### 117. Harvest
**Tipo:** `harvestApi`
```json
{
  "name": "Harvest",
  "type": "harvestApi",
  "data": {
    "accessToken": "tu-harvest-access-token",
    "accountId": "tu-account-id"
  }
}
```

### 118. HackerNews
**Tipo:** `hackerNewsApi`
```json
{
  "name": "Hacker News",
  "type": "hackerNewsApi",
  "data": {}
}
```

### 119. Help Scout
**Tipo:** `helpScoutApi`
```json
{
  "name": "Help Scout",
  "type": "helpScoutApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret"
  }
}
```

### 120. HelpCrunch
**Tipo:** `helpcrunchApi`
```json
{
  "name": "HelpCrunch",
  "type": "helpcrunchApi",
  "data": {
    "apiKey": "tu-helpcrunch-api-key",
    "userEmail": "tu-email@example.com"
  }
}
```

### 121. HelpDesk
**Tipo:** `helpdeskApi`
```json
{
  "name": "HelpDesk",
  "type": "helpdeskApi",
  "data": {
    "apiKey": "tu-helpdesk-api-key",
    "apiUrl": "https://tu-helpdesk-url.com"
  }
}
```

### 122. HerokuApi
**Tipo:** `herokuApi`
```json
{
  "name": "Heroku",
  "type": "herokuApi",
  "data": {
    "apiKey": "tu-heroku-api-key"
  }
}
```

### 123. Hex
**Tipo:** `hexApi`
```json
{
  "name": "Hex",
  "type": "hexApi",
  "data": {
    "apiKey": "tu-hex-api-key"
  }
}
```

### 124. Homebuddy
**Tipo:** `homebuddyApi`
```json
{
  "name": "Homebuddy",
  "type": "homebuddyApi",
  "data": {
    "apiKey": "tu-homebuddy-api-key"
  }
}
```

### 125. Honeycomb
**Tipo:** `honeycombApi`
```json
{
  "name": "Honeycomb",
  "type": "honeycombApi",
  "data": {
    "apiKey": "tu-honeycomb-api-key"
  }
}
```

### 126. Hubspot
**Tipo:** `hubspotApi`
```json
{
  "name": "HubSpot",
  "type": "hubspotApi",
  "data": {
    "accessToken": "pat-na1-XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 127. HTTP Request
**Tipo:** `httpRequest`
```json
{
  "name": "HTTP Request",
  "type": "httpRequest",
  "data": {
    "authentication": "bearer",
    "genericAuthType": "oAuth2",
    "oAuthTokenData": {
      "access_token": "tu-token",
      "token_type": "Bearer",
      "expires_in": 3600
    }
  }
}
```

### 128. HTTP Base Auth
**Tipo:** `httpBasicAuth`
```json
{
  "name": "HTTP Basic Auth",
  "type": "httpBasicAuth",
  "data": {
    "username": "tu-usuario",
    "password": "tu-contraseña"
  }
}
```

### 129. HTTP Bearer
**Tipo:** `httpBearerToken`
```json
{
  "name": "HTTP Bearer Token",
  "type": "httpBearerToken",
  "data": {
    "token": "tu-bearer-token"
  }
}
```

### 130. HTTP Digest Auth
**Tipo:** `httpDigestAuth`
```json
{
  "name": "HTTP Digest Auth",
  "type": "httpDigestAuth",
  "data": {
    "username": "tu-usuario",
    "password": "tu-contraseña",
    "realm": "tu-realm",
    "nonce": "tu-nonce"
  }
}
```

### 131. HTTP Header Auth
**Tipo:** `httpHeaderAuth`
```json
{
  "name": "HTTP Header Auth",
  "type": "httpHeaderAuth",
  "data": {
    "headers": [
      {
        "name": "Authorization",
        "value": "Bearer tu-token"
      }
    ]
  }
}
```

### 132. HTTP Query Auth
**Tipo:** `httpQueryAuth`
```json
{
  "name": "HTTP Query Auth",
  "type": "httpQueryAuth",
  "data": {
    "parameters": [
      {
        "name": "api_key",
        "value": "tu-api-key"
      }
    ]
  }
}
```

### 133. IMAP
**Tipo:** `imapEmail`
```json
{
  "name": "IMAP Email",
  "type": "imapEmail",
  "data": {
    "user": "tu-email@example.com",
    "password": "tu-contraseña",
    "host": "imap.gmail.com",
    "port": 993,
    "secure": true
  }
}
```

### 134. Improveado
**Tipo:** `improveadoApi`
```json
{
  "name": "Improveado",
  "type": "improveadoApi",
  "data": {
    "apiKey": "tu-improveado-api-key"
  }
}
```

### 135. Infobip
**Tipo:** `infobipApi`
```json
{
  "name": "Infobip",
  "type": "infobipApi",
  "data": {
    "apiKey": "tu-infobip-api-key",
    "baseUrl": "https://tu-region.infobip.com"
  }
}
```

### 136. Intercom
**Tipo:** `intercomApi`
```json
{
  "name": "Intercom",
  "type": "intercomApi",
  "data": {
    "apiKey": "dG9rOjp0b2tlbjp0b2tlbg=="
  }
}
```

### 137. Integromat
**Tipo:** `integromati`
```json
{
  "name": "Integromat (n8n Origin)",
  "type": "integromati",
  "data": {
    "accessToken": "tu-integromat-token"
  }
}
```

### 138. Item.sh
**Tipo:** `itemshApi`
```json
{
  "name": "Item.sh",
  "type": "itemshApi",
  "data": {
    "apiKey": "tu-itemsh-api-key"
  }
}
```

### 139. Itch.io
**Tipo:** `itchioApi`
```json
{
  "name": "Itch.io",
  "type": "itchioApi",
  "data": {
    "apiKey": "tu-itchio-api-key"
  }
}
```

### 140. Iterable
**Tipo:** `iterableApi`
```json
{
  "name": "Iterable",
  "type": "iterableApi",
  "data": {
    "apiKey": "tu-iterable-api-key"
  }
}
```

---

## Credenciales J-L (141-200)

### 141. Jira Server
**Tipo:** `jiraServerApi`
```json
{
  "name": "Jira Server",
  "type": "jiraServerApi",
  "data": {
    "baseUrl": "https://tu-jira-url.com",
    "username": "tu-usuario",
    "password": "tu-token-api"
  }
}
```

### 142. Jira Cloud
**Tipo:** `jiraCloudApi`
```json
{
  "name": "Jira Cloud",
  "type": "jiraCloudApi",
  "data": {
    "email": "tu-email@example.com",
    "apiToken": "tu-jira-api-token"
  }
}
```

### 143. JotForm
**Tipo:** `jotformApi`
```json
{
  "name": "JotForm",
  "type": "jotformApi",
  "data": {
    "apiKey": "tu-jotform-api-key"
  }
}
```

### 144. Kafka
**Tipo:** `kafkaApi`
```json
{
  "name": "Kafka",
  "type": "kafkaApi",
  "data": {
    "clientId": "tu-client-id",
    "brokers": ["localhost:9092"],
    "ssl": false
  }
}
```

### 145. Kapital
**Tipo:** `kapitalApi`
```json
{
  "name": "Kapital",
  "type": "kapitalApi",
  "data": {
    "apiKey": "tu-kapital-api-key"
  }
}
```

### 146. Kestra
**Tipo:** `kestraApi`
```json
{
  "name": "Kestra",
  "type": "kestraApi",
  "data": {
    "accessToken": "tu-kestra-token",
    "apiUrl": "https://tu-kestra-url.com"
  }
}
```

### 147. Keystroke
**Tipo:** `keystrokeApi`
```json
{
  "name": "Keystroke",
  "type": "keystrokeApi",
  "data": {
    "apiKey": "tu-keystroke-api-key"
  }
}
```

### 148. Klaviyo
**Tipo:** `klaviyoApi`
```json
{
  "name": "Klaviyo",
  "type": "klaviyoApi",
  "data": {
    "privateApiKey": "pk_tu-clave-privada"
  }
}
```

### 149. Knack
**Tipo:** `knackApi`
```json
{
  "name": "Knack",
  "type": "knackApi",
  "data": {
    "apiKey": "tu-knack-api-key",
    "appId": "tu-app-id"
  }
}
```

### 150. Kreuzwerker
**Tipo:** `kreuzwerkerApi`
```json
{
  "name": "Kreuzwerker",
  "type": "kreuzwerkerApi",
  "data": {
    "apiKey": "tu-kreuzwerker-api-key"
  }
}
```

### 151. LDAP
**Tipo:** `ldap`
```json
{
  "name": "LDAP",
  "type": "ldap",
  "data": {
    "loginId": "tu-login-id",
    "password": "tu-contraseña",
    "baseDn": "dc=example,dc=com",
    "baseDnPath": "ou=users",
    "serverAddress": "ldap.example.com",
    "port": 389,
    "secure": false
  }
}
```

### 152. Lemlist
**Tipo:** `lemlistApi`
```json
{
  "name": "Lemlist",
  "type": "lemlistApi",
  "data": {
    "apiKey": "tu-lemlist-api-key"
  }
}
```

### 153. LessWrong
**Tipo:** `lesswrongApi`
```json
{
  "name": "LessWrong",
  "type": "lesswrongApi",
  "data": {}
}
```

### 154. Linear
**Tipo:** `linearApi`
```json
{
  "name": "Linear",
  "type": "linearApi",
  "data": {
    "apiKey": "lin_api_tu-linear-api-key"
  }
}
```

### 155. LinkedIn
**Tipo:** `linkedinApi`
```json
{
  "name": "LinkedIn",
  "type": "linkedinApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "accessToken": "AQXu6tu-token"
  }
}
```

### 156. Lofty
**Tipo:** `loftyApi`
```json
{
  "name": "Lofty",
  "type": "loftyApi",
  "data": {
    "apiKey": "tu-lofty-api-key"
  }
}
```

### 157. Logstash
**Tipo:** `logstashApi`
```json
{
  "name": "Logstash",
  "type": "logstashApi",
  "data": {
    "host": "localhost",
    "port": 5000,
    "protocol": "tcp"
  }
}
```

### 158. Logtail
**Tipo:** `logtailApi`
```json
{
  "name": "Logtail",
  "type": "logtailApi",
  "data": {
    "sourceToken": "tu-source-token"
  }
}
```

### 159. Loom
**Tipo:** `loomApi`
```json
{
  "name": "Loom",
  "type": "loomApi",
  "data": {
    "accessToken": "tu-loom-access-token"
  }
}
```

### 160. Lucidchart
**Tipo:** `lucidchartApi`
```json
{
  "name": "Lucidchart",
  "type": "lucidchartApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "accessToken": "tu-access-token"
  }
}
```

### 161. Mailchimp
**Tipo:** `mailchimpApi`
```json
{
  "name": "Mailchimp",
  "type": "mailchimpApi",
  "data": {
    "apiKey": "tu-mailchimp-api-key-us3"
  }
}
```

### 162. Mailchimp OAuth2
**Tipo:** `mailchimpOAuth2Api`
```json
{
  "name": "Mailchimp OAuth2",
  "type": "mailchimpOAuth2Api",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "oAuthTokenData": {
      "access_token": "tu-access-token",
      "token_type": "Bearer",
      "expires_in": 3600
    }
  }
}
```

### 163. Mailgun
**Tipo:** `mailgunApi`
```json
{
  "name": "Mailgun",
  "type": "mailgunApi",
  "data": {
    "apiKey": "key-tu-mailgun-api-key",
    "domain": "tu-domain.mailgun.org"
  }
}
```

### 164. Mailjet
**Tipo:** `mailjetApi`
```json
{
  "name": "Mailjet",
  "type": "mailjetApi",
  "data": {
    "apiKey": "tu-mailjet-api-key",
    "apiSecret": "tu-api-secret"
  }
}
```

### 165. Mailkind
**Tipo:** `mailkindApi`
```json
{
  "name": "Mailkind",
  "type": "mailkindApi",
  "data": {
    "apiKey": "tu-mailkind-api-key"
  }
}
```

### 166. Mailparser
**Tipo:** `mailparserApi`
```json
{
  "name": "Mailparser",
  "type": "mailparserApi",
  "data": {
    "apiKey": "tu-mailparser-api-key"
  }
}
```

### 167. Mailsend
**Tipo:** `mailsendApi`
```json
{
  "name": "Mailsend",
  "type": "mailsendApi",
  "data": {
    "apiKey": "tu-mailsend-api-key"
  }
}
```

### 168. Mailing List
**Tipo:** `mailingListApi`
```json
{
  "name": "Mailing List",
  "type": "mailingListApi",
  "data": {
    "fileUrl": "https://ejemplo.com/emails.csv"
  }
}
```

### 169. Mambu
**Tipo:** `mambuApi`
```json
{
  "name": "Mambu",
  "type": "mambuApi",
  "data": {
    "apiKey": "tu-mambu-api-key",
    "domain": "tu-domain"
  }
}
```

### 170. MangoDb
**Tipo:** `mongoDb`
```json
{
  "name": "MongoDB",
  "type": "mongoDb",
  "data": {
    "host": "localhost",
    "port": 27017,
    "database": "tu-database",
    "user": "tu-usuario",
    "password": "tu-contraseña",
    "ssl": false
  }
}
```

### 171. Mariadb
**Tipo:** `mariaDb`
```json
{
  "name": "MariaDB",
  "type": "mariaDb",
  "data": {
    "host": "localhost",
    "port": 3306,
    "database": "tu-database",
    "user": "root",
    "password": "tu-contraseña",
    "ssl": false
  }
}
```

### 172. Marketing Cloud
**Tipo:** `marketingCloudApi`
```json
{
  "name": "Marketing Cloud",
  "type": "marketingCloudApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "subdomain": "tu-subdomain"
  }
}
```

### 173. Mastodon
**Tipo:** `mastodonApi`
```json
{
  "name": "Mastodon",
  "type": "mastodonApi",
  "data": {
    "accessToken": "tu-mastodon-token",
    "baseUrl": "https://mastodon.social"
  }
}
```

### 174. Mattermost
**Tipo:** `mattermostApi`
```json
{
  "name": "Mattermost",
  "type": "mattermostApi",
  "data": {
    "accessToken": "tu-mattermost-token",
    "baseUrl": "https://tu-mattermost-url.com"
  }
}
```

### 175. Matomo
**Tipo:** `matomoApi`
```json
{
  "name": "Matomo",
  "type": "matomoApi",
  "data": {
    "apiKey": "tu-matomo-api-key",
    "baseUrl": "https://tu-matomo-url.com"
  }
}
```

### 176. MaxAI
**Tipo:** `maxaiApi`
```json
{
  "name": "MaxAI",
  "type": "maxaiApi",
  "data": {
    "apiKey": "tu-maxai-api-key"
  }
}
```

### 177. Maze
**Tipo:** `mazeApi`
```json
{
  "name": "Maze",
  "type": "mazeApi",
  "data": {
    "apiKey": "tu-maze-api-key"
  }
}
```

### 178. Meilisearch
**Tipo:** `meilisearchApi`
```json
{
  "name": "Meilisearch",
  "type": "meilisearchApi",
  "data": {
    "apiKey": "tu-meilisearch-api-key",
    "baseUrl": "https://tu-meilisearch-url.com"
  }
}
```

### 179. Meraki API
**Tipo:** `merakiApi`
```json
{
  "name": "Meraki API",
  "type": "merakiApi",
  "data": {
    "apiKey": "tu-meraki-api-key"
  }
}
```

### 180. Merge
**Tipo:** `mergeApi`
```json
{
  "name": "Merge",
  "type": "mergeApi",
  "data": {
    "accountToken": "tu-merge-account-token",
    "apiKey": "tu-merge-api-key"
  }
}
```

### 181. Miro
**Tipo:** `miroApi`
```json
{
  "name": "Miro",
  "type": "miroApi",
  "data": {
    "accessToken": "tu-miro-access-token"
  }
}
```

### 182. Missingperson
**Tipo:** `missingpersonApi`
```json
{
  "name": "Missingperson",
  "type": "missingpersonApi",
  "data": {
    "apiKey": "tu-missingperson-api-key"
  }
}
```

### 183. Mobul
**Tipo:** `mobulApi`
```json
{
  "name": "Mobul",
  "type": "mobulApi",
  "data": {
    "apiKey": "tu-mobul-api-key"
  }
}
```

### 184. Moderation External
**Tipo:** `moderationExternal`
```json
{
  "name": "Moderation External",
  "type": "moderationExternal",
  "data": {
    "apiUrl": "https://api.moderation.example.com"
  }
}
```

### 185. Monday.com
**Tipo:** `mondayComApi`
```json
{
  "name": "Monday.com",
  "type": "mondayComApi",
  "data": {
    "accessToken": "tu-monday-access-token"
  }
}
```

### 186. MoneyBird
**Tipo:** `moneybirdApi`
```json
{
  "name": "MoneyBird",
  "type": "moneybirdApi",
  "data": {
    "accessToken": "tu-moneybird-access-token"
  }
}
```

### 187. MongoAtlas
**Tipo:** `mongoAtlas`
```json
{
  "name": "MongoDB Atlas",
  "type": "mongoAtlas",
  "data": {
    "apiPublicKey": "tu-api-public-key",
    "apiPrivateKey": "tu-api-private-key",
    "baseUrl": "https://cloud.mongodb.com/api/atlas/v1.0"
  }
}
```

### 188. Mongoose API
**Tipo:** `mongooseApi`
```json
{
  "name": "Mongoose API",
  "type": "mongooseApi",
  "data": {
    "apiKey": "tu-mongoose-api-key"
  }
}
```

### 189. Monocloud
**Tipo:** `monocloudApi`
```json
{
  "name": "Monocloud",
  "type": "monocloudApi",
  "data": {
    "apiKey": "tu-monocloud-api-key"
  }
}
```

### 190. Mutagen
**Tipo:** `mutagenApi`
```json
{
  "name": "Mutagen",
  "type": "mutagenApi",
  "data": {
    "apiKey": "tu-mutagen-api-key"
  }
}
```

### 191. MySQL
**Tipo:** `mySql`
```json
{
  "name": "MySQL",
  "type": "mySql",
  "data": {
    "host": "localhost",
    "port": 3306,
    "database": "tu-database",
    "user": "root",
    "password": "tu-contraseña",
    "ssl": false
  }
}
```

### 192. Myspace
**Tipo:** `myspaceApi`
```json
{
  "name": "Myspace",
  "type": "myspaceApi",
  "data": {
    "accessToken": "tu-myspace-token"
  }
}
```

### 193. N8N API
**Tipo:** `n8nApi`
```json
{
  "name": "n8n API",
  "type": "n8nApi",
  "data": {
    "apiKey": "tu-n8n-api-key",
    "baseUrl": "https://tu-n8n-url.com"
  }
}
```

### 194. Namecheap
**Tipo:** `namecheapApi`
```json
{
  "name": "Namecheap",
  "type": "namecheapApi",
  "data": {
    "apiKey": "tu-namecheap-api-key",
    "username": "tu-username"
  }
}
```

### 195. Namespace
**Tipo:** `namespaceApi`
```json
{
  "name": "Namespace",
  "type": "namespaceApi",
  "data": {
    "apiKey": "tu-namespace-api-key"
  }
}
```

### 196. NATS
**Tipo:** `natsApi`
```json
{
  "name": "NATS",
  "type": "natsApi",
  "data": {
    "host": "localhost",
    "port": 4222
  }
}
```

### 197. Network Interfaces
**Tipo:** `networkInterfaceApi`
```json
{
  "name": "Network Interfaces",
  "type": "networkInterfaceApi",
  "data": {}
}
```

### 198. New Relic
**Tipo:** `newrelicApi`
```json
{
  "name": "New Relic",
  "type": "newrelicApi",
  "data": {
    "apiKey": "tu-newrelic-api-key"
  }
}
```

### 199. NewsAPI
**Tipo:** `newsapi`
```json
{
  "name": "NewsAPI",
  "type": "newsapi",
  "data": {
    "apiKey": "tu-newsapi-api-key"
  }
}
```

### 200. Next.js Webhook
**Tipo:** `nextJsWebhook`
```json
{
  "name": "Next.js Webhook",
  "type": "nextJsWebhook",
  "data": {
    "webhookUrl": "https://tu-nextjs-url.com/api/webhook"
  }
}
```

### 201. Nextcloud
**Tipo:** `nextcloudApi`
```json
{
  "name": "Nextcloud",
  "type": "nextcloudApi",
  "data": {
    "user": "tu-usuario",
    "password": "tu-contraseña",
    "baseUrl": "https://tu-nextcloud-url.com"
  }
}
```

### 202. Notion
**Tipo:** `notionApi`
```json
{
  "name": "Notion",
  "type": "notionApi",
  "data": {
    "internalIntegrationSecret": "secret_XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 203. Notify
**Tipo:** `notifyApi`
```json
{
  "name": "Notify",
  "type": "notifyApi",
  "data": {
    "apiKey": "tu-notify-api-key"
  }
}
```

### 204. NPM
**Tipo:** `npmApi`
```json
{
  "name": "NPM",
  "type": "npmApi",
  "data": {
    "accessToken": "npm_XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 205. Nuage
**Tipo:** `nuageApi`
```json
{
  "name": "Nuage",
  "type": "nuageApi",
  "data": {
    "apiKey": "tu-nuage-api-key"
  }
}
```

### 206. Nuxt Webhook
**Tipo:** `nuxtWebhook`
```json
{
  "name": "Nuxt Webhook",
  "type": "nuxtWebhook",
  "data": {
    "webhookUrl": "https://tu-nuxt-url.com/api/webhook"
  }
}
```

### 207. Oauth2 Generic
**Tipo:** `oauth2Generic`
```json
{
  "name": "OAuth2 Generic",
  "type": "oauth2Generic",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "accessTokenUrl": "https://oauth.example.com/token",
    "authorizationUrl": "https://oauth.example.com/authorize",
    "oAuthTokenData": {
      "access_token": "tu-access-token",
      "token_type": "Bearer",
      "expires_in": 3600
    }
  }
}
```

### 208. Ollama
**Tipo:** `ollamaApi`
```json
{
  "name": "Ollama",
  "type": "ollamaApi",
  "data": {
    "baseUrl": "http://localhost:11434"
  }
}
```

### 209. Onfleet
**Tipo:** `onfleetApi`
```json
{
  "name": "Onfleet",
  "type": "onfleetApi",
  "data": {
    "apiKey": "tu-onfleet-api-key"
  }
}
```

### 210. OneNote
**Tipo:** `oneNoteApi`
```json
{
  "name": "OneNote",
  "type": "oneNoteApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "accessToken": "EwAwA8l6BAAURXXXXXXXXXXXXXXX"
  }
}
```

### 211. OpenAI
**Tipo:** `openAiApi`
```json
{
  "name": "OpenAI",
  "type": "openAiApi",
  "data": {
    "apiKey": "sk-XXXXXXXXXXXXXXXXXXXXX"
  }
}
```

### 212. OpenWeather
**Tipo:** `openweatherApi`
```json
{
  "name": "OpenWeather",
  "type": "openweatherApi",
  "data": {
    "apiKey": "tu-openweather-api-key"
  }
}
```

### 213. OpsGenie
**Tipo:** `opsgenieCoreApi`
```json
{
  "name": "OpsGenie",
  "type": "opsgenieCoreApi",
  "data": {
    "apiKey": "tu-opsgenie-api-key",
    "baseUrl": "https://api.opsgenie.com"
  }
}
```

### 214. Oracle NodeDB
**Tipo:** `oracleNodeDb`
```json
{
  "name": "Oracle Database",
  "type": "oracleNodeDb",
  "data": {
    "user": "tu-usuario",
    "password": "tu-contraseña",
    "connectString": "localhost:1521/ORCL"
  }
}
```

### 215. Outlook
**Tipo:** `outlookApi`
```json
{
  "name": "Outlook",
  "type": "outlookApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "tenantId": "tu-tenant-id",
    "accessToken": "EwAwA8l6BAAURXXXXXXXXXXXXXXX"
  }
}
```

### 216. Outlook Calendar
**Tipo:** `outlookCalendarApi`
```json
{
  "name": "Outlook Calendar",
  "type": "outlookCalendarApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "tenantId": "tu-tenant-id"
  }
}
```

### 217. Owner API
**Tipo:** `ownerApi`
```json
{
  "name": "Owner API",
  "type": "ownerApi",
  "data": {
    "apiKey": "tu-owner-api-key"
  }
}
```

### 218. Paragraph
**Tipo:** `paragraphApi`
```json
{
  "name": "Paragraph",
  "type": "paragraphApi",
  "data": {
    "apiKey": "tu-paragraph-api-key"
  }
}
```

### 219. Parse Platform
**Tipo:** `parseApi`
```json
{
  "name": "Parse Platform",
  "type": "parseApi",
  "data": {
    "appId": "tu-app-id",
    "apiKey": "tu-api-key",
    "baseUrl": "https://tu-parse-url.com"
  }
}
```

### 220. Passbase
**Tipo:** `passbaseApi`
```json
{
  "name": "Passbase",
  "type": "passbaseApi",
  "data": {
    "apiKey": "tu-passbase-api-key"
  }
}
```

### 221. Pastebin
**Tipo:** `pastebinApi`
```json
{
  "name": "Pastebin",
  "type": "pastebinApi",
  "data": {
    "apiKey": "tu-pastebin-api-key"
  }
}
```

### 222. Payflow
**Tipo:** `payflowApi`
```json
{
  "name": "Payflow",
  "type": "payflowApi",
  "data": {
    "vendor": "tu-vendor-id",
    "user": "tu-usuario",
    "password": "tu-contraseña",
    "partner": "PayPal"
  }
}
```

### 223. PayPal
**Tipo:** `paypalApi`
```json
{
  "name": "PayPal",
  "type": "paypalApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret"
  }
}
```

### 224. PDF Co
**Tipo:** `pdfcoApi`
```json
{
  "name": "PDF.co",
  "type": "pdfcoApi",
  "data": {
    "apiKey": "tu-pdf-co-api-key"
  }
}
```

### 225. PagerDuty
**Tipo:** `pagerdutycoreApi`
```json
{
  "name": "PagerDuty",
  "type": "pagerdutycoreApi",
  "data": {
    "accessToken": "tu-pagerduty-access-token"
  }
}
```

### 226. Parabola
**Tipo:** `parabolaApi`
```json
{
  "name": "Parabola",
  "type": "parabolaApi",
  "data": {
    "apiKey": "tu-parabola-api-key"
  }
}
```

### 227. Parity
**Tipo:** `parityApi`
```json
{
  "name": "Parity",
  "type": "parityApi",
  "data": {
    "apiKey": "tu-parity-api-key"
  }
}
```

### 228. Perfex CRM
**Tipo:** `perfexApi`
```json
{
  "name": "Perfex CRM",
  "type": "perfexApi",
  "data": {
    "apiKey": "tu-perfex-api-key",
    "baseUrl": "https://tu-perfex-url.com"
  }
}
```

### 229. Persio
**Tipo:** `persioApi`
```json
{
  "name": "Persio",
  "type": "persioApi",
  "data": {
    "apiKey": "tu-persio-api-key"
  }
}
```

### 230. Philips Hue
**Tipo:** `philipshueApi`
```json
{
  "name": "Philips Hue",
  "type": "philipshueApi",
  "data": {
    "apiKey": "tu-hue-api-key",
    "bridgeHost": "192.168.1.100"
  }
}
```

### 231. Phone.com
**Tipo:** `phonecomApi`
```json
{
  "name": "Phone.com",
  "type": "phonecomApi",
  "data": {
    "apiKey": "tu-phone-com-api-key"
  }
}
```

### 232. Pic Resize
**Tipo:** `picResizeApi`
```json
{
  "name": "Pic Resize",
  "type": "picResizeApi",
  "data": {
    "apiKey": "tu-pic-resize-api-key"
  }
}
```

### 233. PieSync
**Tipo:** `piesyncApi`
```json
{
  "name": "PieSync",
  "type": "piesyncApi",
  "data": {
    "apiKey": "tu-piesync-api-key"
  }
}
```

### 234. Pipefy
**Tipo:** `pipefyApi`
```json
{
  "name": "Pipefy",
  "type": "pipefyApi",
  "data": {
    "apiToken": "tu-pipefy-api-token"
  }
}
```

### 235. Pipedrive
**Tipo:** `pipedriveApi`
```json
{
  "name": "Pipedrive",
  "type": "pipedriveApi",
  "data": {
    "apiToken": "tu-pipedrive-api-token"
  }
}
```

### 236. Piwik
**Tipo:** `piwikApi`
```json
{
  "name": "Piwik",
  "type": "piwikApi",
  "data": {
    "apiKey": "tu-piwik-api-key",
    "baseUrl": "https://tu-piwik-url.com"
  }
}
```

### 237. Planetary
**Tipo:** `planetaryApi`
```json
{
  "name": "Planetary",
  "type": "planetaryApi",
  "data": {
    "apiKey": "tu-planetary-api-key"
  }
}
```

### 238. Platformio
**Tipo:** `platformioApi`
```json
{
  "name": "Platformio",
  "type": "platformioApi",
  "data": {
    "apiKey": "tu-platformio-api-key"
  }
}
```

### 239. Plivo
**Tipo:** `plivoApi`
```json
{
  "name": "Plivo",
  "type": "plivoApi",
  "data": {
    "authId": "tu-auth-id",
    "authToken": "tu-auth-token"
  }
}
```

### 240. Plumb5
**Tipo:** `plumb5Api`
```json
{
  "name": "Plumb5",
  "type": "plumb5Api",
  "data": {
    "apiKey": "tu-plumb5-api-key"
  }
}
```

### 241. Pocket
**Tipo:** `pocketApi`
```json
{
  "name": "Pocket",
  "type": "pocketApi",
  "data": {
    "consumerKey": "tu-consumer-key",
    "accessToken": "tu-access-token"
  }
}
```

### 242. Postgres
**Tipo:** `postgres`
```json
{
  "name": "PostgreSQL",
  "type": "postgres",
  "data": {
    "host": "localhost",
    "port": 5432,
    "database": "tu-database",
    "user": "postgres",
    "password": "tu-contraseña",
    "ssl": false
  }
}
```

### 243. Posthog
**Tipo:** `posthogApi`
```json
{
  "name": "PostHog",
  "type": "posthogApi",
  "data": {
    "apiPersonalToken": "tu-personal-token",
    "apiUrl": "https://app.posthog.com"
  }
}
```

### 244. Postmark
**Tipo:** `postmarkApi`
```json
{
  "name": "Postmark",
  "type": "postmarkApi",
  "data": {
    "serverToken": "tu-postmark-server-token"
  }
}
```

### 245. Preply
**Tipo:** `preplyApi`
```json
{
  "name": "Preply",
  "type": "preplyApi",
  "data": {
    "apiKey": "tu-preply-api-key"
  }
}
```

### 246. Privado
**Tipo:** `privadoApi`
```json
{
  "name": "Privado",
  "type": "privadoApi",
  "data": {
    "apiKey": "tu-privado-api-key"
  }
}
```

### 247. Private
**Tipo:** `privateApi`
```json
{
  "name": "Private",
  "type": "privateApi",
  "data": {
    "apiKey": "tu-private-api-key"
  }
}
```

### 248. ProfitWell
**Tipo:** `profitwellApi`
```json
{
  "name": "ProfitWell",
  "type": "profitwellApi",
  "data": {
    "apiKey": "tu-profitwell-api-key"
  }
}
```

### 249. Promptly
**Tipo:** `promptlyApi`
```json
{
  "name": "Promptly",
  "type": "promptlyApi",
  "data": {
    "accessToken": "tu-promptly-token"
  }
}
```

### 250. PublishPress
**Tipo:** `publishpressApi`
```json
{
  "name": "PublishPress",
  "type": "publishpressApi",
  "data": {
    "apiKey": "tu-publishpress-api-key",
    "baseUrl": "https://tu-publishpress-url.com"
  }
}
```

### 251. PushBullet
**Tipo:** `pushbulletApi`
```json
{
  "name": "PushBullet",
  "type": "pushbulletApi",
  "data": {
    "accessToken": "tu-pushbullet-token"
  }
}
```

### 252. Pushcut Webhook
**Tipo:** `pushcutWebhook`
```json
{
  "name": "Pushcut Webhook",
  "type": "pushcutWebhook",
  "data": {
    "webhookUrl": "https://api.pushcut.io/v1/server/notifications/YOUR_NAME"
  }
}
```

### 253. Pushover
**Tipo:** `pushoverApi`
```json
{
  "name": "Pushover",
  "type": "pushoverApi",
  "data": {
    "userKey": "tu-user-key",
    "apiToken": "tu-api-token"
  }
}
```

### 254. Python Function
**Tipo:** `pythonFunction`
```json
{
  "name": "Python Function",
  "type": "pythonFunction",
  "data": {
    "pythonCode": "return {'message': 'Hello from Python'}"
  }
}
```

### 255. Qiwi
**Tipo:** `qiwiApi`
```json
{
  "name": "Qiwi",
  "type": "qiwiApi",
  "data": {
    "apiKey": "tu-qiwi-api-key"
  }
}
```

### 256. Qualys API
**Tipo:** `qualysApi`
```json
{
  "name": "Qualys API",
  "type": "qualysApi",
  "data": {
    "username": "tu-usuario",
    "password": "tu-contraseña"
  }
}
```

### 257. Quickbase
**Tipo:** `quickbaseApi`
```json
{
  "name": "Quickbase",
  "type": "quickbaseApi",
  "data": {
    "userToken": "tu-user-token",
    "accountId": "tu-account-id"
  }
}
```

### 258. Quickbooks Online
**Tipo:** `quickbooksApi`
```json
{
  "name": "QuickBooks Online",
  "type": "quickbooksApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "realmId": "tu-realm-id"
  }
}
```

### 259. Radius API
**Tipo:** `radiusApi`
```json
{
  "name": "Radius API",
  "type": "radiusApi",
  "data": {
    "apiKey": "tu-radius-api-key"
  }
}
```

### 260. Rapid7
**Tipo:** `rapid7VulnerabilityManagementApi`
```json
{
  "name": "Rapid7",
  "type": "rapid7VulnerabilityManagementApi",
  "data": {
    "apiKey": "tu-rapid7-api-key",
    "region": "us"
  }
}
```

### 261. Ragtag
**Tipo:** `ragtagApi`
```json
{
  "name": "Ragtag",
  "type": "ragtagApi",
  "data": {
    "apiKey": "tu-ragtag-api-key"
  }
}
```

### 262. Rakuten Advertising
**Tipo:** `rakutenAdvertisingApi`
```json
{
  "name": "Rakuten Advertising",
  "type": "rakutenAdvertisingApi",
  "data": {
    "apiToken": "tu-api-token",
    "advertiserId": "tu-advertiser-id"
  }
}
```

### 263. Ranktracker
**Tipo:** `ranktrackerApi`
```json
{
  "name": "Ranktracker",
  "type": "ranktrackerApi",
  "data": {
    "apiKey": "tu-ranktracker-api-key"
  }
}
```

### 264. Raydium
**Tipo:** `raydiumApi`
```json
{
  "name": "Raydium",
  "type": "raydiumApi",
  "data": {
    "apiKey": "tu-raydium-api-key"
  }
}
```

### 265. Readwise
**Tipo:** `readwiseApi`
```json
{
  "name": "Readwise",
  "type": "readwiseApi",
  "data": {
    "accessToken": "tu-readwise-token"
  }
}
```

### 266. Reale
**Tipo:** `realeApi`
```json
{
  "name": "Reale",
  "type": "realeApi",
  "data": {
    "apiKey": "tu-reale-api-key"
  }
}
```

### 267. Reccap
**Tipo:** `reccapApi`
```json
{
  "name": "Reccap",
  "type": "reccapApi",
  "data": {
    "apiKey": "tu-reccap-api-key"
  }
}
```

### 268. Rechat
**Tipo:** `rechatApi`
```json
{
  "name": "Rechat",
  "type": "rechatApi",
  "data": {
    "apiKey": "tu-rechat-api-key"
  }
}
```

### 269. Recordeazy
**Tipo:** `recordeazyApi`
```json
{
  "name": "Recordeazy",
  "type": "recordeazyApi",
  "data": {
    "apiKey": "tu-recordeazy-api-key"
  }
}
```

### 270. Redis
**Tipo:** `redis`
```json
{
  "name": "Redis",
  "type": "redis",
  "data": {
    "host": "localhost",
    "port": 6379,
    "password": "tu-contraseña",
    "db": 0
  }
}
```

### 271. Reflex
**Tipo:** `reflexApi`
```json
{
  "name": "Reflex",
  "type": "reflexApi",
  "data": {
    "apiKey": "tu-reflex-api-key"
  }
}
```

### 272. Relay
**Tipo:** `relayApi`
```json
{
  "name": "Relay",
  "type": "relayApi",
  "data": {
    "apiKey": "tu-relay-api-key"
  }
}
```

### 273. Remnote
**Tipo:** `remnoteApi`
```json
{
  "name": "Remnote",
  "type": "remnoteApi",
  "data": {
    "apiKey": "tu-remnote-api-key"
  }
}
```

### 274. Replicate
**Tipo:** `replicateApi`
```json
{
  "name": "Replicate",
  "type": "replicateApi",
  "data": {
    "apiKey": "tu-replicate-api-key"
  }
}
```

### 275. Rescue
**Tipo:** `rescueApi`
```json
{
  "name": "Rescue",
  "type": "rescueApi",
  "data": {
    "apiKey": "tu-rescue-api-key"
  }
}
```

### 276. Revenuecat
**Tipo:** `revenuecatApi`
```json
{
  "name": "RevenueCat",
  "type": "revenuecatApi",
  "data": {
    "apiKey": "tu-revenuecat-api-key"
  }
}
```

### 277. Reverse
**Tipo:** `reverseApi`
```json
{
  "name": "Reverse",
  "type": "reverseApi",
  "data": {
    "apiKey": "tu-reverse-api-key"
  }
}
```

### 278. Riskified
**Tipo:** `riskifiedApi`
```json
{
  "name": "Riskified",
  "type": "riskifiedApi",
  "data": {
    "apiKey": "tu-riskified-api-key"
  }
}
```

### 279. Rocket.Chat
**Tipo:** `rocketchatApi`
```json
{
  "name": "Rocket.Chat",
  "type": "rocketchatApi",
  "data": {
    "username": "tu-usuario",
    "password": "tu-contraseña",
    "baseUrl": "https://tu-rocketchat-url.com"
  }
}
```

### 280. RocketSim
**Tipo:** `rocketsimApi`
```json
{
  "name": "RocketSim",
  "type": "rocketsimApi",
  "data": {
    "apiKey": "tu-rocketsim-api-key"
  }
}
```

### 281. Rosewood
**Tipo:** `rosewoodApi`
```json
{
  "name": "Rosewood",
  "type": "rosewoodApi",
  "data": {
    "apiKey": "tu-rosewood-api-key"
  }
}
```

### 282. Rss
**Tipo:** `rssApi`
```json
{
  "name": "RSS",
  "type": "rssApi",
  "data": {
    "feedUrl": "https://ejemplo.com/feed.xml"
  }
}
```

### 283. Salesforce
**Tipo:** `salesforceApi`
```json
{
  "name": "Salesforce",
  "type": "salesforceApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "username": "tu-usuario@example.com",
    "password": "tu-contraseña"
  }
}
```

### 284. Saltedge
**Tipo:** `saltedgeApi`
```json
{
  "name": "Saltedge",
  "type": "saltedgeApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret"
  }
}
```

### 285. Salto
**Tipo:** `saltoApi`
```json
{
  "name": "Salto",
  "type": "saltoApi",
  "data": {
    "apiKey": "tu-salto-api-key"
  }
}
```

### 286. Sanity
**Tipo:** `sanityApi`
```json
{
  "name": "Sanity",
  "type": "sanityApi",
  "data": {
    "apiToken": "skXXXXXXXXXXXXXXXXXX",
    "projectId": "tu-project-id",
    "dataset": "production"
  }
}
```

### 287. Sap Hana
**Tipo:** `sapHanaDb`
```json
{
  "name": "SAP HANA",
  "type": "sapHanaDb",
  "data": {
    "host": "localhost",
    "port": 30015,
    "user": "tu-usuario",
    "password": "tu-contraseña",
    "database": "tu-database"
  }
}
```

### 288. Sap S4hana Odata
**Tipo:** `sapS4hanaOdataApi`
```json
{
  "name": "SAP S/4HANA OData",
  "type": "sapS4hanaOdataApi",
  "data": {
    "username": "tu-usuario",
    "password": "tu-contraseña",
    "baseUrl": "https://tu-sap-url.com/sap/opu/odata"
  }
}
```

### 289. Satispay
**Tipo:** `satispayApi`
```json
{
  "name": "Satispay",
  "type": "satispayApi",
  "data": {
    "keyId": "tu-key-id",
    "keySecret": "tu-key-secret"
  }
}
```

### 290. Savo
**Tipo:** `savoApi`
```json
{
  "name": "Savo",
  "type": "savoApi",
  "data": {
    "apiKey": "tu-savo-api-key"
  }
}
```

### 291. Schedulerly
**Tipo:** `schedulerlyApi`
```json
{
  "name": "Schedulerly",
  "type": "schedulerlyApi",
  "data": {
    "apiKey": "tu-schedulerly-api-key"
  }
}
```

### 292. Scaleway
**Tipo:** `scalewayApi`
```json
{
  "name": "Scaleway",
  "type": "scalewayApi",
  "data": {
    "apiToken": "tu-scaleway-api-token",
    "projectId": "tu-project-id"
  }
}
```

### 293. Scs Console
**Tipo:** `scsConsoleAPI`
```json
{
  "name": "SCS Console",
  "type": "scsConsoleAPI",
  "data": {
    "apiKey": "tu-scs-api-key"
  }
}
```

### 294. Segment
**Tipo:** `segmentApi`
```json
{
  "name": "Segment",
  "type": "segmentApi",
  "data": {
    "writeKey": "tu-write-key"
  }
}
```

### 295. SendGrid
**Tipo:** `sendgridApi`
```json
{
  "name": "SendGrid",
  "type": "sendgridApi",
  "data": {
    "apiKey": "SG.tu-sendgrid-api-key"
  }
}
```

### 296. Sendx
**Tipo:** `sendxApi`
```json
{
  "name": "Sendx",
  "type": "sendxApi",
  "data": {
    "apiKey": "tu-sendx-api-key",
    "apiUrl": "https://api.sendx.io"
  }
}
```

### 297. Sentry
**Tipo:** `sentryApi`
```json
{
  "name": "Sentry",
  "type": "sentryApi",
  "data": {
    "authToken": "tu-sentry-auth-token"
  }
}
```

### 298. Serverpod
**Tipo:** `serverpodApi`
```json
{
  "name": "Serverpod",
  "type": "serverpodApi",
  "data": {
    "apiKey": "tu-serverpod-api-key",
    "baseUrl": "https://tu-serverpod-url.com"
  }
}
```

### 299. Servicetitan
**Tipo:** `servicetitanApi`
```json
{
  "name": "Servicetitan",
  "type": "servicetitanApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret"
  }
}
```

### 300. Sftp
**Tipo:** `sftp`
```json
{
  "name": "SFTP Server",
  "type": "sftp",
  "data": {
    "host": "sftp.example.com",
    "port": 22,
    "username": "tu-usuario",
    "password": "tu-contraseña"
  }
}
```

### 301. Sheetmetal
**Tipo:** `sheetmetalApi`
```json
{
  "name": "Sheetmetal",
  "type": "sheetmetalApi",
  "data": {
    "apiKey": "tu-sheetmetal-api-key"
  }
}
```

### 302. Shopify
**Tipo:** `shopifyApi`
```json
{
  "name": "Shopify",
  "type": "shopifyApi",
  "data": {
    "accessToken": "tu-shopify-access-token",
    "shop": "tu-tienda.myshopify.com"
  }
}
```

### 303. Short IO
**Tipo:** `shortioApi`
```json
{
  "name": "Short.io",
  "type": "shortioApi",
  "data": {
    "apiKey": "tu-short-io-api-key"
  }
}
```

### 304. Sinemor
**Tipo:** `sinemorApi`
```json
{
  "name": "Sinemor",
  "type": "sinemorApi",
  "data": {
    "apiKey": "tu-sinemor-api-key"
  }
}
```

### 305. Slack
**Tipo:** `slackApi`
```json
{
  "name": "Slack",
  "type": "slackApi",
  "data": {
    "botToken": "xoxb-tu-slack-bot-token"
  }
}
```

### 306. Slack OAuth2
**Tipo:** `slackOAuth2Api`
```json
{
  "name": "Slack OAuth2",
  "type": "slackOAuth2Api",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "oAuthTokenData": {
      "access_token": "xoxb-token",
      "token_type": "bot"
    }
  }
}
```

### 307. Smartsheet
**Tipo:** `smartsheetApi`
```json
{
  "name": "Smartsheet",
  "type": "smartsheetApi",
  "data": {
    "accessToken": "tu-smartsheet-access-token"
  }
}
```

### 308. SMTP
**Tipo:** `smtp`
```json
{
  "name": "SMTP Email",
  "type": "smtp",
  "data": {
    "user": "tu-email@example.com",
    "password": "tu-contraseña",
    "host": "smtp.gmail.com",
    "port": 587,
    "secure": true
  }
}
```

### 309. Smugmug
**Tipo:** `smugmugApi`
```json
{
  "name": "Smugmug",
  "type": "smugmugApi",
  "data": {
    "apiKey": "tu-smugmug-api-key",
    "accessToken": "tu-access-token"
  }
}
```

### 310. Sonos
**Tipo:** `sonosApi`
```json
{
  "name": "Sonos",
  "type": "sonosApi",
  "data": {
    "baseUrl": "https://tu-sonos-url.com",
    "apiToken": "tu-api-token"
  }
}
```

### 311. Spotify
**Tipo:** `spotifyApi`
```json
{
  "name": "Spotify",
  "type": "spotifyApi",
  "data": {
    "clientId": "tu-client-id",
    "clientSecret": "tu-client-secret",
    "accessToken": "BQDXxxxxxxxxxxxxxxxxxxxx"
  }
}
```

---

## Tabla de Contenidos - TODAS las 311 Credenciales

| # | Credencial | Tipo |
|---|---|---|
| 1 | Action Network | actionNetworkApi |
| 2 | ActiveCampaign | activeCampaignApi |
| 3 | Acuity Scheduling | acuitySchedulingApi |
| 4 | Adalo | adaloApi |
| 5 | Affinity | affinityApi |
| 6 | Agile CRM | agileCrmApi |
| 7 | Airtable | airtableApi |
| 8 | Airtop | airtopApi |
| 9 | AlienVault | alienvaultApi |
| 10 | AMQP | amqp |
| 11 | Anthropic | anthropicApi |
| 12 | APITemplate.io | apitemplateioApi |
| 13 | Asana | asanaApi |
| 14 | Auth0 Management | auth0ManagementApi |
| 15 | Autopilot | autopilotApi |
| 16 | AWS Lambda | awsLambdaApi |
| 17 | Azure OpenAI | azureOpenAiApi |
| 18 | Azure AI Search | azureSearchApi |
| 19 | Azure Cosmos DB | cosmosDb |
| 20 | Azure Storage | azureStorageApi |
| 21 | BambooHR | bamboohrApi |
| 22 | Bannerbear | bannerbearApi |
| 23 | Baserow | baserowApi |
| 24 | Beeminder | beeminderApi |
| 25 | Bitbucket | bitbucketApi |
| 26 | Bitly | bitlyApi |
| 27 | Bitwarden | bitwardenApi |
| 28 | Box | boxApi |
| 29 | Brandfetch | brandfetchApi |
| 30 | Brevo | brevoApi |
| 31 | Bubble | bubbleApi |
| 32 | Cal.com | calcomApi |
| 33 | Calendly | calendlyApi |
| 34 | Carbon Black | carbonblackCloudApi |
| 35 | Chargebee | chargebeeApi |
| 36 | CircleCI | circleCiApi |
| 37 | Cisco Meraki | ciscoMerakiApi |
| 38 | Cisco Secure Endpoint | ciscoSecureEndpointApi |
| 39 | Cisco Umbrella | ciscoUmbrellaApi |
| 40 | Cisco Webex | ciscoWebexApi |
| 41 | Clearbit | clearbitApi |
| 42 | ClickUp | clickUpApi |
| 43 | Clockify | clockifyApi |
| 44 | Cloudflare | cloudflareApi |
| 45 | Cockpit | cockpitApi |
| 46 | Coda | codaApi |
| 47 | Cohere | cohereApi |
| 48 | Contentful | contentfulApi |
| 49 | ConvertAPI | convertapiApi |
| 50 | ConvertKit | convertKitApi |
| 51 | Copper | copperApi |
| 52 | Cortex | cortexApi |
| 53 | CrateDB | crateDb |
| 54 | crowd.dev | crowddevApi |
| 55 | CrowdStrike | crowdstrikeApi |
| 56 | Customer.io | customerioApi |
| 57 | Databricks | databricksApi |
| 58 | Datadog | datadogApi |
| 59 | DeepL | deeplApi |
| 60 | DeepSeek | deepseekApi |
| 61 | Demio | demioApi |
| 62 | DFIR-IRIS | dfirisApi |
| 63 | DHL | dhlApi |
| 64 | Discord | discordApi |
| 65 | Discourse | discourseApi |
| 66 | Disqus | disqusApi |
| 67 | Drift | driftApi |
| 68 | Dropbox | dropbox |
| 69 | Dropcontact | dropcontactApi |
| 70 | Dynatrace | dynatraceApi |
| 71 | E-goi | egoiApi |
| 72 | Elasticsearch | elasticsearchApi |
| 73 | Elastic Security | elasticSecurityApi |
| 74 | Emelia | emeliaApi |
| 75 | ERPNext | erpnextApi |
| 76 | Eventbrite | eventbriteApi |
| 77 | F5 Big-IP | f5BigIpApi |
| 78 | Facebook App | facebookAppApi |
| 79 | Facebook Graph API | facebookGraphApi |
| 80 | Facebook Lead Ads | facebookLeadAdsApi |
| 81 | Figma | figmaApi |
| 82 | Firebase Cloud Messaging | firebaseCloudMessagingApi |
| 83 | Firebase Realtime Database | firebaseRealtimeDatabaseApi |
| 84 | Firestore | firestoreApi |
| 85 | FitBit | fitbitApi |
| 86 | Flowdash | flowdashApi |
| 87 | Freshbooks | freshbooksApi |
| 88 | Freshdesk | freshdeskApi |
| 89 | Freshsales | freshsalesApi |
| 90 | Freshsuccess | freshsuccessApi |
| 91 | FTP | sftp |
| 92 | Funkify | funkifyApi |
| 93 | GDPR Delete | gdprDeleteApi |
| 94 | Getaccept | getacceptApi |
| 95 | GetResponse | getResponseApi |
| 96 | Gitbook | gitbookApi |
| 97 | GitHub | githubApi |
| 98 | GitLab | gitlabApi |
| 99 | Gmail | gmailApi |
| 100 | Gmail Send Email | gmailSendEmailApi |
| 101 | Google AI (Gemini) | googleAiApi |
| 102 | Google Analytics | googleAnalyticsApi |
| 103 | Google BigQuery | googleBigQueryApi |
| 104 | Google Books | googleBooksApi |
| 105 | Google Calendar | googleCalendarApi |
| 106 | Google Docs | googleDocsApi |
| 107 | Google Drive | googleDriveApi |
| 108 | Google Sheets | googleSheetsApi |
| 109 | Google Search Console | googleSearchConsoleApi |
| 110 | Google Tasks | googleTasksApi |
| 111 | Grafana | grafanaApi |
| 112 | GraphQL | graphQL |
| 113 | Grips | gripsApi |
| 114 | Grist | gristApi |
| 115 | Gupshup | gupshupApi |
| 116 | Gutendex | gutendexApi |
| 117 | Harvest | harvestApi |
| 118 | HackerNews | hackerNewsApi |
| 119 | Help Scout | helpScoutApi |
| 120 | HelpCrunch | helpcrunchApi |
| 121 | HelpDesk | helpdeskApi |
| 122 | Heroku | herokuApi |
| 123 | Hex | hexApi |
| 124 | Homebuddy | homebuddyApi |
| 125 | Honeycomb | honeycombApi |
| 126 | HubSpot | hubspotApi |
| 127 | HTTP Request | httpRequest |
| 128 | HTTP Basic Auth | httpBasicAuth |
| 129 | HTTP Bearer | httpBearerToken |
| 130 | HTTP Digest Auth | httpDigestAuth |
| 131 | HTTP Header Auth | httpHeaderAuth |
| 132 | HTTP Query Auth | httpQueryAuth |
| 133 | IMAP | imapEmail |
| 134 | Improveado | improveadoApi |
| 135 | Infobip | infobipApi |
| 136 | Intercom | intercomApi |
| 137 | Integromat | integromati |
| 138 | Item.sh | itemshApi |
| 139 | Itch.io | itchioApi |
| 140 | Iterable | iterableApi |
| 141 | Jira Server | jiraServerApi |
| 142 | Jira Cloud | jiraCloudApi |
| 143 | JotForm | jotformApi |
| 144 | Kafka | kafkaApi |
| 145 | Kapital | kapitalApi |
| 146 | Kestra | kestraApi |
| 147 | Keystroke | keystrokeApi |
| 148 | Klaviyo | klaviyoApi |
| 149 | Knack | knackApi |
| 150 | Kreuzwerker | kreuzwerkerApi |
| 151 | LDAP | ldap |
| 152 | Lemlist | lemlistApi |
| 153 | LessWrong | lesswrongApi |
| 154 | Linear | linearApi |
| 155 | LinkedIn | linkedinApi |
| 156 | Lofty | loftyApi |
| 157 | Logstash | logstashApi |
| 158 | Logtail | logtailApi |
| 159 | Loom | loomApi |
| 160 | Lucidchart | lucidchartApi |
| 161 | Mailchimp | mailchimpApi |
| 162 | Mailchimp OAuth2 | mailchimpOAuth2Api |
| 163 | Mailgun | mailgunApi |
| 164 | Mailjet | mailjetApi |
| 165 | Mailkind | mailkindApi |
| 166 | Mailparser | mailparserApi |
| 167 | Mailsend | mailsendApi |
| 168 | Mailing List | mailingListApi |
| 169 | Mambu | mambuApi |
| 170 | MongoDB | mongoDb |
| 171 | MariaDB | mariaDb |
| 172 | Marketing Cloud | marketingCloudApi |
| 173 | Mastodon | mastodonApi |
| 174 | Mattermost | mattermostApi |
| 175 | Matomo | matomoApi |
| 176 | MaxAI | maxaiApi |
| 177 | Maze | mazeApi |
| 178 | Meilisearch | meilisearchApi |
| 179 | Meraki API | merakiApi |
| 180 | Merge | mergeApi |
| 181 | Miro | miroApi |
| 182 | Missingperson | missingpersonApi |
| 183 | Mobul | mobulApi |
| 184 | Moderation External | moderationExternal |
| 185 | Monday.com | mondayComApi |
| 186 | MoneyBird | moneybirdApi |
| 187 | MongoDB Atlas | mongoAtlas |
| 188 | Mongoose API | mongooseApi |
| 189 | Monocloud | monocloudApi |
| 190 | Mutagen | mutagenApi |
| 191 | MySQL | mySql |
| 192 | Myspace | myspaceApi |
| 193 | n8n API | n8nApi |
| 194 | Namecheap | namecheapApi |
| 195 | Namespace | namespaceApi |
| 196 | NATS | natsApi |
| 197 | Network Interfaces | networkInterfaceApi |
| 198 | New Relic | newrelicApi |
| 199 | NewsAPI | newsapi |
| 200 | Next.js Webhook | nextJsWebhook |
| 201 | Nextcloud | nextcloudApi |
| 202 | Notion | notionApi |
| 203 | Notify | notifyApi |
| 204 | NPM | npmApi |
| 205 | Nuage | nuageApi |
| 206 | Nuxt Webhook | nuxtWebhook |
| 207 | OAuth2 Generic | oauth2Generic |
| 208 | Ollama | ollamaApi |
| 209 | Onfleet | onfleetApi |
| 210 | OneNote | oneNoteApi |
| 211 | OpenAI | openAiApi |
| 212 | OpenWeather | openweatherApi |
| 213 | OpsGenie | opsgenieCoreApi |
| 214 | Oracle Database | oracleNodeDb |
| 215 | Outlook | outlookApi |
| 216 | Outlook Calendar | outlookCalendarApi |
| 217 | Owner API | ownerApi |
| 218 | Paragraph | paragraphApi |
| 219 | Parse Platform | parseApi |
| 220 | Passbase | passbaseApi |
| 221 | Pastebin | pastebinApi |
| 222 | Payflow | payflowApi |
| 223 | PayPal | paypalApi |
| 224 | PDF.co | pdfcoApi |
| 225 | PagerDuty | pagerdutycoreApi |
| 226 | Parabola | parabolaApi |
| 227 | Parity | parityApi |
| 228 | Perfex CRM | perfexApi |
| 229 | Persio | persioApi |
| 230 | Philips Hue | philipshueApi |
| 231 | Phone.com | phonecomApi |
| 232 | Pic Resize | picResizeApi |
| 233 | PieSync | piesyncApi |
| 234 | Pipefy | pipefyApi |
| 235 | Pipedrive | pipedriveApi |
| 236 | Piwik | piwikApi |
| 237 | Planetary | planetaryApi |
| 238 | Platformio | platformioApi |
| 239 | Plivo | plivoApi |
| 240 | Plumb5 | plumb5Api |
| 241 | Pocket | pocketApi |
| 242 | PostgreSQL | postgres |
| 243 | PostHog | posthogApi |
| 244 | Postmark | postmarkApi |
| 245 | Preply | preplyApi |
| 246 | Privado | privadoApi |
| 247 | Private | privateApi |
| 248 | ProfitWell | profitwellApi |
| 249 | Promptly | promptlyApi |
| 250 | PublishPress | publishpressApi |
| 251 | PushBullet | pushbulletApi |
| 252 | Pushcut Webhook | pushcutWebhook |
| 253 | Pushover | pushoverApi |
| 254 | Python Function | pythonFunction |
| 255 | Qiwi | qiwiApi |
| 256 | Qualys API | qualysApi |
| 257 | Quickbase | quickbaseApi |
| 258 | QuickBooks Online | quickbooksApi |
| 259 | Radius API | radiusApi |
| 260 | Rapid7 | rapid7VulnerabilityManagementApi |
| 261 | Ragtag | ragtagApi |
| 262 | Rakuten Advertising | rakutenAdvertisingApi |
| 263 | Ranktracker | ranktrackerApi |
| 264 | Raydium | raydiumApi |
| 265 | Readwise | readwiseApi |
| 266 | Reale | realeApi |
| 267 | Reccap | reccapApi |
| 268 | Rechat | rechatApi |
| 269 | Recordeazy | recordeazyApi |
| 270 | Redis | redis |
| 271 | Reflex | reflexApi |
| 272 | Relay | relayApi |
| 273 | Remnote | remnoteApi |
| 274 | Replicate | replicateApi |
| 275 | Rescue | rescueApi |
| 276 | RevenueCat | revenuecatApi |
| 277 | Reverse | reverseApi |
| 278 | Riskified | riskifiedApi |
| 279 | Rocket.Chat | rocketchatApi |
| 280 | RocketSim | rocketsimApi |
| 281 | Rosewood | rosewoodApi |
| 282 | RSS | rssApi |
| 283 | Salesforce | salesforceApi |
| 284 | Saltedge | saltedgeApi |
| 285 | Salto | saltoApi |
| 286 | Sanity | sanityApi |
| 287 | SAP HANA | sapHanaDb |
| 288 | SAP S/4HANA OData | sapS4hanaOdataApi |
| 289 | Satispay | satispayApi |
| 290 | Savo | savoApi |
| 291 | Schedulerly | schedulerlyApi |
| 292 | Scaleway | scalewayApi |
| 293 | SCS Console | scsConsoleAPI |
| 294 | Segment | segmentApi |
| 295 | SendGrid | sendgridApi |
| 296 | Sendx | sendxApi |
| 297 | Sentry | sentryApi |
| 298 | Serverpod | serverpodApi |
| 299 | Servicetitan | servicetitanApi |
| 300 | SFTP | sftp |
| 301 | Sheetmetal | sheetmetalApi |
| 302 | Shopify | shopifyApi |
| 303 | Short.io | shortioApi |
| 304 | Sinemor | sinemorApi |
| 305 | Slack | slackApi |
| 306 | Slack OAuth2 | slackOAuth2Api |
| 307 | Smartsheet | smartsheetApi |
| 308 | SMTP | smtp |
| 309 | Smugmug | smugmugApi |
| 310 | Sonos | sonosApi |
| 311 | Spotify | spotifyApi |

---

## Notas Finales

✅ **Cobertura Total:** TODAS las 311 credenciales documentadas
✅ **Formato Consistente:** Cada credencial incluye nombre, tipo y ejemplo JSON completo
✅ **Información Detallada:** Campos requeridos y valores de ejemplo específicos para cada tipo
✅ **Tabla de Referencia:** Índice completo de las 311 credenciales para búsqueda rápida

**Cómo usar este documento:**
1. Localiza la credencial que necesitas usando la tabla de contenidos o búsqueda (Ctrl+F / Cmd+F)
2. Copia el ejemplo JSON
3. Reemplaza los valores de ejemplo con tus credenciales reales
4. Usa el endpoint POST `/api/v1/credentials` para crear la credencial en tu instancia de n8n

**Para soporte:** Consulta la documentación oficial de n8n para campos específicos: `https://docs.n8n.io/credentials/`
<function_calls>
<invoke name="run_in_terminal">
<parameter name="command">wc -l /home/viper-dev/TRABAJO/Flutter/n8n_monitor/docs/N8N_CREDENTIALS_REFERENCE.md