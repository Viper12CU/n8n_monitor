

import 'package:n8n_monitor/utils/execution_helpers.dart';


void main () {
final execution = [

        {
            "id": "321",
            "finished": true,
            "mode": "webhook",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T20:04:30.404Z",
            "stoppedAt": "2026-01-12T20:04:32.724Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "320",
            "finished": true,
            "mode": "webhook",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T20:03:27.681Z",
            "stoppedAt": "2026-01-12T20:03:31.346Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "319",
            "finished": true,
            "mode": "webhook",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T16:41:36.316Z",
            "stoppedAt": "2026-01-12T16:41:40.439Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "318",
            "finished": true,
            "mode": "webhook",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T16:27:07.992Z",
            "stoppedAt": "2026-01-12T16:27:10.934Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "317",
            "finished": true,
            "mode": "webhook",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T16:12:50.395Z",
            "stoppedAt": "2026-01-12T16:12:53.013Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "316",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T16:08:08.423Z",
            "stoppedAt": "2026-01-12T16:08:11.282Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "315",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-12T16:07:49.857Z",
            "stoppedAt": "2026-01-12T16:07:50.033Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "314",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T16:07:25.732Z",
            "stoppedAt": "2026-01-12T16:07:29.750Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "313",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-12T16:06:40.267Z",
            "stoppedAt": "2026-01-12T16:06:40.425Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "312",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T16:06:20.116Z",
            "stoppedAt": "2026-01-12T16:06:25.145Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "311",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T16:05:07.687Z",
            "stoppedAt": "2026-01-12T16:05:09.946Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "310",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-12T16:03:51.417Z",
            "stoppedAt": "2026-01-12T16:03:51.562Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "309",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T16:03:22.432Z",
            "stoppedAt": "2026-01-12T16:03:25.455Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "308",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-12T16:02:38.442Z",
            "stoppedAt": "2026-01-12T16:02:38.746Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "307",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T16:02:19.660Z",
            "stoppedAt": "2026-01-12T16:02:21.392Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "306",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T15:58:54.488Z",
            "stoppedAt": "2026-01-12T15:58:56.673Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "305",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T15:57:46.390Z",
            "stoppedAt": "2026-01-12T15:57:48.587Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "304",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-12T15:57:10.548Z",
            "stoppedAt": "2026-01-12T15:57:10.564Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "303",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T15:57:04.682Z",
            "stoppedAt": "2026-01-12T15:57:05.979Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "302",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-12T15:56:47.938Z",
            "stoppedAt": "2026-01-12T15:56:47.972Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "301",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-12T15:55:42.159Z",
            "stoppedAt": "2026-01-12T15:55:43.884Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "300",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-12T15:55:24.767Z",
            "stoppedAt": "2026-01-12T15:55:24.784Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "299",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-12T15:54:47.870Z",
            "stoppedAt": "2026-01-12T15:54:49.769Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "298",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-12T15:54:03.908Z",
            "stoppedAt": "2026-01-12T15:54:07.542Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "291",
            "finished": true,
            "mode": "webhook",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T15:07:48.289Z",
            "stoppedAt": "2026-01-08T15:07:53.696Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "290",
            "finished": false,
            "mode": "webhook",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T15:07:11.040Z",
            "stoppedAt": "2026-01-08T15:07:13.289Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "289",
            "finished": true,
            "mode": "webhook",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T15:06:19.718Z",
            "stoppedAt": "2026-01-08T15:06:31.376Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "288",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T14:49:38.226Z",
            "stoppedAt": "2026-01-08T14:49:42.906Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "287",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T14:49:21.162Z",
            "stoppedAt": "2026-01-08T14:49:21.172Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "286",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T14:49:06.339Z",
            "stoppedAt": "2026-01-08T14:49:06.358Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "285",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T14:49:03.133Z",
            "stoppedAt": "2026-01-08T14:49:03.150Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "284",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T14:48:43.166Z",
            "stoppedAt": "2026-01-08T14:48:49.996Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "283",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T14:48:29.318Z",
            "stoppedAt": "2026-01-08T14:48:29.423Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "282",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T14:48:20.384Z",
            "stoppedAt": "2026-01-08T14:48:20.474Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "281",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T14:48:03.297Z",
            "stoppedAt": "2026-01-08T14:48:05.993Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "280",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T14:47:50.912Z",
            "stoppedAt": "2026-01-08T14:47:51.007Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "279",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T14:47:35.758Z",
            "stoppedAt": "2026-01-08T14:47:35.849Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "278",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T14:47:15.165Z",
            "stoppedAt": "2026-01-08T14:47:15.986Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "277",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T14:47:04.802Z",
            "stoppedAt": "2026-01-08T14:47:04.811Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "276",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T14:45:49.684Z",
            "stoppedAt": "2026-01-08T14:45:51.721Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "275",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T14:45:21.102Z",
            "stoppedAt": "2026-01-08T14:45:21.898Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "274",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T14:42:48.060Z",
            "stoppedAt": "2026-01-08T14:42:48.077Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "273",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T14:39:37.312Z",
            "stoppedAt": "2026-01-08T14:39:37.333Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "272",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T14:37:39.638Z",
            "stoppedAt": "2026-01-08T14:37:39.653Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "271",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T14:35:39.444Z",
            "stoppedAt": "2026-01-08T14:35:39.478Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "270",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T14:35:13.511Z",
            "stoppedAt": "2026-01-08T14:35:13.521Z",
            "workflowId": "vIb0xyCcnFIuRfSS",
            "waitTill": null
        },
        {
            "id": "269",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T13:59:07.146Z",
            "stoppedAt": "2026-01-08T13:59:09.274Z",
            "workflowId": "KKhqxgKoMSEhZ2v4",
            "waitTill": null
        },
        {
            "id": "268",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T13:58:35.489Z",
            "stoppedAt": "2026-01-08T13:58:36.664Z",
            "workflowId": "KKhqxgKoMSEhZ2v4",
            "waitTill": null
        },
        {
            "id": "267",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T13:57:07.694Z",
            "stoppedAt": "2026-01-08T13:57:08.511Z",
            "workflowId": "KKhqxgKoMSEhZ2v4",
            "waitTill": null
        },
        {
            "id": "266",
            "finished": false,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "error",
            "startedAt": "2026-01-08T13:55:54.819Z",
            "stoppedAt": "2026-01-08T13:55:55.076Z",
            "workflowId": "KKhqxgKoMSEhZ2v4",
            "waitTill": null
        },
        {
            "id": "265",
            "finished": true,
            "mode": "manual",
            "retryOf": null,
            "retrySuccessId": null,
            "status": "success",
            "startedAt": "2026-01-08T13:51:42.397Z",
            "stoppedAt": "2026-01-08T13:51:44.685Z",
            "workflowId": "KKhqxgKoMSEhZ2v4",
            "waitTill": null
        }
    ];



final result = organizeExecutionsByDate(execution);

print('Resultados organizados:');
  result.forEach((category, items) {
    print('\n$category (${items.length} items):');
    for (var item in items) {
      print('  - ID: ${item['id']}, Status: ${item['status']}, Hora: ${item['formattedTime']}');
    }
  });

  


}



