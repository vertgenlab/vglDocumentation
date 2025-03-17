
















<!DOCTYPE html>
<html style="height: 100%;">
<head>
	<style>
	.center {
		background: rgba( 0, 0, 0, 0.65 );
	    position: absolute;
        top: 50%;
        left: 50%;
	    transform: translate(-50%, -50%);
	}
	.shadow { -webkit-box-shadow: 0 0 4px 6px #E7E7E7; -moz-box-shadow: 0 0 4px 6px #E7E7E7; box-shadow: 0 0 4px 6px #E7E7E7; }
	.rounded { border-radius: 8px; }
	.hand { border-radius: 8px; background:#888; height: 5px; width: 50px; position: absolute;
		transform-origin: 0% 50%; -webkit-transform-origin: 0% 50%; -ms-transform-origin: 0% 50%;
		-moz-transform-origin: 0% 50%; -o-transform-origin: 0% 50%;
		left: 75px; top: 75px;
	}
	.long { width: 75px; }
	.thin { height: 2px; }
	#clock { position: relative; width: 150px; height: 150px; margin: 0 auto;
		border-radius: 800px; -webkit-border-radius: 800px; -moz-border-radius: 800px;
		border: 1px dashed white;
	}
	#second {
		-webkit-transition: -webkit-transform 600000s linear;
		-moz-transition: -moz-transform 600000s linear;
		-o-transition: -o-transform 600000s linear;
		-ms-transition: -ms-transform 600000s linear;
		transition: transform 600000s linear;
		z-index: 4;
		background: green;
	}
	.start #second {
		-webkit-transform: rotate(3600000deg);
		-moz-transform: rotate(3600000deg);
		-o-transform: rotate(3600000deg);
		-ms-transform: rotate(3600000deg);
		-transform: rotate(3600000deg);
	}
	#minute {
		-webkit-transition: -webkit-transform 360000s linear;
		-moz-transition: -moz-transform 360000s linear;
		-o-transition: -o-transform 360000s linear;
		-ms-transition: -ms-transform 360000s linear;
		transition: transform 360000s linear;
		z-index: 2;
		background: #bbb;
	}
	.start #minute {
		-webkit-transform: rotate(36000deg);
		-moz-transform: rotate(36000deg);
		-o-transform: rotate(36000deg);
		-ms-transform: rotate(36000deg);
		transform: rotate(36000deg);
	}
	#hour {
		-webkit-transition: -webkit-transform 216000s linear;
		-moz-transition: -moz-transform 216000s linear;
		-o-transition: -o-transform 216000s linear;
		-ms-transition: -ms-transform 216000s linear;
		transition: transform 216000s linear;
		z-index: 3;
	}
	.start #hour {
		-webkit-transform: rotate(360deg);
		-moz-transform: rotate(360deg);
		-o-transform: rotate(360deg);
		-ms-transform: rotate(360deg);
		transform: rotate(360deg);
	}
	.bodybg {
        background-color: #41464c;
        height: 100%;
    }
	</style>
</head>

<body class="bodybg" style='margin: 0px;'>
	<div id='wrapper' class='center shadow rounded'>
		<img id='loader' style='margin-bottom: 20px' src="img/LoaderBarAnimated.gif">
		<div id='clock' class='shadow' style='display: none'>
			<div id='hour' class='hand'></div>
			<div id='minute' class='hand long'></div>
			<div id='second' class='hand long thin'></div>
		</div>
	</div>

	<script type="text/javascript">
	// The following is duplicated from commonHeader.jsp
	// Modify things there and duplicate here.
	(function() {
		window.log = function(msg) {
			if( console && console.log ) {
				console.log(msg);
			}
		}
		
		var style = { 
			fontSize: "14px", color: "white", fontWeight: "bold", background: "#333", textAlign: "left",
			border: "none", position: "fixed", left: "0px", right: "0px", borderColor: "white", borderStyle: "solid",
			borderWidth: "1px 0 0 0", bottom: "0px", height: "185px", zIndex: 999
		};
		
		if(typeof console == "undefined") {
			window.console = { log: function(){}, error: function(){} };
		}
		var cslog = console.log;
		var cserror = console.error;
		
		var footer = document.createElement("footer");
			var reset = document.createElement("button");
				reset.innerHTML = "Reset Log";
				reset.onclick = resetLog;
				reset.style.position = "absolute";
				reset.style.top = "1px";
				reset.style.right = "5px";
				footer.appendChild(reset);
			var header = document.createElement("header");
				header.innerHTML = "Debug Mode Enabled.  Click Here to Disable";
				header.onclick = stopDebug;
				header.style.lineHeight = 
				header.style.height = "25px";
				header.style.textAlign = "center";
				header.style.borderBottom = "1px solid white";
				header.style.cursor = "pointer";
				footer.appendChild(header);
			var body = document.createElement("pre");
				body.style.height = "150px";
				body.style.overflow = "auto";
				body.style.padding = "5px";
				footer.appendChild(body);
		
		for(var i in style) {
			footer.style[i] = style[i];
		}
		
		function resetLog() {
			localStorage.setItem("debugMessage", "");
			updateLog();
		}
		
		function updateLog() {
			body.innerHTML = localStorage.getItem("debugMessage");
			body.scrollTop = body.scrollHeight;
		}
		
		function getDebug() {
			window.debug = localStorage.getItem("debug") == "true";
			if(window.debug) {
				startDebug();
			}
		}
		
		function setDebug(enable) {
			localStorage.setItem("debug", enable? "true": false);
			getDebug();
		}
		
		function startDebug() {
			document.body.insertBefore(footer, document.body.firstChild);
			console.log = function(msg) {
				log(msg);
			}
			console.error = function(msg) {
				log("Error: " + msg);
			}
			document.body.style.paddingBottom = "400px";
			updateLog();
		}
		
		function stopDebug() {
			if(footer.parentNode) {
				footer.parentNode.removeChild(footer);
			}
			document.body.style.paddingBottom = "";
			console.log = cslog;
			console.error = cserror;
			setDebug(false);
		}
		
		function delegateLinks() {
			var handleLinks = function(evt) {
				var target = (evt = evt || window.event)? evt.target || evt.srcElement: null;
				if(target) {
					while(target.nodeName != "A" && target != document.body) {
						target = target.parentNode;
					}
					if(target.nodeName != "A") {
						target = null;
					}
				}
				if(target && target.href) {
					log("User clicked link for " + target.href);
				}
			}
			
			if(document.body.addEventListener) {
				document.body.addEventListener("click", handleLinks);
			}
			else {
				document.body.attachEvent("onclick", handleLinks);
			}
		}
		
		function delegateForms() {
			var handleForms = function(evt) {
				var target = (evt = evt || window.event)? evt.target || evt.srcElement: null;
				if(target) {
					while(target.nodeName != "FORM" && target != document.body) {
						target = target.parentNode;
					}
					if(target.nodeName != "FORM") {
						target = null;
					}
				}
				if(target) {
					var inputs = target.getElementsByTagName("input");
					var selects = target.getElementsByTagName("select");
					var textareas = target.getElementsByTagName("textarea");
					var list = [inputs, selects, textareas];
					log("Form submitted to " + target.action + " with the following values:");
					for(var i = 0; i < list.length; i++) {
						for(var j = 0; list[i] && list[i].length && j < list[i].length; j++) {
							var el = list[i][j];
							var val = el.value;
							if(el.type.toLowerCase() == "checkbox") {
								val = el.checked;
							}
							if(el.type.toLowerCase() != "password") {
								log(" - " + el.name + " : " + val);
							}
						}
					}
				}
			}
			
			if(document.body.addEventListener) {
				document.body.addEventListener("submit", handleForms);
			}
			else {
				document.body.attachEvent("onsubmit", handleForms);
			}
		}
		
		function init() {
			log("Page Loaded");
			var portal = window.location.search.indexOf("portalName=");
			if(portal > -1) {
				var end = window.location.search.indexOf("&", portal);
				if(end > -1) {
					log("Portal forced to " + window.location.search.substring(portal + 11, end));
				}
				else {
					log("Portal forced to " + window.location.search.substring(portal + 11));
				}
			}
			
			delegateLinks();
			delegateForms();
		}
		
		window.log = function(msg) {
			if(!window.debug) {
				return;
			}
			msg = new Date().toLocaleTimeString() + " " + window.location.pathname + Array(50 - window.location.pathname.length).join(" ") + ": " + msg;
			localStorage.setItem("debugMessage", (localStorage.getItem("debugMessage") || "") + msg + "\n");
			updateLog();
		}
		
		if(window.location.search.indexOf("debug=true") > -1) {
			setDebug(true);
			init();
		}
		else if(window.location.search.indexOf("debug=false") > -1) {
			stopDebug();
		}
		else {
			getDebug();
			init();
		}
	})();
	</script>

	<script type='text/javascript'>
	(function() {
	window.scopename = "vpn";

	function createRequest() {
		var axo = ["Msxml2.XMLHTTP", "Msxml3.XMLHTTP", "Microsoft.XMLHTTP"], i, l, r = null;
		if( XMLHttpRequest ) return new XMLHttpRequest();
		for( i = 0, l = axo.length; i < l && r == null; i++ )
			r = new ActiveXObject(axo[i]);
		return XMLHttpRequest? new XMLHttpRequest(): new ActiveXObject("Microsoft.XMLHTTP");
	}

	function serialize( obj ) {
		var i, s = [];
		for( i in obj ) {
			if( typeof obj[i] == "object" )
				s.push( i + "=" + JSON.stringify(obj[i]) );
			else
				s.push( i + "=" + obj[i] );
		}
		return s.join("&");
	}

	function sendRequest( params, cb ) {
		var req = createRequest();
		req.open( "POST", "/" + (scopename || "hub") + "/common/portalUserActions.jsp", true );
		req.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		req.onreadystatechange = function() {
			if( req.readyState != 4 ) return;
			cb.call( cb, req.responseText );
		}
		req.send( serialize(params) );
	}

	window.JSON = typeof window.JSON == "undefined"? {} : window.JSON;

	JSON.parse = JSON.parse || function( str ) {
		return eval('(' + str + ')');
	}

	//Based on JSON.stringify on http://www.sitepoint.com/
	JSON.stringify = JSON.stringify || function( obj ) {
		var type = typeof obj, i, v, isArray, a;
		if( obj === null || type != "object" ) {
			if( type == "string" )
				return '"' + obj + '"';
			return String(obj);
		} else {
			isArray = obj && obj instanceof Array;
			a = [];

			for( i in obj ) {
				v = obj[i];
				type = typeof v;

				if( type == "string" )
					v = '"' + v + '"';
				else if( type == "object" && v !== null )
					v = JSON.stringify(v);
				a.push( (isArray? "": '"' + i + '"') + String(v) );
			}

			return (isArray? "[": "{") + String(a) + (isArray? "]": "}");
		}
	}

	function setCookie( name, value ) {
		document.cookie = name + "=" + value + "; expires=" + ( new Date().getTime() + 15*60*1000 ) + "; path=/";
	}

	function getCookie( name ) {
		var cookies = document.cookie.split(";"),
			cookie,
			i = 0, l = cookies.length;
		for(; i < l; i++ ) {
			cookie = cookies[i].replace(/^\s+/g, "").replace(/\s+$/g, "");
			if( !cookie.indexOf(name + "=") )
				return cookie.substring( name.length+1 );
		}
		return null;
	}

	function loadRedirect() {
		var obj = {action: "setPortalName"},
			ck = getCookie( "isolationPortalName" );

		if( scopename != "hub" && ck ) {
			obj.portalName = ck;
			log("Cookie-based portal found: " + ck);
		}

		sendRequest( obj, function( res ) {
			var p;
			res = JSON.parse( res );
			if( res.success ) {
				if( scopename == "hub" )
					setCookie( "isolationPortalName", res.portalName );
				p = obj.portalName || res.portalName;
				log("Set portal request returned " + p);
			}

			sendRequest( {
				action: "getScopeRedirect",
				referer: window.location.href
			}, function( res ) {
				res = JSON.parse( res );
				if( res.success ) {
					log("Redirecting to " + res.target);
					window.location.href = res.target;
				}
			})
		})
	}

	function setClock( prop ) {
		var angle = 360/60,
			date = new Date(),
			hour = date.getHours() > 12? date.getHours()-12: date.getHours(),
			minute = date.getMinutes(),
			second = date.getSeconds(),
			hourAngle = (360/12) * hour + (360/(12*60)) * minute - 90,
			minuteAngle = angle * minute - 90,
			secondAngle = angle * second - 90;
		$("minute").style[prop] = "rotate(" + minuteAngle + "deg)";
		$("second").style[prop] = "rotate(" + secondAngle + "deg)";
		$("hour").style[prop] = "rotate(" + hourAngle + "deg)";
	} 

	function initClock(prop) {
		setClock(prop);
		$("clock").className += " start";
		if( typeof IE == "undefined" ) {
			setTimeout( function() {
				$("minute").style[prop] = "";
				$("second").style[prop] = "";
				$("hour").style[prop] = "";
			}, 0 );
		} else if( IE == 9 ) {
			var int = setInterval( function() {
				if( $("clock") )
					setClock(prop);
				else
					clearInterval(int);
			}, 1000);
		}
	}

	window.$ = function(s){ return document.getElementById(s); };
	var clock = $("clock"),
		props = 'WebkitTransform msTransform OTransform MozTransform transform'.split(' '),
		prop;

	window.onload = function() {
		loadRedirect();
	}
	
	for(var i = 0, l = props.length; i < l; i++) {
		if(typeof clock.style[props[i]] !== "undefined") {
			prop = props[i];
			break;
		}
	}

	if( prop ) {
		clock.style.display = "";
		initClock(prop);
		$("loader").style.display = "none";
	}
	})();
	</script>
	<noscript>
		<meta http-equiv="refresh" content="0;url=index-vpn.jsp">
	</noscript>
</body>
</html>
