// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Array.prototype.numbers_only = function() {
	var out = [];
	for(i in this) {
		if (!isNaN(Number(this[i]))) {
			out.push(this[i]);
		}
		
	}
	return out
}

Array.prototype.avg = function() {
	var arry = this.numbers_only();
	var av = 0;
	var cnt = 0;
	var len = arry.length;
	for (var i = 0; i < len; i++) {
		var e = +arry[i];
		if(!e && arry[i] !== 0 && arry[i] !== '0') e--;
		if (arry[i] == e) {av += e; cnt++;}
	}
	return av/cnt;
}

Array.prototype.median = function() {
	var sorted = this.numbers_only().sort(function(a,b){return a-b;});
	var middle = sorted.length / 2;
	if(sorted.length == 1) {
		return sorted[0];
	}
	if(middle % 2) {
		var a = Math.ceil(middle)
		var b = a-1;
		return (sorted[b] + sorted[a]) / 2;
	}else{
		return sorted[middle];
	}
}

Array.prototype.max = function() {
	var sorted = this.numbers_only().sort(function(a,b){return a-b;});
	return sorted[sorted.length - 1];
}

Array.prototype.min = function() {
	var sorted = this.numbers_only().sort(function(a,b){return a-b;});
	return sorted[0];
}

Array.prototype.variance = function() {
	var arry = this.numbers_only();
	var n = 0.0;
	var mean = 0.0;
	var s = 0.0;
	for (var i = 0; i < arry.length; i++) {
		var delta = 0.0;
		var x = Number(arry[i]);
		n = n + 1;
		delta = x - mean;
		mean = mean + (delta / n);
		s = s + delta * (x - mean)
	}
	return s / n;
}

Array.prototype.std = function() {
	return Math.sqrt(this.variance());
}
Array.prototype.mode = function() {
	var sorted = this.numbers_only().sort(function(a,b){return a-b;});
	var map = {};
	for (var i = 0; i < sorted.length; i++) {
		if(map[sorted[i]] === undefined) {
			map[sorted[i]] = 1;
		}else{
			map[sorted[i]] = map[sorted[i]] + 1;
		}
	}
	var order = []
	$.each(map, function(k,v){
		order.push([k,v]);
	});
	order.sort(function(a,b) {return a[1] - b[1];});
	return order[order.length - 1][0];
}