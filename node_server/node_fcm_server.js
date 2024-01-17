var admin = require('firebase-admin')
var serviceAccount = require('./server_key.json')  // firebase에서 생성한 비공개키 파일명

admin.initializeApp({
	credential: admin.credential.cert(serviceAccount)
})

var token = "d62NQ5uDTuKe6VPc6okcci:APA91bETveNNUlXqfKVCtb7zv-NYukgq-Nn09in875YmTH7S13vy3ORbSEcnDPnfJ51_Xg_r7_v8WLdelaLZhtJeYa8loUjncfsIGZnqy8xyKp5gYdAMS-g7gJvi34wU1O3kE58jOhSE"	// device token

//var token = "fxD9upmJQneHs6iyR8Cg20:APA91bGoU2PCzP7PqG4NcAwbaTtP5tVK9UUBak5JBqxn8NO_KntlUc9jMAa8ZY0xnnfipB3EBMn9s6LUPGbvYglKy001g4agTZtvbR9SSijjFdh3-41SOBF6LyByNOBgHTfVL7ZrjsKb"	// emulation 1 token

//var token = "cY5kt5k0RZqzh-BUmzniqc:APA91bEulsCTonDKXlCL5YUyllFD_j5fT18ssaGvZA7iVGZ_2VJJ3Vd-VIdpZZ1OkMK_Tl_ADJVvh3-D3j42N7ifkPQt1gZODixW821kLloyL64ILErkpB1LPXY4EIWLgm_GRp4q8ZQ_"		// emulation 2 token


var fcm_message = {
	notification: {
		title: 'terminated, background',
		body: 'test message',
	},
	data: {
		title: 'foreground',
		value: 'test message'
	},
	token: token
}

admin.messaging().send(fcm_message)
	.then(function(response){
		console.log('send ok')
	})
	.catch(function(error){
		console.log('send error')
	})