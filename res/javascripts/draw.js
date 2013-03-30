function draw(){
	var ctx = document.getElementById().getContext('2d');
	var img = new Image();
	img.onload = function(){
		ctx.drawImage(img, 500, 500);
	}
	img.src = 'res/images/pixel_zombies.png';
	console.debug('done');
}