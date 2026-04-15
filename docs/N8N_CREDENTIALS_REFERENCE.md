# Referencia Completa de Credenciales en n8n

**Fecha de actualización:** 15 de abril de 2026  
**Total de credenciales:** 311

---

## Descripción

Este documento contiene una lista exhaustiva de TODAS las credenciales disponibles en n8n, sin exclusiones. Cada credencial corresponde a una integración específica que permite autenticar y conectar n8n con servicios externos.

## Crear Credenciales via API

### Estructura Base para Crear una Credencial

Para crear cualquier credencial usando la n8n API, necesitas hacer un request `POST` a `/credentials` con la siguiente estructura JSON:

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

### Parámetros Requeridos
- **name** (string): Nombre descriptivo para la credencial
- **type** (string): Tipo de credencial (ver lista abajo)
- **data** (object): Objeto JSON con los campos específicos de autenticación

### Obtener el Schema de una Credencial

Para conocer exactamente qué campos son necesarios para una credencial específica:

```bash
GET /api/v1/credentials/schema/{credentialTypeName}
```

**Ejemplo:**
```bash
curl http://localhost:5678/api/v1/credentials/schema/githubApi
```

---

## Campos Requeridos por Tipo de Credencial

---

## Lista Completa de Credenciales (Orden Alfabético)

### A
1. Action Network credentials
2. ActiveCampaign credentials
3. Acuity Scheduling credentials
4. Adalo credentials
5. Affinity credentials
6. Agile CRM credentials
7. Airtable credentials
8. Airtop credentials
9. AlienVault credentials
10. AMQP credentials
11. Anthropic credentials
12. APITemplate.io credentials
13. Asana credentials
14. Auth0 Management credentials
15. Autopilot credentials
16. AWS credentials (IAM)
17. Azure OpenAI credentials
18. Azure AI Search credentials
19. Azure Cosmos DB credentials
20. Azure Storage credentials

### B
21. BambooHR credentials
22. Bannerbear credentials
23. Baserow credentials
24. Beeminder credentials
25. Bitbucket credentials
26. Bitly credentials
27. Bitwarden credentials
28. Box credentials
29. Brandfetch credentials
30. Brevo credentials
31. Bubble credentials

### C
32. Cal.com credentials
33. Calendly credentials
34. Carbon Black credentials
35. Chargebee credentials
36. CircleCI credentials
37. Cisco Meraki credentials
38. Cisco Secure Endpoint credentials
39. Cisco Umbrella credentials
40. Cisco Webex credentials
41. Clearbit credentials
42. ClickUp credentials
43. Clockify credentials
44. Cloudflare credentials
45. Cockpit credentials
46. Coda credentials
47. Cohere credentials
48. Contentful credentials
49. ConvertAPI credentials
50. ConvertKit credentials
51. Copper credentials
52. Cortex credentials
53. CrateDB credentials
54. crowd.dev credentials
55. CrowdStrike credentials
56. Customer.io credentials

### D
57. Databricks credentials
58. Datadog credentials
59. DeepL credentials
60. DeepSeek credentials
61. Demio credentials
62. DFIR-IRIS credentials
63. DHL credentials
64. Discord credentials
65. Discourse credentials
66. Disqus credentials
67. Drift credentials
68. Dropbox credentials
69. Dropcontact credentials
70. Dynatrace credentials

### E
71. E-goi credentials
72. Elasticsearch credentials
73. Elastic Security credentials
74. Emelia credentials
75. ERPNext credentials
76. Eventbrite credentials

### F
77. F5 Big-IP credentials
78. Facebook App credentials
79. Facebook Graph API credentials
80. Facebook Lead Ads credentials
81. Figma credentials
82. FileMaker credentials
83. Filescan credentials
84. Flow credentials
85. Form.io Trigger credentials
86. Formstack Trigger credentials
87. Fortinet FortiGate credentials
88. Freshdesk credentials
89. Freshservice credentials
90. Freshworks CRM credentials
91. FTP credentials

### G
92. GetResponse credentials
93. Ghost credentials
94. Git credentials
95. GitHub credentials
96. GitLab credentials
97. Gong credentials
98. Google credentials (OAuth2 single service)
99. Google OAuth2 generic
100. Google Service Account
101. Google Gemini/PaLM credentials
102. Gotify credentials
103. GoToWebinar credentials
104. Grafana credentials
105. Grist credentials
106. Groq credentials
107. Gumroad credentials

### H
108. HaloPSA credentials
109. Harvest credentials
110. Help Scout credentials
111. HighLevel credentials
112. Home Assistant credentials
113. HTTP Request credentials
114. HubSpot credentials
115. Hugging Face credentials
116. Humantic AI credentials
117. Hunter credentials
118. Hybrid Analysis credentials

### I
119. IMAP credentials (Gmail, Outlook.com, Yahoo)
120. Imperva WAF credentials
121. Intercom credentials
122. Invoice Ninja credentials
123. Iterable credentials

### J
124. Jenkins credentials
125. Jina AI credentials
126. Jira credentials
127. Jotform credentials
128. JWT credentials

### K
129. Kafka credentials
130. Keap credentials
131. Kibana credentials
132. Kitemaker credentials
133. KoboToolbox credentials

### L
134. LDAP credentials
135. Lemlist credentials
136. Lemonade credentials
137. Line credentials
138. Linear credentials
139. LingvaNex credentials
140. LinkedIn credentials
141. LoneScale credentials

### M
142. Magento 2 credentials
143. Mailcheck credentials
144. Mailchimp credentials
145. MailerLite credentials
146. Mailgun credentials
147. Mailjet credentials
148. Malcore credentials
149. Mandrill credentials
150. Marketstack credentials
151. Matrix credentials
152. Mattermost credentials
153. Mautic credentials
154. Medium credentials
155. MessageBird credentials
156. Metabase credentials
157. Microsoft credentials (OAuth2)
158. Microsoft Azure Monitor credentials
159. Microsoft Entra ID credentials
160. Microsoft SQL credentials
161. Microsoft Agent 365 credentials
162. Milvus credentials
163. Mindee credentials
164. Miro credentials
165. MISP credentials
166. Mist credentials
167. Mistral Cloud credentials
168. Mocean credentials
169. monday.com credentials
170. MongoDB credentials
171. Monica CRM credentials
172. Motorhead credentials
173. MQTT credentials
174. MSG91 credentials
175. MySQL credentials

### N
176. NASA credentials
177. Netlify credentials
178. Netscaler ADC credentials
179. Nextcloud credentials
180. NocoDB credentials
181. Notion credentials
182. npm credentials

### O
183. Odoo credentials
184. Okta credentials
185. Ollama credentials
186. One Simple API credentials
187. Onfleet credentials
188. OpenAI credentials
189. OpenCTI credentials
190. OpenRouter credentials
191. OpenWeatherMap credentials
192. Oracle Database credentials
193. Oura credentials

### P
194. Paddle credentials
195. PagerDuty credentials
196. PayPal credentials
197. Peekalink credentials
198. Perplexity credentials
199. PhantomBuster credentials
200. Philips Hue credentials
201. Chroma credentials
202. Pinecone credentials
203. Pipedrive credentials
204. Plivo credentials
205. Postgres credentials
206. PostHog credentials
207. Postmark credentials
208. ProfitWell credentials
209. Pushbullet credentials
210. Pushcut credentials
211. Pushover credentials

### Q
212. QRadar credentials
213. Qdrant credentials
214. Qualys credentials
215. QuestDB credentials
216. Quick Base credentials
217. QuickBooks credentials

### R
218. RabbitMQ credentials
219. Raindrop credentials
220. Rapid7 InsightVM credentials
221. Recorded Future credentials
222. Reddit credentials
223. Redis credentials
224. Rocket.Chat credentials
225. Rundeck credentials

### S
226. S3 credentials
227. Salesforce credentials
228. Salesmate credentials
229. SearXNG credentials
230. SeaTable credentials
231. SecurityScorecard credentials
232. Segment credentials
233. Sekoia credentials
234. Send Email credentials (Gmail, Outlook.com, Yahoo)
235. SendGrid credentials
236. Sendy credentials
237. Sentry.io credentials
238. Serp credentials
239. ServiceNow credentials
240. seven credentials (SMS77)
241. Shopify credentials
242. Shuffler credentials
243. SIGNL4 credentials
244. Slack credentials
245. Snowflake credentials
246. SolarWinds IPAM credentials
247. SolarWinds Observability SaaS credentials
248. Splunk credentials
249. Spotify credentials
250. SSH credentials
251. Stackby credentials
252. Storyblok credentials
253. Strapi credentials
254. Strava credentials
255. Stripe credentials
256. Supabase credentials
257. SurveyMonkey credentials
258. SyncroMSP credentials
259. Sysdig credentials

### T
260. Taiga credentials
261. Tapfiliate credentials
262. Telegram credentials
263. TheHive credentials
264. TheHive 5 credentials
265. TimescaleDB credentials
266. Todoist credentials
267. Toggl credentials
268. TOTP credentials
269. Travis CI credentials
270. Trellix ePO credentials
271. Trello credentials
272. Twake credentials
273. Twilio credentials
274. Twist credentials
275. Typeform credentials

### U
276. Unleashed Software credentials
277. UpLead credentials
278. uProc credentials
279. UptimeRobot credentials
280. urlscan.io credentials

### V
281. Venafi TLS Protect Cloud credentials
282. Venafi TLS Protect Datacenter credentials
283. Vercel AI Gateway credentials
284. Vero credentials
285. VirusTotal credentials
286. Vonage credentials

### W
287. Weaviate credentials
288. Webex by Cisco credentials
289. Webflow credentials
290. Webhook credentials
291. Wekan credentials
292. WhatsApp Business Cloud credentials
293. Wise credentials
294. Wolfram|Alpha credentials
295. WooCommerce credentials
296. WordPress credentials
297. Workable credentials
298. Wufoo credentials

### X
299. X (formerly Twitter) credentials
300. xAI credentials
301. Xata credentials
302. Xero credentials

### Y
303. Yourls credentials

### Z
304. Zabbix credentials
305. Zammad credentials
306. Zendesk credentials
307. Zep credentials
308. Zoho credentials
309. Zoom credentials
310. Zscaler ZIA credentials
311. Zulip credentials

---

## Ejemplos de Credenciales y sus Campos

### Credenciales Comunes - Campos Requeridos

#### 1. **GitHub credentials** (`githubApi`)
```json
{
  "name": "Mi GitHub",
  "type": "githubApi",
  "data": {
    "accessToken": "tu_token_personal_github"
  }
}
```

#### 2. **Slack credentials** (`slackApi`)
```json
{
  "name": "Mi Slack",
  "type": "slackApi",
  "data": {
    "accessToken": "xoxb-tu-token-slack"
  }
}
```

#### 3. **AWS credentials** (`awsEc2Api`)
```json
{
  "name": "Mis Credenciales AWS",
  "type": "awsEc2Api",
  "data": {
    "accessKeyId": "AKIAIOSFODNN7EXAMPLE",
    "secretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
    "region": "us-east-1"
  }
}
```

#### 4. **Google OAuth2 credentials** (`googleOAuth2Api`)
```json
{
  "name": "Mi Google",
  "type": "googleOAuth2Api",
  "data": {
    "clientId": "tu-client-id.apps.googleusercontent.com",
    "clientSecret": "tu-client-secret",
    "oauthTokenData": {
      "access_token": "ya29.xxxxx",
      "refresh_token": "1//xxxxx",
      "token_type": "Bearer",
      "expiry_date": 1234567890
    }
  }
}
```

#### 5. **Microsoft credentials** (`microsoftOAuth2Api`)
```json
{
  "name": "Mi Microsoft",
  "type": "microsoftOAuth2Api",
  "data": {
    "clientId": "tu-application-id",
    "clientSecret": "tu-client-secret",
    "tenantId": "tu-tenant-id",
    "oauthTokenData": {
      "access_token": "EwA...",
      "refresh_token": "M.R3_BAY...",
      "token_type": "Bearer",
      "expires_in": 3600
    }
  }
}
```

#### 6. **Airtable credentials** (`airtableApi`)
```json
{
  "name": "Mi Airtable",
  "type": "airtableApi",
  "data": {
    "accessToken": "patXXXXXXXXXXXXXXXXXX"
  }
}
```

#### 7. **Notion credentials** (`notionApi`)
```json
{
  "name": "Mi Notion",
  "type": "notionApi",
  "data": {
    "internalIntegrationToken": "secret_XXXXXXXXXXXXX"
  }
}
```

#### 8. **Stripe credentials** (`stripeApi`)
```json
{
  "name": "Mi Stripe",
  "type": "stripeApi",
  "data": {
    "apiKey": "sk_live_XXXXXXXXXXXXX"
  }
}
```

#### 9. **HTTP Request - Basic Auth**
```json
{
  "name": "Mi Autenticación Básica",
  "type": "httpBasicAuth",
  "data": {
    "username": "miusuario",
    "password": "micontraseña"
  }
}
```

#### 10. **HTTP Request - Bearer Token**
```json
{
  "name": "Bearer Token",
  "type": "httpBearerAuth",
  "data": {
    "accessToken": "mi-bearer-token"
  }
}
```

#### 11. **Postgres credentials** (`postgres`)
```json
{
  "name": "Mi Base de Datos Postgres",
  "type": "postgres",
  "data": {
    "host": "localhost",
    "port": 5432,
    "database": "mi_base_datos",
    "user": "usuario",
    "password": "contraseña",
    "ssl": "disable",
    "allowUnauthorizedCerts": false
  }
}
```

#### 12. **MySQL credentials** (`mysql`)
```json
{
  "name": "Mi MySQL",
  "type": "mysql",
  "data": {
    "host": "localhost",
    "port": 3306,
    "database": "mi_base_datos",
    "user": "usuario",
    "password": "contraseña",
    "ssl": "off"
  }
}
```

#### 13. **MongoDB credentials** (`mongo`)
```json
{
  "name": "Mi MongoDB",
  "type": "mongo",
  "data": {
    "mode": "connectionString",
    "connectionString": "mongodb+srv://usuario:contraseña@cluster.mongodb.net/base_datos"
  }
}
```

#### 14. **Twilio credentials** (`twilioApi`)
```json
{
  "name": "Mi Twilio",
  "type": "twilioApi",
  "data": {
    "accountSid": "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "authToken": "tu-auth-token"
  }
}
```

#### 15. **SendGrid credentials** (`sendgridApi`)
```json
{
  "name": "Mi SendGrid",
  "type": "sendgridApi",
  "data": {
    "apiKey": "SG.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
}
```

---

## Patrones de Autenticación Comunes

### API Key
Muchas credenciales usan un simple API Key:
```json
{
  "name": "Credencial API Key",
  "type": "apiType",
  "data": {
    "apiKey": "tu-api-key"
  }
}
```

### OAuth2 Token
Para servicios OAuth2:
```json
{
  "name": "Credencial OAuth2",
  "type": "oauth2Type",
  "data": {
    "accessToken": "token-access",
    "refreshToken": "token-refresh",
    "expiresIn": 3600
  }
}
```

### Username y Password
Para autenticación básica:
```json
{
  "name": "Credencial Usuario/Contraseña",
  "type": "basicAuthType",
  "data": {
    "username": "usuario",
    "password": "contraseña"
  }
}
```

### AWS/IAM Credentials
```json
{
  "name": "Credencial AWS",
  "type": "awsType",
  "data": {
    "accessKeyId": "AKIA...",
    "secretAccessKey": "...",
    "region": "us-east-1"
  }
}
```

---

## Procedimiento para Obtener Campos Específicos

### Paso 1: Identificar el Tipo de Credencial
Busca en la sección "Lista Completa de Credenciales" el nombre de la credencial que necesitas.

### Paso 2: Llamar al Endpoint de Schema
```bash
GET http://tu-instancia-n8n/api/v1/credentials/schema/{tipo}
```

**Ejemplo:**
```bash
curl -X GET "http://localhost:5678/api/v1/credentials/schema/notionApi" \
  -H "X-N8N-API-KEY: tu-api-key"
```

### Paso 3: Analizar la Respuesta
La respuesta contendrá un JSON Schema que describe:
- Campos requeridos (required)
- Tipo de dato de cada campo
- Valores por defecto
- Validaciones

---

## Categorización por Tipo

### Plataformas de Comunicación
- Discord, Slack, Telegram, Twilio, WhatsApp Business Cloud, Mattermost, Rocket.Chat, Microsoft Teams, Webex by Cisco, Line

### Bases de Datos
- MongoDB, MySQL, Postgres, Oracle Database, Microsoft SQL, CrateDB, QuestDB, TimescaleDB, Supabase, NocoDB, Snowflake, Databricks

### Servicios en la Nube (Cloud)
- AWS (IAM), Azure (OpenAI, Cosmos DB, Storage, AI Search, Monitor, Entra ID), Google (OAuth2, Service Account, Gemini/PaLM)

### Marketing y CRM
- Salesforce, HubSpot, Pipedrive, Monday.com, Notion, Airtable, Freshworks CRM, ActiveCampaign, Mailchimp, GetResponse, Brevo, Customer.io

### Email
- Gmail, Outlook.com, Yahoo, SendGrid, Mailgun, Mailjet, Mandrill, Postmark, Sendy

### Gestión de Proyectos
- Asana, Trello, Jira, Linear, ClickUp, monday.com, Taiga

### E-commerce
- Shopify, WooCommerce, Magento 2, Stripe, PayPal, QuickBooks

### Autenticación y Seguridad
- OAuth2, JWT, LDAP, Auth0, Okta, Microsoft Entra ID, TOTP

### Herramientas de Análisis
- Google Analytics, Datadog, New Relic (via API), PostHog, Grafana, Splunk

### Almacenamiento de Archivos
- Google Drive, Dropbox, Box, Microsoft OneDrive, AWS S3, Azure Storage, Nextcloud

### Documentación y Notas
- Google Docs, Google Sheets, Notion, Coda, Storyblok

### Bases de Datos Vectoriales
- Pinecone, Qdrant, Weaviate, Chroma, Milvus

### APIs y Utilidades Generales
- HTTP Request, GraphQL, webhooks, Git, SSH, FTP

---

## API REST para Gestionar Credenciales

### Crear una Credencial
```
POST /api/v1/credentials
```

**Request:**
```bash
curl -X POST "http://localhost:5678/api/v1/credentials" \
  -H "Content-Type: application/json" \
  -H "X-N8N-API-KEY: tu-api-key" \
  -d '{
    "name": "Mi GitHub",
    "type": "githubApi",
    "data": {
      "accessToken": "ghp_XXXXXXXX"
    }
  }'
```

**Response:**
```json
{
  "id": "vHxaz5UaCghVYl9C",
  "name": "Mi GitHub",
  "type": "githubApi",
  "createdAt": "2026-04-15T10:30:00.000Z",
  "updatedAt": "2026-04-15T10:30:00.000Z"
}
```

### Listar Todas las Credenciales
```
GET /api/v1/credentials
```

```bash
curl -X GET "http://localhost:5678/api/v1/credentials" \
  -H "X-N8N-API-KEY: tu-api-key"
```

### Obtener Schema de una Credencial
```
GET /api/v1/credentials/schema/{credentialTypeName}
```

```bash
curl -X GET "http://localhost:5678/api/v1/credentials/schema/githubApi" \
  -H "X-N8N-API-KEY: tu-api-key"
```

**Response (ejemplo):**
```json
{
  "type": "object",
  "properties": {
    "accessToken": {
      "type": "string",
      "description": "GitHub personal access token"
    }
  },
  "required": ["accessToken"],
  "additionalProperties": false
}
```

### Actualizar una Credencial
```
PATCH /api/v1/credentials/{credentialId}
```

```bash
curl -X PATCH "http://localhost:5678/api/v1/credentials/vHxaz5UaCghVYl9C" \
  -H "Content-Type: application/json" \
  -H "X-N8N-API-KEY: tu-api-key" \
  -d '{
    "name": "Mi GitHub Actualizado",
    "data": {
      "accessToken": "ghp_NUEVTOKEN"
    }
  }'
```

### Eliminar una Credencial
```
DELETE /api/v1/credentials/{credentialId}
```

```bash
curl -X DELETE "http://localhost:5678/api/v1/credentials/vHxaz5UaCghVYl9C" \
  -H "X-N8N-API-KEY: tu-api-key"
```

---

## Tabla Resumen: Credenciales por Método de Autenticación

| Método | Credenciales | Campos Típicos |
|-------|--------------|---|
| **API Key** | Slack, GitHub, Notion, Stripe, SendGrid | `apiKey` o `accessToken` |
| **OAuth2** | Google, Microsoft, Salesforce, HubSpot | `accessToken`, `refreshToken`, `clientId`, `clientSecret` |
| **Basic Auth** | HTTP Request, LDAP | `username`, `password` |
| **Bearer Token** | JWT, Custom APIs | `accessToken` o `bearerToken` |
| **Database** | PostgreSQL, MySQL, MongoDB | `host`, `port`, `database`, `user`, `password` |
| **Cloud IAM** | AWS, Azure | Region-specific keys y credenciales |

---

## Validación de Credenciales

Cuando creas una credencial vía API, n8n valida automáticamente:
1. **Campos requeridos**: Verifica que todos los campos obligatorios estén presentes
2. **Tipos de dato**: Confirma que los datos sean del tipo esperado
3. **Restricciones**: Aplica validaciones según las reglas del schema
4. **Propiedades adicionales**: Rechaza campos no definidos en el schema

Si hay error:
```json
{
  "message": "request.body.data does not match allOf schema with errors"
}
```

---

## Notas Importantes

- Esta lista está actualizada según la documentación oficial de n8n del 15 de abril de 2026
- Las credenciales se utilizan para autenticar nodos específicos en workflows
- Algunas credenciales soportan múltiples métodos de autenticación (OAuth2, API Key, etc.)
- El MCP (Model Context Protocol) de n8n proporciona acceso dinámico a esta información
- Para obtener información detallada de cada credencial, consulta: https://docs.n8n.io/integrations/builtin/credentials/
- **Importante**: Nunca incluyas tokens o claves secretas en logs o control de versiones
- Usa variables de entorno o secretos externos para gestionar credenciales en producción

---

**Total de credenciales: 311**

---

## Referencias Útiles

- API Documentation: https://docs.n8n.io/api/
- Credentials Documentation: https://docs.n8n.io/integrations/builtin/credentials/
- GitHub Credenciales Fuente: https://github.com/n8n-io/n8n/tree/master/packages/nodes-base/credentials
